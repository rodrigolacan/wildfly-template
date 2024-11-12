FROM amazoncorretto:21

# Definir a variável de ambiente para o WildFly
ENV WILDFLY_HOME=/opt/wildfly

# Criar o diretório do WildFly
RUN mkdir -p ${WILDFLY_HOME}

# Copiar os arquivos do WildFly instalado na máquina para a imagem
COPY . ${WILDFLY_HOME}/

# Criar um usuário wildfly e dar permissões
RUN useradd -r -s /bin/false wildfly && \
    chown -R wildfly:wildfly ${WILDFLY_HOME}

# Definir o diretório de trabalho
WORKDIR ${WILDFLY_HOME}

# Ajustar permissões
RUN chmod -R 775 ${WILDFLY_HOME}

# Mudar para o usuário wildfly
USER wildfly

# Expor as portas do WildFly
EXPOSE 8081 9990

# Comando para iniciar o WildFly
CMD ["bin/standalone.sh", "-b", "0.0.0.0", "-Djboss.http.port=8080"]
