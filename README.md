# InstaBuy-PS-Flutter
O Chrome bloqueia algumas imagens devido a políticas de CORS quando chamadas HTTPS são feitas.
Para evitar esse problema, execute o projeto com a flag que desabilita a verificação de segurança:

## Comandos para Rodar o Projeto

### Clonar o Projeto
```bash
git clone https://github.com/diogjunior100/InstaBuy-PS-Flutter.git
```

### Acessar a Pasta do Projeto
```bash
cd InstaBuy-PS-Flutter/instabuy_flutter_app
```

### Instalar Dependências
```bash
flutter pub get
```

### Executar o Projeto 
Em dispositivo móvel ou emulador

```bash
flutter run
```

### Executar no Chrome (Flutter Web)
Algumas imagens externas podem não carregar no Flutter Web devido a regras de CORS (Cross-Origin Resource Sharing).

Isso ocorre quando o servidor que hospeda essas imagens não libera requisições vindas de origens diferentes, como http://localhost

```bash
flutter run -d chrome --web-browser-flag "--disable-web-security" --web-browser-flag "--user-data-dir=/tmp/chrome"
```

OBS:
- Use esse modo apenas para desenvolvimento.
- Em produção, o correto é configurar o servidor para enviar os headers CORS adequados.
