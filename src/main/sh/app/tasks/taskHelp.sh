help() {
    echo "USAGE"
    echo "  make.sh <task|--help> [<args>]"
    echo "  "
    echo "tasks:"
    echo "  install               --  make a full devops (re)install"
    echo "  backup                --  make configured backup modes"
    echo "  clean                 --  make a full devops and docker clean, expect /backups"
    echo "  registerGitlabRunner  --  register a gitlab runner into gitlab by configured GITLAB_RUNNER_TOKEN"
    echo "  <customTask>          --  run any custom unix command in terminal"
    echo "  "
    echo "args:"
    echo "  GITLAB_RUNNER_TOKEN   --  runner token from gitlab"
    echo "  customArgs            --  custom arguments for any <customTask>"
    echo "  "
}
