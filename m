From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: [PATCH] i2c: Improve logging on failure to probe for ->class devices
Date: Wed, 17 Jul 2013 13:27:59 -0700
Message-ID: <7416fe787fbbe867a2a980b3a2e2de6cec7bf5f6.1374092773.git.luto@amacapital.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

While writing the i2c-imc driver, I noticed that the warning message
when the i2c core can't figure out how to probe is mostly useless.
This trivial patch improves it.

Signed-off-by: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 991d38d..213df0a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1502,7 +1502,8 @@ static int i2c_default_probe(struct i2c_adapter *adap, unsigned short addr)
 		err = i2c_smbus_xfer(adap, addr, 0, I2C_SMBUS_READ, 0,
 				     I2C_SMBUS_BYTE, &dummy);
 	else {
-		dev_warn(&adap->dev, "No suitable probing method supported\n");
+		dev_warn(&adap->dev, "No suitable probing method supported for address 0x%02X\n",
+			 addr);
 		err = -EOPNOTSUPP;
 	}
 
-- 
1.8.1.4
