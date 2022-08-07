로컬 환경(window, mac)  
docker-compose -f docker-compose.local.yml up --build  

스테이징 환경(oracle cloud)  
docker-compose -f docker-compose.staging.yml up --build  
이후 인증서 갱신이 필요하다면 certificate-generator.staging.sh를 실행한다  

배포 환경(azure VM)  
docker-compose -f docker-compose.production.yml up --build  
이후 인증서 갱신이 필요하다면 certificate-generator.production.sh를 실행한다  

흔히 발생하는 에러  
로컬환경, 스테이지 환경은 docker-compose up 시 처음 한 번은 mysql 컨테이너가 빠르게 생성되지 않아 에러가 발생할 수 있다.   
docker-compose up 3번 이내로 하면 해결된다.  

로컬환경, 스테이지 환경에서 mysql에 연결되지 않고, 컨테이너에 붙어서 확신이 admin 유저가 생성되지 않은 경우가 있다.  
이 경우 docker-compose -f docker-compose.staging.yml down -v 로 볼륨을 지워준다.  