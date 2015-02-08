From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] i2c: axxia: match return type of wait_for_completion_timeout
Date: Sun,  8 Feb 2015 05:31:25 -0500
Message-ID: <1423391485-30367-1-git-send-email-hofrat@osadl.org>
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
index 1decc88..9434824 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -408,7 +408,7 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 static int axxia_i2c_stop(struct axxia_i2c_dev *idev)
 {
 	u32 int_mask = MST_STATUS_ERR | MST_STATUS_SCC;
-	int ret;
+	unsigned long ret;
 
 	reinit_completion(&idev->msg_complete);
 
-- 
1.7.10.4
