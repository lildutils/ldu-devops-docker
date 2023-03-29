####################################################
## USAGE
##   make.sh <task|--help> [<args>]
##
## tasks:
##   install               --  make a full devops (re)install
##   backup                --  make configured backup modes
##   clean                 --  make a full devops and docker clean, expect /backups
##   registerGitlabRunner  --  register a gitlab runner into gitlab by configured $GITLAB_RUNNER_TOKEN
##   <customTask>          --  run any custom unix command in terminal
##
## args:
##   GITLAB_RUNNER_TOKEN   --  runner token from gitlab
##   customArgs            --  custom arguments for any <customTask>
##
main $*
