#! /bin/bash


# Used primarily  by zabbix agent to parse nvidia-smi output into a consumable format

# particular query to run
QUERY_MODE="$1"
# the gpu to pull metrics from
SELECTED_GPU_NUMBER="$2"
# retrieves the total number of GPUs
GPU_COUNT=$(nvidia-smi --query-gpu=count --format=csv,noheader | head -n 1)
let MAX=$(($GPU_COUNT-1))
# make sure that a non-empty parameter was given
if [[ "$SELECTED_GPU_NUMBER" == "" ]]; then
    echo "[ERROR] No valid gpu number provided"
    echo "Invalid invocation"
    echo "./nvidia_smi_parser.sh [temp | draw | fan_speed | gpu_utilization_percent| mem_utilization_percent | gpu_clock_mhz]  <gpu-number>"
    exit 1
fi

# we need to compare against 1 below maximum since gpu is indexed starting at 0
if [[ "$SELECTED_GPU_NUMBER" -gt "$MAX" ]]; then
    echo "[ERROR] provided gpu number greater than gpu count"
    echo "Invalid invocation"
    echo "./nvidia_smi_parser.sh [temp | draw | fan_speed | gpu_utilization_percent| mem_utilization_percent | gpu_clock_mhz]  <gpu-number>"
    exit 1
fi

# function used to retrieve the temperature of a gpu
get_temp() {
    TEMP=$(nvidia-smi -q -i "$1" | grep -i "GPU Current Temp" | awk -F ':' '{print $2}' | awk '{print $1}')
    echo "$TEMP"
}

# function used to retrieve the power draw of a gpu
get_power_draw() {
    DRAW=$(nvidia-smi -q -i "$1" | grep -i "Power Draw" | awk -F ':' '{print $2}' | awk '{print $1}')
    echo "$DRAW"
}

get_fan_speed() {
    SPEED=$(nvidia-smi -i "$1" --query-gpu=fan.speed --format=csv,noheader)
    echo "$SPEED" | tr -d '%'
}

get_gpu_utilization_percent() {
    PERCENT=$(nvidia-smi -i "$1" --query-gpu=utilization.gpu --format=csv,noheader)
    echo "$PERCENT" | tr -d '%'
}

get_memory_utilization_percent() {
    PERCENT=$(nvidia-smi -i "$1" --query-gpu=utilization.memory --format=csv,noheader)
    echo "$PERCENT" | tr -d '%'
}

get_gpu_clock_mhz() {
   CLOCK=$(nvidia-smi -i "$1" -d CLOCK -q | grep '^    Clocks$' -A 4 | sed '1d' | grep Graphics  | awk -F ':' '{print $2}' | awk '{print $1}')
   echo "$CLOCK"
}

get_memory_clock_mhz() {
    CLOCK=$(nvidia-smi -i "$1" -d CLOCK -q | grep '^    Clocks$' -A 4 | sed '1d' | grep Memory  | awk -F ':' '{print $2}' | awk '{print $1}')
    echo "$CLOCK"
}

case "$QUERY_MODE" in 

    # query is for GPU temp
    temp) 
        get_temp "$SELECTED_GPU_NUMBER"
        ;;

    draw)
        get_power_draw "$SELECTED_GPU_NUMBER"
        ;;

    fan_speed)
	    get_fan_speed "$SELECTED_GPU_NUMBER"
	    ;;

    gpu_utilization_percent)
	    get_gpu_utilization_percent "$SELECTED_GPU_NUMBER"
        ;;

    mem_utilization_percent)
	    get_memory_utilization_percent "$SELECTED_GPU_NUMBER"
        ;;

    gpu_clock_mhz)
        get_gpu_clock_mhz "$SELECTED_GPU_NUMBER"
        ;;

    mem_clock_mhz)
        get_memory_clock_mhz "$SELECTED_GPU_NUMBER"
        ;;
        
    *)
        echo "Invalid invocation"
        echo "./nvidia_smi_parser.sh [temp | draw | fan_speed | gpu_utilization_percent| mem_utilization_percent | gpu_clock_mhz]  <gpu-number>"
        exit 1
        ;;
esac            
