% api_server.m - A RESTful API server for MATLAB calculations in Docker

% Load required parameters
run('Parameters.m'); % or Parameters_All.m or Parameters_New.m based on your needs

% Start the web server (requires MATLAB R2019b or newer with RESTful Web API support)
server = matlab.net.http.server.HttpServer;
server.Port = 7020; % Use port 7020 as requested
server.HostAddress = "0.0.0.0"; % Important: allow connections from outside the container

% Create a request handler for solving the system
solver = matlab.net.http.server.ServletHandler;
solver.RequestMethod = "POST";
solver.PathMatcher = "/solve";
solver.Servlet = @solveSystemHandler;

% Add a health check endpoint
healthCheck = matlab.net.http.server.ServletHandler;
healthCheck.RequestMethod = "GET";
healthCheck.PathMatcher = "/health";
healthCheck.Servlet = @healthCheckHandler;

% Add the handlers to the server
server.addServlet(solver);
server.addServlet(healthCheck);

% Start the server
server.start();
fprintf('MATLAB API server running on port %d\n', server.Port);

% Handler function for solving the system
function response = solveSystemHandler(request)
    try
        % Parse the input parameters from the request
        requestBody = jsondecode(string(request.Body));
        
        % Extract initial conditions from the request
        c1 = requestBody.c1;
        c2 = requestBody.c2;
        c3 = requestBody.c3;
        c4 = requestBody.c4;
        c5 = requestBody.c5;
        c6 = requestBody.c6;
        
        % Call the solution function
        Sol = solution(c1, c2, c3, c4, c5, c6);
        
        % Convert the solution matrix to a structure that can be converted to JSON
        result = struct();
        result.solution = Sol;
        result.status = 'success';
        
        % Create the response
        jsonResponse = jsonencode(result);
        response = matlab.net.http.ResponseMessage;
        response.StatusCode = matlab.net.http.StatusCode.OK;
        response.Body = matlab.net.http.MessageBody(jsonResponse);
        response.Header = matlab.net.http.HeaderField('Content-Type', 'application/json');
    catch ex
        % Handle errors
        errorStruct = struct('error', ex.message, 'status', 'failed');
        jsonError = jsonencode(errorStruct);
        
        response = matlab.net.http.ResponseMessage;
        response.StatusCode = matlab.net.http.StatusCode.InternalServerError;
        response.Body = matlab.net.http.MessageBody(jsonError);
        response.Header = matlab.net.http.HeaderField('Content-Type', 'application/json');
    end
end

% Health check endpoint for Docker container health monitoring
function response = healthCheckHandler(~)
    healthStatus = struct('status', 'healthy', 'service', 'matlab-api');
    jsonResponse = jsonencode(healthStatus);
    
    response = matlab.net.http.ResponseMessage;
    response.StatusCode = matlab.net.http.StatusCode.OK;
    response.Body = matlab.net.http.MessageBody(jsonResponse);
    response.Header = matlab.net.http.HeaderField('Content-Type', 'application/json');
end