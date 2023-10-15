from django.contrib import admin
from django.urls import path, include

from . import views


def trigger_error(request):
    division_by_zero = 1 / 0


urlpatterns = [
    path('', views.index, name='index'),
    path('admin/', admin.site.urls),
    path('', include('Profile.urls')),
    path('', include('Letting.urls')),
    path('sentry-debug/', trigger_error),

]
