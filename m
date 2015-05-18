From: Shailendra Verma <shailendra.capricorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 11/11] i2c-core: Fix typo in comment
Date: Mon, 18 May 2015 22:24:01 +0530
Message-ID: <1431968041-3226-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shailendra Verma <shailendra.capricorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


Signed-off-by: Shailendra Verma <shailendra.capricorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/i2c-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 987c124..c40141b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1673,7 +1673,7 @@ void i2c_del_adapter(struct i2c_adapter *adap)
 	 * FIXME: This is old code and should ideally be replaced by an
 	 * alternative which results in decoupling the lifetime of the struct
 	 * device from the i2c_adapter, like spi or netdev do. Any solution
-	 * should be throughly tested with DEBUG_KOBJECT_RELEASE enabled!
+	 * should be thoroughly tested with DEBUG_KOBJECT_RELEASE enabled!
 	 */
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
-- 
1.7.9.5
