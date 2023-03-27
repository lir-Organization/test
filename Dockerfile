#checkov:skip=CKV_DOCKER_2:Healthcheck is not relevant for ephemral containers
#checkov:skip=CKV_DOCKER_3:User is created automatically by lambda runtime
FROM public.ecr.aws/lambda/python:3.9
ENV AWS_REGION="us-west-2"
ENV AWS_ACCESS_KEY_ID="ASIAZAQLIHBHVVTSZBXA"

ENV PIP_ENV_VERSION="2022.1.8"
ENV AWS_SECRET_ACCESS_KEY="MJg0ygQbAI5lWklSlz3KxPx+X3LwiUqB2F1kzZ13"
RUN pip install pipenv==${PIP_ENV_VERSION}

COPY Pipfile Pipfile.lock ./

RUN pipenv lock -r > requirements.txt \
 && pipenv run pip install -r requirements.txt --target "${LAMBDA_TASK_ROOT}" \
 && rm -f requirements.txt Pipfile Pipfile.lock \
 && pip uninstall -y pipenv

COPY src/ "${LAMBDA_TASK_ROOT}/src/secret_checkov_scanner/image/src/"

CMD ["src.secret_checkov_scanner.image.src.app.handler"]
