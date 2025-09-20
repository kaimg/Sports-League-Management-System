# notification.py — simple Web Push helper using VAPID
# pip deps: pywebpush, cryptography
import json, os
from typing import Dict, Iterable, Optional
from pywebpush import webpush, WebPushException

def build_payload(title: str, body: str, url: str = "/", icon: str = "/static/icons/icon-192.png", extra: Optional[dict]=None) -> str:
    data = {"title": title, "body": body, "url": url, "icon": icon}
    if extra: data.update(extra)
    return json.dumps(data)

class WebPushClient:
    def __init__(self, vapid_public: Optional[str]=None, vapid_private: Optional[str]=None, vapid_subject: Optional[str]=None):
        self.vapid_public  = vapid_public  or os.getenv("VAPID_PUBLIC_KEY")
        self.vapid_private = vapid_private or os.getenv("VAPID_PRIVATE_KEY")
        self.vapid_subject = vapid_subject or os.getenv("VAPID_SUBJECT", "mailto:admin@example.com")
        if not (self.vapid_public and self.vapid_private):
            raise ValueError("VAPID_PUBLIC_KEY and VAPID_PRIVATE_KEY must be set in env or passed in.")

    def send_to_subscription(self, subscription: Dict, data_json: str, ttl: int = 60) -> bool:
        try:
            webpush(
                subscription_info=subscription,
                data=data_json,
                vapid_private_key=self.vapid_private,
                vapid_claims={"sub": self.vapid_subject},
                ttl=ttl,
            )
            return True
        except WebPushException:
            # caller should prune 404/410 endpoints
            return False

    def send_to_many(self, subscriptions: Iterable[Dict], data_json: str, ttl: int = 60) -> Dict[str, bool]:
        results = {}
        for sub in subscriptions:
            endpoint = sub.get("endpoint", "(unknown)")
            results[endpoint] = self.send_to_subscription(sub, data_json, ttl=ttl)
        return results
