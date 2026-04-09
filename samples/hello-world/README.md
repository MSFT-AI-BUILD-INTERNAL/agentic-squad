# Hello World Sample

Python으로 작성한 간단한 인사 프로그램입니다.
CLI 인자로 이름을 전달하면 해당 이름으로 인사하고, 인자가 없으면 `"Hello, World!"`를 출력합니다.

여러 인자를 전달하면 공백으로 결합하여 전체 이름으로 인사합니다.
빈 문자열이 전달되면 기본값 `"World"`로 폴백합니다.

## 실행 방법

```bash
# 기본 실행
python samples/hello-world/main.py

# 이름을 지정하여 실행
python samples/hello-world/main.py Alice

# 여러 인자로 전체 이름 지정
python samples/hello-world/main.py John Doe
```

## 예상 출력

```
# 기본 실행
Hello, World!

# 이름 지정
Hello, Alice!

# 전체 이름 지정
Hello, John Doe!
```
