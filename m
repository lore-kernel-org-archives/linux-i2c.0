From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 1/2] i2c-stub: Remember the number of emulated chips
Date: Thu, 10 Jul 2014 12:45:11 +0200
Message-ID: <20140710124511.05108894@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This makes initialization, cleanup and look-up easier.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
---
This applies on top of Guenter's patch "i2c: stub: Add support for
SMBus block commands", v2.

 drivers/i2c/i2c-stub.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-3.16-rc3.orig/drivers/i2c/i2c-stub.c	2014-07-09 12:57:46.383772594 +0200
+++ linux-3.16-rc3/drivers/i2c/i2c-stub.c	2014-07-09 13:09:42.982241933 +0200
@@ -62,6 +62,7 @@ struct stub_chip {
 };
 
 static struct stub_chip *stub_chips;
+static int stub_chips_nr;
 
 static struct smbus_block_data *stub_find_block(struct device *dev,
 						struct stub_chip *chip,
@@ -95,7 +96,7 @@ static s32 stub_xfer(struct i2c_adapter
 	struct smbus_block_data *b;
 
 	/* Search for the right chip */
-	for (i = 0; i < MAX_CHIPS && chip_addr[i]; i++) {
+	for (i = 0; i < stub_chips_nr; i++) {
 		if (addr == chip_addr[i]) {
 			chip = stub_chips + i;
 			break;
@@ -281,12 +282,14 @@ static int __init i2c_stub_init(void)
 	}
 
 	/* Allocate memory for all chips at once */
-	stub_chips = kzalloc(i * sizeof(struct stub_chip), GFP_KERNEL);
+	stub_chips_nr = i;
+	stub_chips = kcalloc(stub_chips_nr, sizeof(struct stub_chip),
+			     GFP_KERNEL);
 	if (!stub_chips) {
 		pr_err("i2c-stub: Out of memory\n");
 		return -ENOMEM;
 	}
-	for (i--; i >= 0; i--)
+	for (i = 0; i < stub_chips_nr; i++)
 		INIT_LIST_HEAD(&stub_chips[i].smbus_blocks);
 
 	ret = i2c_add_adapter(&stub_adapter);


-- 
Jean Delvare
SUSE L3 Support
