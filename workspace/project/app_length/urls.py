from django.urls import path
from app_length import views

app_name = 'app_length'

urlpatterns = [
    path('convert/', views.convert, name='convert'),
]