From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/4] i2c: Document reserved I2C addresses
Date: Mon, 31 May 2010 13:31:54 +0200
Message-ID: <20100531133154.48271f0e@hyperion.delvare>
References: <20100531132213.65f20b8f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100531132213.65f20b8f-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Matthieu Castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Move strict I2C address validity check to a single function, and
document the reserved I2C addresses there.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
---
 drivers/i2c/i2c-core.c |   28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

--- linux-2.6.35-rc0.orig/drivers/i2c/i2c-core.c	2010-05-30 16:17:56.000000000 +0200
+++ linux-2.6.35-rc0/drivers/i2c/i2c-core.c	2010-05-30 16:17:58.000000000 +0200
@@ -387,6 +387,27 @@ static int i2c_check_client_addr_validit
 	return 0;
 }
 
+/* And this is a strict address validity check, used when probing. If a
+ * device uses a reserved address, then it shouldn't be probed. 7-bit
+ * addressing is assumed, 10-bit address devices are rare and should be
+ * explicitly enumerated. */
+static int i2c_check_addr_validity(unsigned short addr)
+{
+	/*
+	 * Reserved addresses per I2C specification:
+	 *  0x00       General call address / START byte
+	 *  0x01       CBUS address
+	 *  0x02       Reserved for different bus format
+	 *  0x03       Reserved for future purposes
+	 *  0x04-0x07  Hs-mode master code
+	 *  0x78-0x7b  10-bit slave addressing
+	 *  0x7c-0x7f  Reserved for future purposes
+	 */
+	if (addr < 0x08 || addr > 0x77)
+		return -EINVAL;
+	return 0;
+}
+
 /**
  * i2c_new_device - instantiate an i2c device
  * @adap: the adapter managing the device
@@ -1340,10 +1361,11 @@ static int i2c_detect_address(struct i2c
 	int err;
 
 	/* Make sure the address is valid */
-	if (addr < 0x03 || addr > 0x77) {
+	err = i2c_check_addr_validity(addr);
+	if (err) {
 		dev_warn(&adapter->dev, "Invalid probe address 0x%02x\n",
 			 addr);
-		return -EINVAL;
+		return err;
 	}
 
 	/* Skip if already in use */
@@ -1446,7 +1468,7 @@ i2c_new_probed_device(struct i2c_adapter
 
 	for (i = 0; addr_list[i] != I2C_CLIENT_END; i++) {
 		/* Check address validity */
-		if (addr_list[i] < 0x03 || addr_list[i] > 0x77) {
+		if (i2c_check_addr_validity(addr_list[i]) < 0) {
 			dev_warn(&adap->dev, "Invalid 7-bit address "
 				 "0x%02x\n", addr_list[i]);
 			continue;

-- 
Jean Delvare
