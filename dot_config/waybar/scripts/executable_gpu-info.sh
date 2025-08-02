#!/bin/bash

if command -v nvidia-smi &> /dev/null; then
    GPU_USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | head -n1)
    if [ -n "$GPU_USAGE" ]; then
        printf "GPU %2d%%" "$GPU_USAGE"
    else
        echo "GPU N/A"
    fi
elif command -v intel_gpu_top &> /dev/null; then
    GPU_USAGE=$(timeout 2s intel_gpu_top -J -s 1000 | jq -r '.engines."Render/3D/0".busy' 2>/dev/null)
    if [ -n "$GPU_USAGE" ] && [ "$GPU_USAGE" != "null" ]; then
        printf "GPU %2d%%" "$GPU_USAGE"
    else
        echo "GPU N/A"
    fi
else
    echo "GPU N/A"
fi

