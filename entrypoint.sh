#!/bin/bash
set -e

# Start MATLAB and run the API server
# Use -nojvm if you don't need the JVM (faster startup)
# Use -nosplash to avoid the splash screen
matlab -nosplash -batch "run('api_server.m'); pause(inf);"