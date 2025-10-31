# Ataque no dia de Natal

**Contexto:** Desafio FIAPLAB — análise de `access_log` para identificar qual malware fez requisições ao servidor.

**Resumo do processo**
1. Localizei o arquivo `access_log` e analisei o formato das entradas (IP, data, método, URL, User-Agent).
2. Procurei padrões repetidos com `grep` e filtrei por IPs que apareciam com muita frequência.
3. Extraí as linhas do IP suspeito para um arquivo separado para leitura detalhada.
4. Observei requisições a caminhos conhecidos por scans/exploit attempts, como `/muieblackcat` e `/jorgee/`.
5. Busquei por “jorgee” diretamente no log e confirmei múltiplas tentativas com esse User-Agent.

**Conclusão:** O malware identificado nas requisições é o **Jorgee**.

**Comandos exemplares usados**
```bash
# procurar linhas com um IP específico
grep 192.10.30.254 access_log > verificandoipjorgee.txt

# procurar por ocorrência do termo jorgee (case-insensitive)
grep -i "jorgee" access_log
