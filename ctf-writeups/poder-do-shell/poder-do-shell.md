# O poder do Shell

**Contexto:** Desafio de Regex / Sysadmin Linux — identificar usuário cujo nome possuía 'e' como 2ª letra e 'u' como 4ª letra.

**Processo**
1. Usei `grep` com expressão regular para buscar o padrão desejado.
2. Ajustei o uso de `^` (início da linha) conforme o enunciado — descobri que o padrão pode estar em qualquer posição da linha.
3. Ao retirar o `^`, o padrão encontrou o resultado esperado: `Jesus`.

**Comando final**
```bash
grep -iE '.e.u' users.txt
