# Use the official Python image as the base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the requirements.txt file into the container
COPY requirements.txt .

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Streamlit app file into the container
COPY hello_world.py .

# Expose the port that Streamlit will use
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "hello_world.py"]
