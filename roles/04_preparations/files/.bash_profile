while IFS= read -r line; do
  key=$(echo $line | cut -d'=' -f1)
  case $key in
    HOME|TERM|PS1|PATH) ;;
    *) unset $key ;;
  esac
done <<< "$(env)"

source ~/.bashrc
