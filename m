From: David Lechner <david@lechnology.com>
Subject: [PATCH 2/3] i2c: Add special case for detecting LEGO devices
Date: Mon,  5 Sep 2016 15:40:13 -0500
Message-ID: <1473108014-30787-3-git-send-email-david@lechnology.com>
References: <1473108014-30787-1-git-send-email-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473108014-30787-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: David Lechner <david@lechnology.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

LEGO chose to ignore the I2C specification and has created devices with
I2C addresses of 0x01 and 0x02. i2c_check_7bit_addr_validity_strict()
disallows these addresses, so we need a special case to skip this for
LEGO sensors.

Furthermore, LEGO devices do not respond to i2c_default_probe(), so we
skip this as a special case as well.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/i2c/i2c-core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index da3a02e..28436d9 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2591,12 +2591,14 @@ static int i2c_detect_address(struct i2c_client *temp_client,
 	int addr = temp_client->addr;
 	int err;
 
-	/* Make sure the address is valid */
-	err = i2c_check_7bit_addr_validity_strict(addr);
-	if (err) {
-		dev_warn(&adapter->dev, "Invalid probe address 0x%02x\n",
-			 addr);
-		return err;
+	/* Make sure the address is valid - LEGO devices break the rules */
+	if (!(driver->class & I2C_CLASS_LEGO)) {
+		err = i2c_check_7bit_addr_validity_strict(addr);
+		if (err) {
+			dev_warn(&adapter->dev, "Invalid probe address 0x%02x\n",
+				 addr);
+			return err;
+		}
 	}
 
 	/* Skip if already in use (7 bit, no need to encode flags) */
@@ -2604,7 +2606,8 @@ static int i2c_detect_address(struct i2c_client *temp_client,
 		return 0;
 
 	/* Make sure there is something at this address */
-	if (!i2c_default_probe(adapter, addr))
+	if (!(driver->class & I2C_CLASS_LEGO) &&
+	    !i2c_default_probe(adapter, addr))
 		return 0;
 
 	/* Finally call the custom detection function */
-- 
2.7.4
