# Use the official MATLAB container image
FROM mathworks/matlab:r2023b

# Set working directory
WORKDIR /usr/src/app

# Copy MATLAB scripts to container
COPY *.m .

# Expose the port MATLAB API will run on
EXPOSE 7020

# Set environment variables for MathWorks account authentication
# These will be passed in at runtime via docker-compose
ENV MLM_WEB_LICENSE=true
ENV MLM_WEB_USER=""
ENV MLM_WEB_PASS=""

# Run the MATLAB API server on container startup
CMD ["matlab", "-nosplash", "-nodesktop", "-r", "run('api_server.m'); pause(inf);"]