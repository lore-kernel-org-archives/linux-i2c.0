From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] i2c: ismt: fix type of return var of wait_for_completion_timeout
Date: Sun,  8 Feb 2015 03:03:30 -0500
Message-ID: <1423382611-24463-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Seth Heasley <seth.heasley@intel.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, Wolfram Sang <wsa@the-dreams.de>, Fan Du <fan.du@intel.com>, Jingoo Han <jg1.han@samsung.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-i2c@vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int. As 
ret is in used for other calls a new appropriately typed variable timeout
is added to handle wait_for_completion_timeout 

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was only compile tested with x86_64_defconfig + CONFIG_I2C_ISMT=m

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/i2c/busses/i2c-ismt.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ismt.c b/drivers/i2c/busses/i2c-ismt.c
index f2b0ff0..2197ac8 100644
--- a/drivers/i2c/busses/i2c-ismt.c
+++ b/drivers/i2c/busses/i2c-ismt.c
@@ -380,6 +380,7 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 		       int size, union i2c_smbus_data *data)
 {
 	int ret;
+	unsigned long timeout;
 	dma_addr_t dma_addr = 0; /* address of the data buffer */
 	u8 dma_size = 0;
 	enum dma_data_direction dma_direction = 0;
@@ -578,13 +579,13 @@ static int ismt_access(struct i2c_adapter *adap, u16 addr,
 	ismt_submit_desc(priv);
 
 	/* Now we wait for interrupt completion, 1s */
-	ret = wait_for_completion_timeout(&priv->cmp, HZ*1);
+	timeout = wait_for_completion_timeout(&priv->cmp, HZ*1);
 
 	/* unmap the data buffer */
 	if (dma_size != 0)
 		dma_unmap_single(&adap->dev, dma_addr, dma_size, dma_direction);
 
-	if (unlikely(!ret)) {
+	if (unlikely(!timeout)) {
 		dev_err(dev, "completion wait timed out\n");
 		ret = -ETIMEDOUT;
 		goto out;
-- 
1.7.10.4
