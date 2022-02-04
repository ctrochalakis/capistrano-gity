Capistrano::Configuration.instance.load do
  namespace :gity do

    # Most people use origin here
    unless exists?(:remote)
      git_remote = `git config deploy.remote`.strip
      set :remote,  git_remote.empty? ? 'origin' : git_remote
    end

    unless exists?(:check_master)
      check_master = case `git config deploy.check-master`.strip
      when 'false', 'f', '0'
        false
      when 'true', 't', '1'
        true
      else
        true
      end

      set :check_master,  check_master
    end

    desc "Push HEAD to the central repo"
    task :push do
      system "git push --force #{remote} HEAD:#{branch}"
    end

    task :sync do
      system "git fetch #{remote}"
    end

    desc "View a graph log of the commits usually involved in a deployment"
    task :status do
      puts "\nOverview (we are deploying origin/#{branch})"
      sync
      system "git --no-pager log --decorate --graph --oneline #{remote}/#{branch} #{remote}/master --not #{remote}/#{branch}^@ --"
    end

    desc "Display where the central live branch is pointing"
    task :uptip do
      sync
      system %(git --no-pager log --decorate -1 --format="#{remote}'s #{branch} tip is set to: [%h] %s (%an, %ar)"  #{remote}/#{branch})
    end

    desc "A small overview of the deployment procedure"
    task :help do
      puts <<-HELP

      Overview:
      * Deploying the #{branch} branch of #{repository}
      * The #{branch} branch can be moved *anywhere*.

      Quick help:
      Go the branch you want to mark as #{branch} (ex. master) and run:
      cap deploy

      Under the hood:
        * git push --force #{remote} HEAD:#{branch} (or cap gity:push)
        * cap deploy

      Troubleshooting:
      cap gity:uptip # Show the #{branch} branch of the central repo
      cap gity:status # A log-like view showing important commits

      cap gity:check # check consistency between the applied revision and the one on the #{branch} branch
      HELP
    end

    task :uprev do
      run "cd #{current_path} && cat REVISION"
    end

    task :check do
      uprev
      uptip
    end

    def quit?
      return false if !check_master

      current_branch = `git symbolic-ref --short HEAD`.strip
      branch_diff_cmd = "git log #{current_branch} ^#{remote}/master --pretty=format:%h%x09%an%x09%ad%x09%s"
      unpushed_commits = `#{branch_diff_cmd}`
      if !unpushed_commits.empty?
        puts <<-MSG
        The following commits are not included in #{remote} master.
        This means that a subsequent deploy might not include your work.
        Consider pushing to master now or later.
        MSG
        puts unpushed_commits
        answer = Capistrano::CLI.ui.ask("Do you want to continue? (y/n)")
        return !answer.downcase.start_with?('y')
      end
      return false
    end

    task :prepare_deploy do
      sync
      exit 127 if quit?
      push
      uptip
    end

    before 'deploy:update_code', 'gity:prepare_deploy'

  end
end
