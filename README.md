# AskWeather 🌤️ 
내 위치, 즐겨찾기한 위치의 날씨를 볼 수 있는 서비스입니다.

## 🔍 프로젝트 개요
이 앱은 iOS 기본 날씨 앱의 핵심 UI/UX를 벤치마크하여 제작된 SwiftUI 기반 날씨 앱입니다.
**앱 구조 설계, 네트워크 통신, 상태 관리, 데이터 캐싱, 위젯 연동** 등  
실제 iOS 앱 개발에 필요한 전반적인 역량을 폭넓게 학습하고자 진행한 프로젝트입니다.

## 스킬
- SwiftUI
- MVVM Pattern
- FileManager
- CoreLocation
- MapKit
- API
- Widget

## UI in Widget
<img src="https://github.com/user-attachments/assets/1e6cdc8d-f764-4f38-8504-abc89e30d0d1" width="300" alt="위젯">

## UI in App
AskWeather 앱은 크게 다음의 세 화면으로 구성됩니다.
1. 지도
2. 현재 위치의 날씨
3. 즐겨찾기한 위치의 날씨
   
### 지도
- 사용자의 현재 위치, 즐겨찾기한 위치의 날씨 정보를 볼 수 있습니다.
- 우측 상단의 메뉴 버튼을 통해 자외선, 미세먼지, 기온 중 하나를 선택해서 볼 수 있습니다.
- 사용자가 보고 있는 항목과 그 수치를 이해하기 쉽도록 하단에 바 형태로 정보가 표시됩니다.
<img src="https://github.com/user-attachments/assets/8c9ee48b-a3fc-402a-aefb-a4d9371fa231" width="200" alt="자외선">
<img src="https://github.com/user-attachments/assets/9146c9ec-d815-40b2-bd61-7d480068fd89" width="200" alt="미세먼지">
<img src="https://github.com/user-attachments/assets/39f14c82-ba65-4eda-a110-7c5c33692c5f" width="200" alt="기온">

- 종이비행기 아이콘을 누르면 현재 위치로 지도가 이동합니다.
<img src="https://github.com/user-attachments/assets/9ee4114f-a411-4c12-9d2f-9ebd01fa511c" width="200" alt="위젯">

- 대한민국의 날씨 정보에 한정된 앱이므로, 타국으로의 지도 이동과 확대를 제한합니다.

### 현재 위치의 날씨
- 구름/강수여부/시간대를 고려한 배경을 포함합니다.
- 시간별 일기예보는 현재시간 기준 24시간 뒤까지의 날씨 정보를 좌우 스크롤하여 볼 수 있습니다.
- 일간 일기예보에서는 그날 시간별 일기예보에서 과반수를 차지하는 날씨를 가져옵니다.
- 비 등 강수가 포함된 경우 과반수 여부와 상관없이 비 아이콘이 표시됩니다.
- 바람의 경우 풍속과 방향을 쉽게 인식할 수 있도록 나침반의 형태로 제작되었습니다.
<img src="https://github.com/user-attachments/assets/d7b0c230-c0dd-4289-9350-1f5e4f9f2b11" width="200" alt="기온">

### 즐겨찾기한 위치의 날씨
- 즐겨찾기한 지역의 날씨를 보여줍니다.
- 구름/강수여부/시간대를 고려한 배경을 포함합니다.
- 지역을 클릭하면 그 지역의 자세한 날씨를 볼 수 있습니다.
<img src="https://github.com/user-attachments/assets/074072f6-830d-44d2-ae8a-1b3a2177ff39" width="300" alt="asd">
<img src="https://github.com/user-attachments/assets/01cb5114-d48b-4f27-9132-c3af15af8bea" width="300" alt="asd">

- 각 지역 카드를 꾹 누르면, 다른 지역 카드와 자리를 바꿀 수 있습니다.
<img src="https://github.com/user-attachments/assets/c31a677e-46f4-4409-838f-26ffc1a52564" width="200" alt="기온">

#### 검색 모드
- 서치 바를 통해 검색 모드에 진입합니다.
- 입력값을 포함하는 지역들을 보여주며, 대한민국의 지역들만 검색 결과에 포함됩니다.
<img src="https://github.com/user-attachments/assets/a8583a4b-4ce1-4d46-8e8d-eb1687cd8bda" width="200" alt="위젯">

- 원하는 지역을 클릭하면 그 지역의 날씨가 로드됩니다.
- 로드가 완료되기 전까지는 로딩 UI가 표시됩니다.
- 로드가 완료되면 추가버튼이 생겨 즐겨찾기 항목에 포함시킬 수 있습니다.
- 취소버튼을 눌러 뒤로 이동합니다.
<img src="https://github.com/user-attachments/assets/82ea13a7-9957-47d1-a31a-af8a6bdc2397" width="200" alt="위젯">

#### 편집모드
- 휴지통 버튼을 누르면 편집 모드에 진입합니다.
- 삭제하고자 하는 지역들을 클릭한 뒤, 체크 버튼을 클릭하여 삭제합니다.
<img src="https://github.com/user-attachments/assets/d4ba305d-786d-47b2-bec0-68ca42d74cae" width="200" alt="기온">

## 날씨 관리
- 앱의 진입점에서 현재 위치와 즐겨찾기한 지역들의 날씨를 업데이트합니다.
- 업데이트 중일 때는 로딩 UI가 표시됩니다.
<img src="https://github.com/user-attachments/assets/a23db249-0614-4ad0-9f2e-6401a0e06adc" width="200" alt="기온">

- 시간 단위(00분 00초)로 이 정보들을 자동으로 갱신합니다.
<img src="https://github.com/user-attachments/assets/3fd40a12-f161-44dc-bdf1-f19c9462cea2" width="200" alt="기온">


## 기타 고려 사항
이 앱은 공공 데이터 포털, kakao developers API를 사용합니다.
전자의 경우 서버 내부 문제로 인해 단시간에 많은 호출이 이루어지면, 가끔 HTTP ROUTING ERROR, REQUEST TIME OUT 등의 에러를 내뱉습니다.
이를 대비하여 API 호출에 실패했을 경우 10초를 기다리고 자동으로 재시도합니다.
