```docker title="Example of Dockerfile"
FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu24.04
WORKDIR /tmp
ADD https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64 vscode_cli.tar.gz
RUN tar -xf vscode_cli.tar.gz 
CMD ["code", "tunnel"]
```