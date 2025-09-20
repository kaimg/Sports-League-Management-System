// static/sw.js
self.addEventListener('push', event => {
  const data = event.data ? event.data.json() : {};
  event.waitUntil(self.registration.showNotification(data.title || 'Update', {
    body: data.body || '',
    icon: data.icon || '/static/icons/icon-192.png',
    data: data.url || '/'
  }));
});

self.addEventListener('notificationclick', event => {
  event.notification.close();
  const url = event.notification.data || '/';
  event.waitUntil(clients.openWindow(url));
});
