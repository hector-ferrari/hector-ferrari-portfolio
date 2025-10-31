# O Poder do Shell

## O que foi feito
Exercício de expressões regulares e uso do shell para localizar, em um arquivo `users.txt` com 1098 usuários, o nome cuja 2ª letra é `e` e a 4ª letra é `u`. Esse nome corresponde à flag.

## Contexto
Desafio da pós-graduação FIAP — atividade prática de Sysadmin/Regex. O objetivo era demonstrar habilidade em construir padrões com `grep`, diagnosticar o efeito de âncoras (como `^`) e validar o resultado.

## Desafio proposto
O Sysadmin Linux deve estar preparado e possuir conhecimentos sólidos em REGEX; o arquivo “users.txt” possui 1098 usuários cadastrados, encontre usuários que possuem, em seu nome, a vogal (e) como segunda letra e a vogal (u) como a quarta letra, o nome encontrado será utilizado para pontuar.

Encontrar, em `users.txt`, o usuário cujo nome possui:
- 2ª letra = `e`
- 4ª letra = `u`

Esse usuário seria a flag do desafio.

## Como eu resolvi (raciocínio completo)

### 1) Pesquisa e definição do padrão
Pensei em usar `grep` com expressão regular estendida (`-E`).  
Montei o padrão inicial (ancorado no início da linha):

```bash
grep -E '^.e.u' /home/onan/Compartilhado/users.txt
```

Explicando o padrão:
- `^` → início da linha  
- `.` → primeira letra qualquer  
- `e` → segunda letra deve ser `e`  
- `.` → terceira letra qualquer  
- `u` → quarta letra deve ser `u`

Redirecionei a saída para um arquivo de análise:

```bash
grep -E '^.e.u' /home/onan/Compartilhado/users.txt >> /home/onan/Compartilhado/analyseusers.txt
```

Resultado: vazio (nenhuma correspondência ancorada no início da linha).

---

### 2) Ajuste e diagnóstico
Adicionei `-i` para ignorar maiúsculas/minúsculas:

```bash
grep -iE '^.e.u' /home/onan/Compartilhado/users.txt >> /home/onan/Compartilhado/analyseusers.txt
```

Saída observada: `Eduarda` e `Eduardo` — nomes que não atendiam exatamente ao critério desejado. Concluí que o `^` poderia estar restringindo demais (o padrão pode não ocorrer no início da linha).

---

### 3) Teste sem âncora (consulta ao problema)
Testei o padrão sem o `^`, para verificar se o padrão ocorria em qualquer posição da linha:

```bash
grep -E '.e.u' /home/onan/Compartilhado/users.txt
```

---

### 4) Testes e resultado final
Inspecionei as primeiras e últimas linhas do resultado para confirmar:

```bash
grep -E '.e.u' /home/onan/Compartilhado/users.txt | head
grep -E '.e.u' /home/onan/Compartilhado/users.txt | tail
```

Saída encontrada:

```
Jesus
```

✅ Esse foi o usuário que atendia ao critério (2ª letra `e`, 4ª letra `u`) — portanto, a flag é **Jesus**.

---

## Comandos utilizados (resumo)
```bash
# padrão ancorado no início (teste inicial)
grep -E '^.e.u' /home/onan/Compartilhado/users.txt

# redirecionar para arquivo de análise
grep -E '^.e.u' /home/onan/Compartilhado/users.txt >> /home/onan/Compartilhado/analyseusers.txt

# ignorar case (teste)
grep -iE '^.e.u' /home/onan/Compartilhado/users.txt >> /home/onan/Compartilhado/analyseusers.txt

# padrão sem âncora (corresponde em qualquer posição)
grep -E '.e.u' /home/onan/Compartilhado/users.txt

# inspeção rápida dos resultados
grep -E '.e.u' /home/onan/Compartilhado/users.txt | head
grep -E '.e.u' /home/onan/Compartilhado/users.txt | tail

# comando final sugerido (salvar resultados, ignorando case)
grep -iE '.e.u' /home/onan/Compartilhado/users.txt >> /home/onan/Compartilhado/analyseusers.txt
```

## Resultado
O padrão `.e.u` (sem âncora) retornou o usuário **Jesus**, que atende ao critério do desafio. Esse foi o resultado final — a flag.

## Ferramentas usadas
`grep` (com `-E` e `-i`), `head`, `tail` — uso de expressões regulares simples e técnicas de diagnóstico iterativo.

## Observações / Aprendizado
- `.` representa qualquer caractere em uma posição fixa.  
- `^` restringe a busca ao início da linha; removê-lo permite encontrar o padrão em qualquer posição.  
- `-i` evita problemas com maiúsculas/minúsculas.  
- Fluxo recomendável: formular padrão → testar → ajustar → validar → documentar.

## Resumo pessoal
Segui o processo de analista: formulei o padrão, testei, diagnostiquei a restrição do `^`, ajustei para corresponder em qualquer posição e validei o resultado — encontrando **Jesus** como a flag.
