FROM python:3.10-slim

# Sentence Transformers (SBERT) API Service
# Supports both CPU and GPU (CUDA) via build argument
# Source: Consolidated from ContainerStore + RunScripts

WORKDIR /app

# Model to use (can be overridden)
ENV SBERT_MODEL=sentence-transformers/all-mpnet-base-v2

# Build argument to select CPU or CUDA
ARG COMPUTE_PLATFORM=cpu
ENV COMPUTE_PLATFORM=${COMPUTE_PLATFORM}

# Install dependencies
RUN pip install transformers sentence-transformers Flask waitress

# Install PyTorch (CPU or CUDA based on build arg)
RUN if [ "$COMPUTE_PLATFORM" = "cuda" ]; then \
        echo "Installing PyTorch with CUDA support..." && \
        pip3 install torch --index-url https://download.pytorch.org/whl/cu121; \
    else \
        echo "Installing PyTorch CPU-only..." && \
        pip3 install torch --index-url https://download.pytorch.org/whl/cpu; \
    fi

# Pre-download the model during build
RUN python -c "from sentence_transformers import SentenceTransformer; SentenceTransformer('${SBERT_MODEL}')"

# Copy the Flask API server
COPY sbert-server.py /app/

EXPOSE 5000

# Run the Flask server with the specified model
CMD python /app/sbert-server.py "${SBERT_MODEL}"
