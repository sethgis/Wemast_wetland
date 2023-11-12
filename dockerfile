# Use the official Python base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Create and activate a Python virtual environment
#RUN python -m venv myenv
#RUN /bin/bash -c "source myenv/bin/activate"

# If using GDAL make sure extension is downloaded
RUN if [ "$GDAL_NATIVE" = true ] && [ ! -f /tmp/resources/plugins/geoserver-gdal-plugin.zip ]; then \
	wget --progress=bar -c http://downloads.sourceforge.net/project/geoserver/GeoServer/${GS_VERSION}/extensions/geoserver-${GS_VERSION}-gdal-plugin.zip \
	-O /tmp/resources/plugins/geoserver-gdal-plugin.zip; \
fi;
# Copy the requirements file to the working directory
#COPY requirements.txt requirements.txt

# Install the Python dependencies
#RUN pip install -r requirements.txt

#RUN pip install uvicorn fastapi pipwin pipwin install geoserver_rest lxml pydantic Pygments pydantic-core


RUN pip install uvicorn fastapi pipwin 
RUN pipwin refresh
RUN pipwin install gdal 
RUN pip install geoserver_rest lxml pydantic Pygments pydantic-core
# Copy the application code to the working directory
# Copy the application code to the working directory
COPY . .

# Expose the port on which the application will run
EXPOSE 8000

# Run the FastAPI application using uvicorn server
CMD ["uvicorn", "fastapi:app", "--host", "0.0.0.0", "--port", "8000"]
