FROM tensorflow/tensorflow:${TENSORFLOW_TAG:-latest}

# TensorFlow with Jupyter Lab for machine learning development
# Use latest-gpu tag for GPU support

WORKDIR /workspace

# Set Keras home directory
ENV KERAS_HOME=/keras

# Install Jupyter Lab and common data science libraries
RUN pip install -U \
    jupyterlab \
    pandas \
    matplotlib \
    seaborn \
    scikit-learn \
    && rm -rf /root/.cache/pip

# Expose Jupyter Lab port
EXPOSE 8888

# Start Jupyter Lab without authentication (configure in docker-compose if needed)
ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]
