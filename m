From: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: add sanity check to i2c_put_adapter
Date: Thu,  1 Aug 2013 14:10:46 +0200
Message-ID: <1375359046-17472-1-git-send-email-sebastian.hesselbarth@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

i2c_put_adapter dereferences i2c_adapter pointer passed without check
for NULL. This adds a check for non-NULL pointer to allow i2c_put_adapter
called with NULL and behave the same way i2c_release_client does already.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/i2c/i2c-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index f32ca29..d075df6 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1825,7 +1825,8 @@ EXPORT_SYMBOL(i2c_get_adapter);
 
 void i2c_put_adapter(struct i2c_adapter *adap)
 {
-	module_put(adap->owner);
+	if (adap)
+		module_put(adap->owner);
 }
 EXPORT_SYMBOL(i2c_put_adapter);
 
-- 
1.7.10.4
