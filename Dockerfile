FROM python:3.12-alpine3.20

WORKDIR /app

COPY . .

RUN apk add --no-cache \
    gcc \
    musl-dev \
    libffi-dev \
    ffmpeg \
    aria2 \
    g++ \
    make \
    cmake \
    bash \
    wget \
    unzip

# Install mp4decrypt (Bento4)
RUN wget -O /tmp/bento4.zip https://www.bok.net/Bento4/binaries/Bento4-SDK-1-6-0-641.x86_64-unknown-linux.zip && \
    unzip /tmp/bento4.zip -d /opt && \
    cp /opt/Bento4-SDK-1-6-0-641.x86_64-unknown-linux/bin/mp4decrypt /usr/local/bin/ && \
    chmod +x /usr/local/bin/mp4decrypt

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Debug (optional)
RUN ls -R /app

# Start bot/app
CMD ["python3", "modules/main.py"]

