From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH v2] i2c: axxia: fixup return type of wait_for_completion_timeout
Date: Sun,  8 Feb 2015 10:36:48 -0500
Message-ID: <1423409808-9937-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Anders Berg <anders.berg-1wcpHE2jlwO1Z/+hSey0Gg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int. The
return variable is renamed to reflect its use and the type adjusted to
unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

v2: variable renamed rather than just changing the type as suggested by
    Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>. Further the two separate patches
    were merged as the changed are conceptually identical.

Patch was only compile tested with axm55xx_defconfig
(implies CONFIG_I2C_AXXIA=y)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/i2c/busses/i2c-axxia.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index 768a598..7e45d05 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -334,7 +334,7 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 	u32 int_mask = MST_STATUS_ERR | MST_STATUS_SNS;
 	u32 rx_xfer, tx_xfer;
 	u32 addr_1, addr_2;
-	int ret;
+	unsigned long timeout;
 
 	if (msg->len > 255) {
 		dev_warn(idev->dev, "unsupported length %u\n", msg->len);
@@ -388,15 +388,15 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 
 	i2c_int_enable(idev, int_mask);
 
-	ret = wait_for_completion_timeout(&idev->msg_complete,
-					  I2C_XFER_TIMEOUT);
+	timeout = wait_for_completion_timeout(&idev->msg_complete,
+					      I2C_XFER_TIMEOUT);
 
 	i2c_int_disable(idev, int_mask);
 
 	if (readl(idev->base + MST_COMMAND) & CMD_BUSY)
 		dev_warn(idev->dev, "busy after xfer\n");
 
-	if (ret == 0)
+	if (timeout == 0)
 		idev->msg_err = -ETIMEDOUT;
 
 	if (unlikely(idev->msg_err) && idev->msg_err != -ENXIO)
@@ -408,17 +408,17 @@ static int axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
 static int axxia_i2c_stop(struct axxia_i2c_dev *idev)
 {
 	u32 int_mask = MST_STATUS_ERR | MST_STATUS_SCC;
-	int ret;
+	unsigned long timeout;
 
 	reinit_completion(&idev->msg_complete);
 
 	/* Issue stop */
 	writel(0xb, idev->base + MST_COMMAND);
 	i2c_int_enable(idev, int_mask);
-	ret = wait_for_completion_timeout(&idev->msg_complete,
-					  I2C_STOP_TIMEOUT);
+	timeout = wait_for_completion_timeout(&idev->msg_complete,
+					      I2C_STOP_TIMEOUT);
 	i2c_int_disable(idev, int_mask);
-	if (ret == 0)
+	if (timeout == 0)
 		return -ETIMEDOUT;
 
 	if (readl(idev->base + MST_COMMAND) & CMD_BUSY)
-- 
1.7.10.4
