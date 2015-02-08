From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] i2c: axxia: match var to return type of wait_for_completion_timeout
Date: Sun,  8 Feb 2015 03:33:22 -0500
Message-ID: <1423384402-11572-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Anders Berg <anders.berg@avagotech.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-i2c@vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int. as ret
is only used for wait_for_completion_timeout here the type is simply changed
unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was only compile tested with axm55xx_defconfig
(implies CONFIG_I2C_AXXIA=y)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/i2c/busses/i2c-axxia.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 768a598..1decc88 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -334,7 +334,7 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 	u32 int_mask = MST_STATUS_ERR | MST_STATUS_SNS;
 	u32 rx_xfer, tx_xfer;
 	u32 addr_1, addr_2;
-	int ret;
+	unsigned long ret;
 
 	if (msg->len > 255) {
 		dev_warn(idev->dev, "unsupported length %u\n", msg->len);
-- 
1.7.10.4
