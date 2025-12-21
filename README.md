# InstaBuy-PS-Flutter

## Comandos para Rodar o Projeto

### Clonar o Projeto
```bash
git clone https://github.com/diogjunior100/InstaBuy-PS-Flutter.git
```

### Entrar no diretório do projeto
```bash
cd InstaBuy-PS-Flutter/instabuy_flutter_app
```

### Instalação das dependências
```bash
flutter pub get
```

### Rodar o projeto 
```bash
flutter run
```

OBS: Se for rodar o projeto no navegador Chorme, o tal bloqueia as imagens devidos aos CORS da chamada HTTPS. Nesse sentido, é necessário rodar o seguinte comando
```bash
flutter run -d chrome --web-browser-flag "--disable-web-security" --web-browser-flag "--user-data-dir=/tmp/chrome"
```