From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c: core: comment says "transmitted" but means "received"
Date: Wed, 25 Jan 2012 20:59:25 +0100
Message-ID: <1327521565-14988-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Fix that. Also convert this and the related comment to proper commenting
style.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 1e56061..e9c1893 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1386,8 +1386,10 @@ int i2c_master_send(const struct i2c_client *client, const char *buf, int count)
 
 	ret = i2c_transfer(adap, &msg, 1);
 
-	/* If everything went ok (i.e. 1 msg transmitted), return #bytes
-	   transmitted, else error code. */
+	/*
+	 * If everything went ok (i.e. 1 msg transmitted), return #bytes
+	 * transmitted, else error code.
+	 */
 	return (ret == 1) ? count : ret;
 }
 EXPORT_SYMBOL(i2c_master_send);
@@ -1414,8 +1416,10 @@ int i2c_master_recv(const struct i2c_client *client, char *buf, int count)
 
 	ret = i2c_transfer(adap, &msg, 1);
 
-	/* If everything went ok (i.e. 1 msg transmitted), return #bytes
-	   transmitted, else error code. */
+	/*
+	 * If everything went ok (i.e. 1 msg received), return #bytes received,
+	 * else error code.
+	 */
 	return (ret == 1) ? count : ret;
 }
 EXPORT_SYMBOL(i2c_master_recv);
-- 
1.7.8.3
