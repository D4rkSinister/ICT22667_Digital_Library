"""
ASGI config for theparak_library project.
"""

import os

from django.core.asgi import get_asgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'theparak_library.settings')

application = get_asgi_application()
