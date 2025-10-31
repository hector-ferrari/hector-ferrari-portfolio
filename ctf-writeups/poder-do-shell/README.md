# O Poder do Shell

## O que foi feito
Utilizei expressões regulares com `grep` para identificar nomes específicos dentro de um arquivo de usuários.
O desafio era encontrar nomes com a vogal “e” como segunda letra e “u” como quarta letra.

## Contexto
Desafio da pós-graduação FIAP em Defesa Cibernética (Blue Team).
O objetivo era usar comandos do Shell para filtrar dados com base em um padrão de texto.

## Desafio proposto
O Sysadmin Linux deve estar preparado e possuir conhecimentos sólidos em REGEX; o arquivo “users.txt” possui 1098 usuários cadastrados, encontre usuários que possuem, em seu nome, a vogal (e) como segunda letra e a vogal (u) como a quarta letra, o nome encontrado será utilizado para pontuar.

## Como fiz
1. Iniciei com uma expressão regular básica:
```
grep -E '^.e.u' users.txt
```
Esse padrão verifica:
- `^` → início da linha
- `.` → qualquer caractere
- `e` → segunda letra é “e”
- `.` → terceira letra qualquer
- `u` → quarta letra é “u”

2. Redirecionei a saída para um arquivo de análise:
```
grep -E '^.e.u' users.txt >> analyseusers.txt
```

3. Ajustei o comando para ignorar maiúsculas/minúsculas:
```
grep -iE '^.e.u' users.txt
```

4. Após testar diferentes padrões, removi o `^` para permitir a busca em qualquer posição da linha:
```
grep -E '.e.u' users.txt
```

5. O resultado retornou o nome:
```
Jesus
```

## Resultado
Identifiquei o nome **Jesus** como o padrão correto, atendendo aos critérios definidos.

## Ferramentas usadas
`grep`, expressões regulares, redirecionamento de saída (`>>`).
