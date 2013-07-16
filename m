From: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Subject: [PATCH v2 1/2] i2c: Allow SPD probing with READ_BYTE_DATA and improve logging
Date: Tue, 16 Jul 2013 15:23:26 -0700
Message-ID: <2bb2489068b9d6e0833ed1d3f79a2a0c302b8c2f.1374012684.git.luto@amacapital.net>
References: <cover.1374012684.git.luto@amacapital.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1374012684.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
In-Reply-To: <cover.1374012684.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
References: <cover.1374012684.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The Intel iMC SMBUS controller can't READ_BYTE.  (This seems odd to me
-- it supports WRITE_BYTE.)  SPD EEPROMs are safe to probe with
READ_BYTE_DATA, so fall back to that.

While I'm in here, also show the address that had no probing method for
easier debugging.

Signed-off-by: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 991d38d..ea88fc0 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1501,8 +1501,13 @@ static int i2c_default_probe(struct i2c_adapter *adap, unsigned short addr)
 	else if (i2c_check_functionality(adap, I2C_FUNC_SMBUS_READ_BYTE))
 		err = i2c_smbus_xfer(adap, addr, 0, I2C_SMBUS_READ, 0,
 				     I2C_SMBUS_BYTE, &dummy);
+	else if ((addr & ~0x0f) == 0x50
+	 && i2c_check_functionality(adap, I2C_FUNC_SMBUS_READ_BYTE_DATA))
+		err = i2c_smbus_xfer(adap, addr, 0, I2C_SMBUS_READ, 0,
+				     I2C_SMBUS_BYTE_DATA, &dummy);
 	else {
-		dev_warn(&adap->dev, "No suitable probing method supported\n");
+		dev_warn(&adap->dev, "No suitable probing method supported for address 0x%02X\n",
+			 addr);
 		err = -EOPNOTSUPP;
 	}
 
-- 
1.8.1.4
