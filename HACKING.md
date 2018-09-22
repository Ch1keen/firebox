# Firebox : Hacking

## Please understand

My native language is Korean, and I want to write this page for me. Because this page will be used as my idea note.

I always **welcome** translator.

## 들어가기 전에

파이어박스는 도커 컨테이너 안에서 파이어폭스를 돌리고 싶은 저의 개인적인 욕심으로부터 시작했습니다. 사실 구글에 검색해보면 도커 컨테이너 안에서 GUI 프로그램을 돌리는 방법은 많이 나와 있었고, 이 팁을 이용한 다양한 프로그램이 존재하는 것은 사실이지만, 대부분의 경우 한글이 입력이 되지 않는 것은 애교고, 한글이 깨지는 경우가 허다했기 때문이죠.

그래서 다른 프로젝트를 포크하여 수정해보려고 했지만, 주석도 하나 없는 소스코드 안에서 그러기는 쉽지가 않았습니다. 딱 그 프로젝트 안의 도커파일에 google-noto-cjk 폰트 하나만 설치해주는 스크립트만 넣으면 한글이 깨지지가 않을텐데 도무지 방법을 찾을 수 없었습니다.

정말 주석과 충분한 문서는 중요하다는 점을 다시금 깨닫게 되는 경험이었습니다. 깃허브와 오픈소스 개발에 대한 첫경험이 이러니(?) 누군가가 제 프로젝트를 포크하여 사용할 경우 도움이 되었으면 하는 마음에 이 문서를 작성합니다. ~~사실 마크다운 연습도 할 겸 투머치토커 기질을 해소하고 싶은데 블로그는 못하겠어서 작성한 것도 있습니다.~~

## 전체 흐름

파이어박스는 리눅스 배포판에서 도커 컨테이너 안에서 파이어폭스를 비롯한 다양한 브라우저를 돌리는 프로젝트입니다. 현재는 파이어폭스만 지원하지만, 앞으로 chromium, google-chrome, tor-browser 등 다양한 브라우저의 지원을 추가할 예정입니다.

다양한 브라우저를 지원하는 이유는 그 각기의 특성이 유별나기 때문입니다. 구글 크롬은 세상에서 가장 많이 쓰이는 데스크탑용 인터넷 브라우저이고, 크로미움은 이 구글 크롬의 오픈소스 버전이죠. 토르 브라우저는 개인의 익명성과 보안에 심혈을 기울인 브라우저입니다. 하지만 이 세 개 브라우저를 하나의 컨테이너/이미지에 넣는 것은 용량과 보안 측면에서 상당히 좋지 않다고 생각하고 있습니다. 따라서 앞으로 개발할 때에는 이 세 브라우저는 각기 다른 컨테이너 안에서 돌아갈 것입니다.

파이어폭스의 도커 이미지는 ubuntu:18.04 이미지를 사용합니다. 가장 보편적인 리눅스 배포판이기도 하고, 페도라나 데비안 운영체제에서는 파이어폭스의 설치가 굉장히 까다로울 뿐더러, 우분투에서는 apt로 'ubuntu-restricted-extras' 패키지가 존재하기 때문에 플래시를 비롯한 영상 관련 플러그인을 깔~~아서 유튜브 스트리밍을 볼~~ 수 있습니다.

크로미움과 토르는 자잘한 것도 없애고 최대한 용량을 줄일 수 있게끔 알파인 리눅스 이미지를 사용할 계획을 가지고 있습니다. 하지만 ~~스트리밍을 볼 수 있는~~ 플러그인을 사용할 수 없다면 그 경우에는 우분투 이미지를 사용해야 할 것 같습니다.

### 설치 (install.sh) 과정

순서도를 그릴 수 있으면 좋겠습니다만, 딱히 방법을 찾지는 못하고 있습니다. 전국의 체계적인 개발자들 존경합니다.

1. git clone <https://github.com/Ch1keen/firebox>
2. cd ./firebox
3. ./install.sh [firefox|chromium|google-chrome|tor-browser]
4. 도커가 설치되어 있는지 확인한다.
    1. 있는 경우 이미지를 빌드한다. 이미지를 빌드할 때에는 가급적이면 캐시를 사용하지 않는 방향으로 한다. docker build --no-cache -t ch1keen/firebox-[chromium|firefox|google-chrome|tor-browser] ./Dockerfiles/[chromium|firefox|google-chrome|tor-browser]
    2. 없는 경우 도커가 설치되어 있지 않은 것 같다는 경고를 띄우면서 종료한다.
5. firebox 파일을 /usr/share/bin 으로 복사한다.
6. 설치 완료

이 과정에서 생성하는 이미지의 이름은 firebox-chromium, firebox-firefox, firebox-google-chrome, firebox-tor-browser 입니다. /usr/share/bin으로 파일을 복사한 이후부터는 자동으로 얼라이어스가 되어서 터미널에

> $ firebox start

라고 쳐도 무리가 없습니다.

### 사용 (firebox) 과정

- firebox [chromium|google-chrome|tor-browser]
    1. 이미지가 이미 존재하는지 확인
    2. 컨테이너가 이미 존재하는지 확인
    3. 컨테이너 실행 - docker start [chromium|firefox|google-chrome|tor-browser]
- firebox shell
    1. 컨테이너가 이미 존재하는지 확인
    2. 컨테이너가 실행중인지 확인
    3. 셸 진입 - docker exec -it [chromium|firefox|google-chrome|tor-browser] /bin/bash
- firebox update
    1. 컨테이너가 이미 존재하는지 확인
    2. 컨테이너가 실행중인지 확인
    3. 명령어 실행 - docker exec -it [chromium|firefox|google-chrome|tor-browser] sudo apt update
    4. 명령어 실행 - docker exec -it [chromium|firefox|google-chrome|tor-browser] sudo apt upgrade
- firebox backup
- firebox restore

이 과정에서 생성하는 컨테이너의 이름은 chromium, firefox, google-chrome, tor-browser 입니다. 컨테이너와 이미지의 이름을 일치시키는 것이 좋은지는 나중에 생각해보도록 하겠습니다.

### 제거 (install.sh) 과정

1. ./install uninstall 실행
2. 컨테이너가 멈춰져있는지 확인합니다.
    1. 아닌 경우 컨테이너를 종료해야 한다는 메시지를 출력하고 과정을 중지합니다.
    2. 컨테이너가 존재하지 않는 경우 경고메시지를 띄우기는 하나 종료하지는 않습니다.
3. 컨테이너를 제거합니다. 그럴 일이 있을지는 모르겠지만 컨테이너가 존재하지 않는다면 경고 메시지를 띄우지만 종료하지 않습니다.
4. 이미지를 제거합니다. 그럴 일이 있을지는 모르겠지만 이미지가 존재하지 않는다면 경고 메시지를 띄우지만 종료하지 않습니다.
5. chromium, firefox, google-chrome, tor-browser 이미지와 컨테이너 삭제를 위해 2~4의 과정을 반복합니다. 셸 스크립트에서 반복문의 기능을 이용하면 좋지 않을까 싶습니다.
6. /usr/share/bin에 있는 firebox을 삭제합니다. 그럴 일이 있을지는 모르겠지만 파일이 존재하지 않는다면 경고 메시지를 띄우지만 종료하지 않습니다.

tab completion을 넣을 수 있을지 생각해보는 것도 좋은 것 같습니다.

## 지향점

- Security : 기업이 아닌 일반 사용자가 보안 피해를 입게 되는 가장 주된 경로는 웹 브라우저라고 생각합니다. chroot jail처럼 컨테이너 안에서 보안 사고가 발생하더라도 컨테이너 밖을 벗어나지 못하게 하여 피해를 최소화하는 것을 목표로 합니다.
- Portable : 백업과 복구가 쉬워서 리눅스 배포판을 바꿔도 쉽게 사용이 가능하게 함.
- Easy to use : 설치와 사용이 쉬움.

본디 무언가를 할 때에는 뚜렷한 목표가 있어야 한다고들 하죠.

## 파일 구조 및 소개

### firefox/Dockerfile (도커파일)

> RUN           apt -y update  

업데이트를 해줍니다. 이걸 하지 않으면 기본적으로 apt를 이용해 설치를 할 수 없습니다.

> RUN           apt -y install fonts-noto fonts-noto-cjk fonts-noto-cjk-extra

한글 관련 글꼴을 설치해줍니다. 구글에서 제공하는 [google-noto](https://www.google.com/get/noto/help/cjk/) 폰트를 사용합니다. noto라는 이름을 붙인 이유가 'no tofu'이기도 하고, 실제로 제가 사용하는 데에도 큰 불편함은 없어서 이 폰트를 사용할 겁니다.

> RUN           apt -y install fcitx fcitx-hangul
> ENV           GTK_IM_MODULE=fcitx
> ENV           QT_IM_MODULE=fcitx
> ENV           XMODIFIERS=@im=fcitx

컨테이너 내에서도 한글을 사용할 수 있도록 fcitx를 설치합니다.

> RUN           apt -y install firefox
> RUN           apt -y install pulseaudio
> RUN           apt -y install ubuntu-restricted-extras

파이어폭스를 설치하고, 소리가 나올 수 있도록 pulseaudio를 설치해줍니다. 또 파이어폭스가 좀 더 다양한 영상 포맷을 재생할 수 있도록 H.264와 관련된 플러그인을 설치해줍니다.

> RUN           apt -y install sudo
> RUN           useradd firefox -m -G audio
> RUN           echo "firefox ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
> USER          firefox

sudo를 설치해주고, firefox라는 계정을 하나 만듭니다. 이 계정은 sudo 명령어를 비밀번호 없이 사용할 수 있도록 합니다.

firefox는 보안 상의 문제를 이유로 root 계정에서 웹 브라우저를 돌릴 수 없도록 해놓았습니다. 따라서 사용자 계정을 만들어야 하고, 그 안에서 sudo 명령어를 사용할 수 있도록 하기로 했습니다. 하지만, 이런 경우 아무리 컨테이너 안이더라도 root 권한을 쉽게 탈취할 수 있기 때문에 문제가 많을 것이라고 생각합니다. /etc/shadow 파일을 공유하여 셸에서 sudo를 이용하여 명령어를 실행해야 할 때 기존 사용자의 계정 비밀번호를 입력하는 방법을 고심하고 있습니다.

### firebox (셸 스크립트)

1. 완전 처음에 시작한 것이라서 컨테이너가 존재하지 않을 때

그럼 docker run 명령어를 통해 컨테이너를 시작해줘야 한다.

2. 컨테이너가 존재하는데 멈춰있을 때

그럼 멈춰있는 컨테이너를 실행하면 된다.

3. 컨테이너가 이미 실행중일 때

그럼 컨테이너가 실행중인지를 체크한 다음 이미 실행중이라고 명령을 띄우면 될 것이다.

컨테이너의 상태가 어떤가를 체크하는 방법은 세가지가 존재한다. docker ps -a 명령어는 컨테이너가 존재하는지 아닌지를 판단하는 경로가 된다. docker ps 명령어는 컨테이너가 실행중인지 아닌지를 판단하는 경로가 된다. 즉, docker ps 명령어를 통해 컨테이너가 실행중인지를 먼저 파악한 다음, docker ps -a 명령어를 통해 컨테이너가 존재하는지 아닌지를 판단하는 편이 좋을 것이다.

<pre>
+--------------------------------------------+            +-------------------------+
| docker ps -f "name=firefox" | grep firefox | ---Y-----> | echo "Already Running." |
+--------------------------------------------+            +-------------------------+
                        |
                        N
                        |
                        v
+---------------------------------------------+           +----------------------+
| docker ps -af "name=firefox" | grep firefox | --Y-----> | docker start firefox |
+---------------------------------------------+           +----------------------+
                        |
                        N
                        |
                        v
                    +--------+
                    | init() |
                    +--------+
</pre>

하지만 이 방식의 문제점은, 제일 빈번하게 사용하는 docker start firefox 명령어가 상당히 늦어질 수 있다는 점이다. (if문 두 개를 거치니까.)

### install.sh (셸 스크립트)

## 트러블슈트

당연한 이야기이겠지만, 프로그램을 둘러싼 문제점이 다소 존재합니다.

### 우분투 이미지의 문제점에 대한 의견

우분투 이미지가 도커 컨테이너용으로는 적합하지 않다는 의견이 존재합니다.

1. 죽지 않고 살아있는 init 프로세스
2. APT(패키지 매니저)가 도커용으로는 부적합하다는 의견
3. 이미지의 크기가 크다는 점

최소 몇년은 된 것 같은데 다각도로 판단하여 다른 이미지를 사용하는 방안도 검토해볼 만합니다.

### 기존의 파이어폭스가 실행되고 있을 때 -t 태그를 붙여 임시 컨테이너를 생성하면 기존의 파이어폭스와 데이터가 연계되는 문제

파이어폭스가 -v 태그를 이용해 기존 시스템과 데이터를 공유하는 과정에서 존재하는 문제점으로 보입니다. 아직은 정확한 이유를 모르겠습니다.

### 정작 필요한 패키지보다 더 많은 패키지를 설치하는 문제

적당히 줄이는 방법을 배워야 하겠습니다만, 다양하게 실험해보는 것이 제일 중요하겠습니다.

### 기타 이슈 트래커에 존재하는 이슈들
