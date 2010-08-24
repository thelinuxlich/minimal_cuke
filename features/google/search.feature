# language: pt
Funcionalidade: Pesquisar no Google
  Para encontrar um site
  Como um usuário normal
  Eu quero pesquisar no google

  @javascript
  Cenário: Pesquisar uma palavra
    Dado que eu estou na página inicial
    E eu preencher o "q" com "rails"
    Quando eu pressionar "Pesquisa Google"
    Então devo ver "rubyonrails.org"
