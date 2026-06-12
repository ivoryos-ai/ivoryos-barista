# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Install uv for fast dependency management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set the working directory
WORKDIR /app

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install dependencies using uv into the system Python
RUN uv pip install --system -e .

# Copy the rest of the application
COPY . .

# Change ownership to allow writing (useful for environments like Hugging Face Spaces)
RUN chmod -R a+w /app

# Expose the port the app runs on
EXPOSE 7860



# Command to run the application
CMD ["python", "app.py"]
