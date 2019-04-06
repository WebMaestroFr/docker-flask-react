FROM node:10-alpine AS yarn

WORKDIR /root

COPY public public
COPY src src
COPY package.json yarn.* .

RUN yarn install
RUN yarn build

ENTRYPOINT [ "yarn" ]
CMD [ "start" ]


FROM python:3-alpine AS flask

WORKDIR /root

COPY --from=yarn /root/build build

COPY app app
COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

ENTRYPOINT [ "flask" ]
CMD [ "run", "--host=0.0.0.0" ]
