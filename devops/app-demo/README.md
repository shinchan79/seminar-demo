``
cd backend
copilot app init todo
copilot env init
``

copilot/environments/development/manifest.yml
```
copilot env ls
copilot env deploy
```

# Set up backend
```
copilot svc init
```
 To add a healthcheck, modify copilot/backend/manifest.yml, and add the healthcheck section shown below in the image section directly below port:
 
 ```
 image:
  build: backend/Dockerfile
  # Port exposed through your container to route traffic to it.
  port: 10000
  healthcheck:
    command: ["CMD-SHELL", "curl -f http://localhost:10000/ishealthy || exit 1"]
    interval: 10s
    retries: 2
    timeout: 6s 
    start_period: 10s
```

If you are curious how the healthcheck was implemented in the backend, take a look at the route added in app.py:

```
@app.route('/ishealthy')
def receive_health_check():
    return "Health check succeed\n"
```

create DynamoDB: 
```
copilot storage init

copilot svc deploy
copilot svc status

mkdir todobackend
mv automate-container-microservices-aws-copilot/code/backend/* todobackend/
```
The todobackend folder should now contain the following:
```
.
├── Dockerfile
├── app.py
├── copilot
│   ├─ backend
│   │   ├─ addons
│   │   │   └── todotable.yml
│   │   └── manifest.yml
│   └── environments
│       └── development
│           └── manifest.yml
├─ manifests
│   ├─ backend
│   │   ├─ addons
│   │   │   └── todotable.yml
│   │   └── manifest.yml
│   └── environments
│       └── development
│           └── manifest.yml
└── requirements.txt
```

```
cd todobackend
aws codecommit create-repository --repository-name todobackend --repository-description "My todoapp repository"
git init
git switch -c main
git remote add origin https://git-codecommit.$(aws configure get region).amazonaws.com/v1/repos/todobackend

copilot pipeline init
```

You will also see an error message between the command you entered and where it is asking for input with the following:

```
Only one git remote detected. Your pipeline will follow 'https://git-codecommit.us-west-2.amazonaws.com/v1/repos/todobackend'.
fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
Your pipeline will follow branch 'main'.
```

 Let's continue with the prompts to set up our CI/CD pipeline. 
 todobackend-main
 Workloads
 dev
 No additional environments
 ```
copilot pipeline deploy

git add -A
git commit -m 'initial commit'
git push origin main
```
# Frontend 
cd frontend
```
copilot app init
```
Y
todo
```
copilot svc init
Load Balanced Web Service
frontend
.Dockerfile

copilot svc deploy
copilot svc status

mkdir todofrontend
mv automate-container-microservices-aws-copilot/code/frontend/* todofrontend/
```

```
.
├── Dockerfile
├── backend.conf.template
├── manifests
│   ├── environments
│   │   └── development
│   │       └── manifest.yml
│   └─── frontend
│           └── manifest.yml
├── nginx.conf
└── webapp
    ├── README.md
    ├── package.json
    ├── public
    │   ├── index.html
    │   ├── manifest.json
    │   └── robots.txt
    ├── src
    │   ├── App.css
    │   ├── App.test.tsx
    │   ├── App.tsx
    │   ├── Types.ts
    │   ├── components
    │   │   ├── TableOperation.tsx
    │   │   ├── TaskInput.tsx
    │   │   ├── TaskItem.tsx
    │   │   ├── TaskList.tsx
    │   │   └── util.ts
    │   ├── index.css
    │   ├── index.tsx
    │   ├── modules
    │   │   └── tasksModule.ts
    │   ├── react-app-env.d.ts
    │   ├── reportWebVitals.ts
    │   ├── rootReducer.ts
    │   ├── setupTests.ts
    │   └── store.ts
    └── tsconfig.json
```

```
cd todofrontend
aws codecommit create-repository --repository-name todofrontend --repository-description "My todoapp frontend repository"
git init
git switch -c main
git remote add origin https://git-codecommit.$(aws configure get region).amazonaws.com/v1/repos/todofrontend

git add -A
git commit -m 'initial commit'
git push origin main
```
Dọn dẹp
```
aws codecommit delete-repository --repository-name todofrontend
aws codecommit delete-repository --repository-name todobackend
```