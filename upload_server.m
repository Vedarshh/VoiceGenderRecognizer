function upload_server()
    % Create a Web App Server
    server = webserver;

    % Define a route to handle file uploads
    server.put('/upload_audio', @uploadFile);

    % Start the server
    start(server);

    % Display server information
    disp('MATLAB Upload Server running at:');
    disp(['http://localhost:' num2str(server.Port)]);

    % Function to handle file uploads
    function status = uploadFile(req, res)
        try
            % Get the uploaded file data
            fileData = req.Body.Data;

            % Write the uploaded file to disk
            filename = 'recorded_audio.wav';  % Change the filename as needed
            fid = fopen(filename, 'wb');
            fwrite(fid, fileData);
            fclose(fid);

            % Send a success response
            res.Status = 200;
            res.Body.Data = 'File uploaded successfully.';
        catch
            % Send an error response if something went wrong
            res.Status = 500;
            res.Body.Data = 'Error uploading file.';
        end
        status = true;
    end
end
