# Utiliser une image de base Python officielle
FROM python:3.8

# Définir le répertoire de travail dans le conteneur
WORKDIR /usr/src/app

# Copier les fichiers de dépendances et installer les dépendances
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste du code source de l'application dans le conteneur
COPY . .

# Collecter les fichiers statiques
RUN python manage.py collectstatic --no-input

# Définir la variable d'environnement pour exécuter l'application avec les paramètres par défaut
ENV DJANGO_SETTINGS_MODULE=oc_lettings_site.settings

# Exposer le port sur lequel l'application va tourner
EXPOSE 8000

# Démarrer l'application Django avec gunicorn
CMD gunicorn --bind 0.0.0.0:$PORT oc_lettings_site.wsgi:application

