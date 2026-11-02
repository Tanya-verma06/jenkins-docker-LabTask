FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY Project/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]