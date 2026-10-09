# LivenessIdentySDK (manifesto SPM)

Manifesto Swift Package Manager para o `LivenessIdentySDK` — SDK de verificação de vivacidade
(liveness) biométrica para iOS, publicado e mantido pela VCC. Este repositório **não contém
código-fonte do SDK** — só o `Package.swift` (gerado automaticamente a cada release) que aponta
para o binário (`.xcframework.zip`) publicado em um bucket privado, servido por um gateway
autenticado.

## Instalação

No Xcode: **File → Add Package Dependencies…** e informe a URL deste repositório. Selecione a
regra de versão **Up to Next Major Version**, a partir da versão desejada.

Ou, no seu próprio `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Valid-Plataform-ID/vendor-identy-sdk-ios.git", from: "1.0.0")
]
```

E declare o produto `LivenessIdentySDK` como dependência do seu target.

## Pré-requisito: credenciais do gateway

O binário resolvido por este manifesto está atrás de um gateway autenticado — configure a
credencial do seu cliente no `~/.netrc` da máquina/runner que resolve o pacote:

```
machine <domínio-do-gateway>
login <seu-usuário>
password <seu-token>
```

Sem isso, a resolução do `binaryTarget` falha com `401 Unauthorized`.

## O que este pacote traz

- `LivenessIdentySDK` — o SDK compilado (binaryTarget remoto).
- Uma dependência real em `sentry-cocoa` (produto `Sentry-Dynamic`), versão travada (`exact`) —
  necessária porque o SDK referencia Sentry via link dinâmico obrigatório, não embutido
  fisicamente no `.xcframework` (ver "Observações" abaixo). O Xcode resolve e embute o
  `Sentry.framework` automaticamente no seu app, como qualquer outra dependência SPM.

Este pacote **não** declara uma dependência em `ShieldPtr` — essa é uma dependência opcional,
weak-linked, do próprio SDK compilado. Se o seu app precisar da coleta de assinatura de
dispositivo via Shield (Cashshield), adicione `shield-ptr-spm` (mesma versão pinada documentada no
changelog da release) ao seu próprio projeto; sem isso, o SDK degrada silenciosamente para um
`ssid` vazio — nunca crasha.

## Assinatura (Run Script Phase)

O `.xcframework` é distribuído com assinatura ad-hoc. Seu projeto precisa re-assinar os
frameworks embutidos durante o build — ver a documentação de integração completa em
`docs/integracao-consumer-ios.md` do repositório principal do SDK (fora deste manifesto).

## Observações

- Esta distribuição remota cobre **apenas a variante Release** do SDK.
- A quais clientes esta distribuição está disponível é controlado pelo gateway — fora do escopo
  deste manifesto.
- Troubleshooting de resolução SPM (401/404/checksum mismatch): ver
  `docs/integracao-consumer-ios.md` do repositório principal.

## Changelog

Ver [CHANGELOG.md](./CHANGELOG.md).
