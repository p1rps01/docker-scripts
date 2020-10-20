#!/bin/bash
# external variable sources
  source /share/docker/scripts/.bash_colors.env
  source /share/docker/secrets/.docker_vars.env

# function definitions
  fnc_help(){
    echo -e "${blu}[-> This script creates ${CYN}Drauku's${blu} folder structure for the listed stack(s). <-]${DEF}"
    echo -e "      ${blu}(modified from ${CYN}gkoerk's${blu} famously awesome folder structure for stacks.)${DEF}"
    echo
    echo -e "  Enter up to nine(9) swarm_stacks in a single command, separated by a 'space' character: "
    echo -e "    SYNTAX: dsf ${cyn}swarm_stack1${DEF} ${cyn}swarm_stack2${DEF} ... ${cyn}swarm_stack9${DEF}"
    echo -e "    SYNTAX: dsf -${cyn}option${DEF}"
    echo -e "      VALID OPTIONS:"
    echo -e "        -${cyn}h${DEF} │ --${cyn}help${DEF}   Displays this help message."
    echo
    echo -e "    The below folder structure is created for each 'swarm_stack' entered with this command:"
    echo -e "        ${YLW}${swarm_appdata}/${cyn}swarm_stack${DEF}"
    echo -e "        ${YLW}${swarm_configs}/${cyn}swarm_stack${DEF}"
    # echo -e "        ${YLW}${swarm_runtime}/${cyn}swarm_stack${DEF}"
    # echo -e "        ${YLW}/share/swarm/secrets/${cyn}swarm_stack${DEF}"
    echo
    exit 1 # Exit script after printing help
    }
  fnc_script_intro(){ echo -e "${blu}[-> CREATE DOCKER SWARM FOLDER STRUCTURE FOR LISTED STACKS <-]${def}"; }
  fnc_script_outro(){ echo -e "${GRN} -> FOLDER STRUCTURE CREATED${DEF} FOR LISTED CONTAINERS: "; echo -e " -> ${cyn}$1, $2, $3, $4, $5, $6, $7, $8, $9 ${DEF}"; echo; }
  fnc_nothing_to_do(){ echo -e "${YLW} -> between 1 and 9 names must be entered for this command to work${DEF}"; exit 1; }
  fnc_invalid_syntax(){ echo -e "${YLW} >> INVALID OPTION SYNTAX, USE THE -${cyn}help${YLW} OPTION TO DISPLAY PROPER SYNTAX <<${DEF}"; exit 1; }
  fnc_swarm_folders(){ mkdir -p {$swarm_appdata,$swarm_configs}/{$1,$2,$3,$4,$5,$6,$7,$8,$9}; }
  fnc_swarm_appdata_folders(){ mkdir -p ${swarm_appdata}/{$1,$2,$3,$4,$5,$6,$7,$8,$9}; }
  fnc_swarm_configs_folders(){ mkdir -p ${swarm_configs}/{$1,$2,$3,$4,$5,$6,$7,$8,$9}; }
  fnc_swarm_runtime_folders(){ mkdir -p ${swarm_runtime}/{$1,$2,$3,$4,$5,$6,$7,$8,$9}; }
  fnc_swarm_secrets_folders(){ mkdir -p ${swarm_secrets}/{$1,$2,$3,$4,$5,$6,$7,$8,$9}; }
  fnc_folder_ownership_update(){ 
    chown -R ${var_usr}:${var_grp} ${swarm_folder}; 
    chmod 600 -c {$swarm_appdata,$swarm_configs}/{$1,$2,$3,$4,$5,$6,$7,$8,$9};
    echo -e " -> ${GRN}FOLDER OWNERSHIP UPDATED ${DEF}"; echo;
    }

# output determination logic
  case "${1}" in 
    ("") fnc_nothing_to_do ;;
    (-*) # validate and perform option
      case "${1}" in
        ("-h"|"-help"|"--help") fnc_help ;;
        (*) fnc_invalid_syntax ;;
      esac
    ;;
    (*) fnc_swarm_folders $1 $2 $3 $4 $5 $6 $7 $8 $9
      # Create folder structure
      # fnc_swarm_appdata_folders $1 $2 $3 $4 $5 $6 $7 $8 $9
      # fnc_swarm_configs_folders $1 $2 $3 $4 $5 $6 $7 $8 $9
      # fnc_swarm_runtime_folders $1 $2 $3 $4 $5 $6 $7 $8 $9 # disabled due to not being used
      # fnc_swarm_secrets_folders $1 $2 $3 $4 $5 $6 $7 $8 $9 # disabled due to not being used
      fnc_folder_ownership_update $1 $2 $3 $4 $5 $6 $7 $8 $9
      # fnc_script_outro
      ;;
  esac
