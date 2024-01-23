## Résumé

Site web d'Orange County Lettings

## Développement local

### Prérequis

- Compte GitHub avec accès en lecture à ce repository
- Git CLI
- SQLite3 CLI
- Interpréteur Python, version 3.6 ou supérieure

Dans le reste de la documentation sur le développement local, il est supposé que la commande `python` de votre OS shell exécute l'interpréteur Python ci-dessus (à moins qu'un environnement virtuel ne soit activé).

### macOS / Linux

#### Cloner le repository

- `cd /path/to/put/project/in`
- `git clone https://github.com/OpenClassrooms-Student-Center/Python-OC-Lettings-FR.git`

#### Créer l'environnement virtuel

- `cd /path/to/Python-OC-Lettings-FR`
- `python -m venv venv`
- `apt-get install python3-venv` (Si l'étape précédente comporte des erreurs avec un paquet non trouvé sur Ubuntu)
- Activer l'environnement `source venv/bin/activate`
- Confirmer que la commande `python` exécute l'interpréteur Python dans l'environnement virtuel
`which python`
- Confirmer que la version de l'interpréteur Python est la version 3.6 ou supérieure `python --version`
- Confirmer que la commande `pip` exécute l'exécutable pip dans l'environnement virtuel, `which pip`
- Pour désactiver l'environnement, `deactivate`

#### Exécuter le site

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate`
- `pip install --requirement requirements.txt`
- `python manage.py runserver`
- Aller sur `http://localhost:8000` dans un navigateur.
- Confirmer que le site fonctionne et qu'il est possible de naviguer (vous devriez voir plusieurs profils et locations).

#### Linting

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate`
- `flake8`

#### Tests unitaires

- `cd /path/to/Python-OC-Lettings-FR`
- `source venv/bin/activate`
- `pytest`

#### Base de données

- `cd /path/to/Python-OC-Lettings-FR`
- Ouvrir une session shell `sqlite3`
- Se connecter à la base de données `.open oc-lettings-site.sqlite3`
- Afficher les tables dans la base de données `.tables`
- Afficher les colonnes dans le tableau des profils, `pragma table_info(Python-OC-Lettings-FR_profile);`
- Lancer une requête sur la table des profils, `select user_id, favorite_city from
  Python-OC-Lettings-FR_profile where favorite_city like 'B%';`
- `.quit` pour quitter

#### Panel d'administration

- Aller sur `http://localhost:8000/admin`
- Connectez-vous avec l'utilisateur `admin`, mot de passe `Abc1234!`

### Windows

Utilisation de PowerShell, comme ci-dessus sauf :

- Pour activer l'environnement virtuel, `.\venv\Scripts\Activate.ps1` 
- Remplacer `which <my-command>` par `(Get-Command <my-command>).Path`

### Déploiement

Récapitulatif du Fonctionnement du Déploiement
Notre application utilise un pipeline de déploiement automatisé via CircleCI qui assure la construction, le test et le déploiement de l'application sur Heroku. À chaque push dans la branche principale, CircleCI déclenche un workflow qui exécute les étapes suivantes :

Construction de l'Image Docker : L'application est conteneurisée à l'aide de Docker, ce qui garantit la cohérence de l'environnement à travers les différents stades du développement et de la production.

Tests : Des tests automatiques sont exécutés pour s'assurer que l'application fonctionne comme prévu.

Déploiement sur Heroku : Si les tests réussissent, l'image Docker est poussée sur le Heroku Container Registry, puis déployée sur Heroku.

Configuration Requise
Pour que le déploiement fonctionne correctement, vous devez configurer les éléments suivants :

CircleCI : Assurez-vous que votre projet est configuré dans CircleCI avec les variables d'environnement nécessaires. Ces variables incluent :

HEROKU_API_KEY : Clé API de votre compte Heroku.
DOCKERHUB_USERNAME et DOCKERHUB_PASS : Vos identifiants Docker Hub pour pousser des images.
Heroku : Un compte Heroku avec une application configurée pour recevoir les déploiements. Assurez-vous que l'application Heroku est liée à votre projet CircleCI.

Étapes de Déploiement
Pour déployer la dernière version de l'application, suivez ces étapes :

Mise à Jour du Code Source : Mettez à jour le code source de votre application et effectuez les tests nécessaires localement.

Push sur GitHub : Poussez vos modifications sur la branche principale de votre dépôt GitHub.

Automatisation via CircleCI :

Le push déclenchera automatiquement le pipeline de déploiement dans CircleCI.
Surveillez le processus dans l'interface de CircleCI pour vous assurer que toutes les étapes s'exécutent correctement.
Vérification sur Heroku :

Une fois le processus de déploiement terminé, vérifiez que l'application fonctionne correctement sur Heroku.
Accédez à l'URL de votre application Heroku pour effectuer une vérification en direct.
En suivant ces étapes, vous devriez pouvoir déployer de nouvelles versions de l'application sans problème.

### Commande à suivre pour le deploiement

Configuration de l'Image Docker et Push sur Docker Hub
Construire l'Image Docker :

Ouvrez votre terminal et naviguez jusqu'au dossier racine de votre projet.
Exécutez la commande suivante pour construire votre image Docker :
docker build -t votre_nom_utilisateur_dockerhub/nom_image:tag .
Remplacez votre_nom_utilisateur_dockerhub par votre nom d'utilisateur Docker Hub, nom_image par le nom que vous souhaitez donner à votre image, et tag par un tag spécifique, par exemple latest ou un identifiant de commit.

Push de l'Image sur Docker Hub 

Assurez-vous d'être connecté à Docker Hub. Si ce n'est pas le cas, connectez-vous avec :
docker login --username votre_nom_utilisateur_dockerhub --password votre_mot_de_passe

Poussez l'image sur Docker Hub avec la commande :
docker push votre_nom_utilisateur_dockerhub/nom_image:tag

Déploiement sur Heroku

Tag de l'Image pour Heroku 

Une fois l'image Docker disponible sur Docker Hub, tagguez-la pour le Heroku Container Registry :
docker tag votre_nom_utilisateur_dockerhub/nom_image:tag registry.heroku.com/nom_app_heroku/web

Push de l'Image sur Heroku Container Registry 

Connectez-vous au Container Registry de Heroku :
heroku container:login

Poussez votre image sur Heroku :
docker push registry.heroku.com/nom_app_heroku/web

Déployer l'Application sur Heroku 

Utilisez la commande suivante pour lancer l'application :
heroku container:release web -a nom_app_heroku

Vérifiez que l'application fonctionne en accédant à son URL ou en utilisant :
heroku open -a nom_app_heroku

### Notes Importantes
Assurez-vous que toutes les configurations nécessaires pour votre application sont correctement définies, notamment les variables d'environnement sur Heroku.

Les étapes ci-dessus supposent que vous avez déjà un compte Docker Hub et Heroku configuré et que vous avez installé Docker et Heroku CLI sur votre machine.

Si vous souhaitez tester votre image docker en local, je vous invite à suivre les commandes suivantes: 
vous devez d'abord la télécharger (pull) puis l'exécuter (run) avec Docker. Voici les étapes que vous pouvez suivre.
Ouvrez un terminal sur votre machine locale.
Téléchargez (pull) l'image Docker depuis Docker Hub :
docker pull utilisateur/votre_image:tag
Remplacez tag par le tag spécifique de l'image que vous souhaitez exécuter. Si vous voulez la dernière version, vous pouvez utiliser latest ou le hash du commit si vous l'avez tagué ainsi.
Exécutez l'image Docker en tant que conteneur :
docker run -p port_local:port_conteneur utilisateur/votre_image:tag
Remplacez port_local par le port de votre choix sur lequel vous voulez accéder à l'application depuis votre navigateur, et port_conteneur par le port sur lequel l'application dans le conteneur est configurée pour écouter.

Par exemple, si votre application Docker est configurée pour écouter sur le port 80 et que vous souhaitez y accéder via le port 8080 sur votre machine locale, la commande serait :
docker run -p 8000:8000 -e PORT=8000 utilisateur/votre_image:tag
Après avoir exécuté cette commande, vous devriez pouvoir accéder à l'application via http://localhost:8080 dans votre navigateur ou via Docker Desktop.
