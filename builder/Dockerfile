FROM pytorch/pytorch:2.9.1-cuda12.6-cudnn9-runtime

# 1. Install System Dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    htop unzip git curl wget tmux nano \
    build-essential ninja-build \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
# 2. Install uv (Python package manager)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.cargo/bin:${PATH}"

# 3. Upgrade pip
RUN pip3 install --no-cache-dir --upgrade pip

# 5. Create entrypoint script
COPY entrypoint.sh /app/entrypoint.sh


RUN chmod +x /app/entrypoint.sh
COPY . /app/builder


WORKDIR /workspace
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/bin/bash"]