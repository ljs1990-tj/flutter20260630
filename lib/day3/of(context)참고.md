# Flutter: ScaffoldMessenger.of(context) 완벽 이해하기

플러터에서 스낵바(SnackBar)를 띄울 때 사용하는 `ScaffoldMessenger.of(context).showSnackBar()` 공식은 **'위젯 트리 탐색'**의 핵심을 담고 있습니다.

이 코드가 어떤 의미를 담고 있는지 두 부분으로 쪼개서 살펴보겠습니다.

## 1. `.of(context)`의 의미: "내 위치에서 위로 찾아라!"

`context`는 위젯 트리에서 현재 위젯의 **'위치(주소)'**를 의미합니다. 플러터에서 `.of(context)`라는 문법은 **"지금 내 위치(context)에서 출발해서, 위젯 트리의 위쪽(부모 방향)으로 거슬러 올라가며 특정한 위젯을 찾아라!"**라는 뜻의 명령어입니다.

* **`Theme.of(context)`:** 내 위치에서 위로 쳐다보며 가장 가까운 '테마(Theme)' 설정을 찾아라.
* **`MediaQuery.of(context)`:** 내 위치에서 위로 쳐다보며 '화면 크기(MediaQuery)' 정보를 찾아라.

## 2. `ScaffoldMessenger`의 의미: "스낵바 전담 매니저"

과거에는 스낵바를 띄울 때 `Scaffold.of(context)`를 사용했습니다. 하지만 스낵바가 떠 있는 도중에 화면을 전환하면, 이전 화면의 `Scaffold`가 사라지면서 스낵바도 함께 공중분해 되는 문제가 있었습니다.

이를 해결하기 위해 도입된 것이 **`ScaffoldMessenger`**입니다. 이 객체는 화면(Scaffold)들이 전환되든 말든, 앱 전체를 총괄하며 스낵바를 안정적으로 띄워주는 **'스낵바 전담 매니저'** 역할을 합니다. (보통 앱 최상단의 `MaterialApp`이 이 매니저를 생성하여 최상단에 배치합니다.)

---

## 💡 전체 코드 해석 및 비유

이해를 돕기 위해 전체 코드를 문장으로 해석해 보겠습니다.

> **`ScaffoldMessenger.of(context).showSnackBar(...)`**
> = "내 현재 위치(`context`)에서 출발해서 위로 거슬러 올라가며(`of`), 스낵바 전담 매니저(`ScaffoldMessenger`)를 찾아내서, 그에게 스낵바를 띄워달라고(`showSnackBar`) 부탁해!"

**🏢 아파트 방송으로 비유하자면:**
아파트 101호(현재 내 `context`)에서 직접 마이크를 잡고 방송을 하는 것이 아닙니다.
인터폰을 들고 선을 따라 관리사무소로 연결(`.of(context)`)한 다음, 방송 전담 관리소장님(`ScaffoldMessenger`)에게 "방송 좀 틀어주세요!(`showSnackBar`)"라고 요청하는 것과 완벽하게 같은 원리입니다.