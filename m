From: Andreas Werner <wernerandy@gmx.de>
Subject: [PATCH] I2C: busses: Do not print error message in syslog if no ACK received
Date: Tue, 12 Nov 2013 18:45:36 +0100
Message-ID: <1384278336-3694-1-git-send-email-wernerandy@gmx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: jacmet@sunsite.dk, marex@denx.de, baohua.song@csr.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, wernerandy@gmx.de
List-Id: linux-i2c@vger.kernel.org

Using the i2c-eg20t driver and call i2cdetect or probe on the bus,
the driver will print a lot of error messages if there was no ACK
received.

i2cdetect normally print a table with all the available devices. If there
is no device on the address, the table will be empty.
Currently with the i2c-eg20t driver, the table is not visible because
the error messages destroy the table.

Error message: pch_i2c_getack return -71

This patch prevent the driver to print the messages to syslog if debug is not set.

Tested on Intel Atom E6xx and Eg20t Chipset.

Signed-off-by: Andreas Werner <wernerandy@gmx.de>
---
 drivers/i2c/busses/i2c-eg20t.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index 0f37529..b10c651 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -322,7 +322,7 @@ static s32 pch_i2c_getack(struct i2c_algo_pch_data *adap)
 	reg_val = ioread32(p + PCH_I2CSR) & PCH_GETACK;
 
 	if (reg_val != 0) {
-		pch_err(adap, "return%d\n", -EPROTO);
+		pch_dbg(adap, "return%d\n", -EPROTO);
 		return -EPROTO;
 	}
 
-- 
1.8.4
