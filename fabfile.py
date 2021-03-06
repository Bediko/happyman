from fabric.api import *

env.hosts = [
    'shaperia@happyman.skyshaper.org'
]

def deploy():
    with cd('happyman'):
        run('git pull')
        run('carton install')
    run('svc -t ~/service/happyman')

def restart():
    run('svc -t ~/service/happyman')
