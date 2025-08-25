# 우분투 최신 버전의 베이스 이미지를 사용합니다. 
From ubuntu:latest

# 유지 관리자 정보를 레이블로 추가합니다. 
Label maintainer="Hoon <qlp.casewen@gmail.com>"

# 작업 디렉토리를 설정합니다.
WORKDIR /mlops

# 현재 디렉토리의 모든 파일을 작업 디렉토리로 복사합니다. 
COPY . .

# 파이썬을 설치합니다. 
RUN apt-get update \
    && apt-get install -y python3 python3-pip

# 의존성을 설치하고 캐시를 제거합니다. 
RUN python3 -m pip install --upgrade pip \
    && pip install fastapi uvicorn \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
# 애플리케이션이 사용하는 포트를 노출합니다.
EXPOSE 8000

# main.py를 실행합니다. 
CMD ["uvicorn","src.main:app","--host", "0.0.0.0", "--port", "8000"]