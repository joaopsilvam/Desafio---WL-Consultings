# 📝 Flutter - Lista de Tarefas

Este é um aplicativo de lista de tarefas desenvolvido em **Flutter**, seguindo o padrão **MVVM (Model-View-ViewModel)**.  
A aplicação é **Offline First**, armazenando as tarefas localmente usando **Hive**, garantindo que os dados sejam preservados mesmo sem conexão com a internet.

## 🚀 Funcionalidades
✅ Criar, editar e excluir tarefas  
✅ Marcar tarefas como concluídas  
✅ Filtrar tarefas concluídas e pendentes  
✅ Pesquisa de tarefas  
✅ Scroll infinito para carregar mais tarefas  
✅ Armazenamento **Offline First** com Hive  
✅ Arquitetura **MVVM**  

---

## 🛠 Tecnologias Utilizadas
- **Flutter** (Dart)
- **Provider** (Gerenciamento de estado)
- **Hive** (Banco de dados local)
- **Mockito & Flutter Test** (Testes unitários)
- **MVVM Architecture**

---

## 💻 Pré-requisitos
Antes de iniciar, certifique-se de ter instalado:
- **[Flutter SDK](https://flutter.dev/docs/get-started/install)**
- **[Dart](https://dart.dev/get-dart)**
- **Android Studio ou VS Code** com suporte a Flutter

Para verificar a instalação do Flutter:
```sh
flutter doctor
```

---

## 🏗 Como Rodar o Projeto
### 1️⃣ Clone o repositório:
```sh
git clone https://github.com/joaopsilvam/Desafio---WL-Consultings.git
```

### 2️⃣ Entre na pasta do projeto:
```sh
cd Desafio---WL-Consultings
```

### 3️⃣ Instale as dependências:
```sh
flutter pub get
```

### 4️⃣ Rode o aplicativo no emulador ou dispositivo físico:
```sh
flutter run
```

---

## 🧪 Rodando os Testes
Para executar os testes unitários:
```sh
flutter test
```

Caso esteja testando funcionalidades que usam Hive, execute:
```sh
flutter pub run build_runner build
flutter test
```

---

## 📂 Estrutura do Projeto
```sh
/lib
│── /data
│   ├── /models                
│   ├── /repositories         
│   ├── /services         
│
│── /presentation
│   ├── /viewmodels            
│   ├── /views                
│
│── /widgets                   
```

---

## 📜 Licença
Este projeto é open-source e distribuído sob a licença **MIT**.

---

## 👨‍💻 Autor
Desenvolvido por **[João P. Silva](https://github.com/joaopsilvam)**.  
Se quiser contribuir, fique à vontade para abrir um **Pull Request**! 🚀

