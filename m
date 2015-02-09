From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] i2c-designware: fixup of wait_for_completion_timeout return handling
Date: Mon,  9 Feb 2015 11:35:39 -0500
Message-ID: <1423499739-9423-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, Du Wenkai <wenkai.du@intel.com>, Shinya Kuribayashi <skuribay@pobox.com>, Romain Baeriswyl <Romain.Baeriswyl@abilis.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andrew Jackson <Andrew.Jackson@arm.com>, David Box <david.e.box@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-i2c@vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int. 
An appropriate return variable is introduced and assignment fixed up.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was compile tested with x86_64_defconfig +
CONFIG_X86_AMD_PLATFORM_DEVICE=y, CONFIG_I2C_DESIGNWARE_PLATFORM=m
(implies CONFIG_I2C_DESIGNWARE_CORE=y)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150209)

 drivers/i2c/busses/i2c-designware-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 6e25c01..05934e0 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -623,6 +623,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 {
 	struct dw_i2c_dev *dev = i2c_get_adapdata(adap);
 	int ret;
+	unsigned int timeout;
 
 	dev_dbg(dev->dev, "%s: msgs: %d\n", __func__, num);
 
@@ -656,8 +657,8 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	i2c_dw_xfer_init(dev);
 
 	/* wait for tx to complete */
-	ret = wait_for_completion_timeout(&dev->cmd_complete, HZ);
-	if (ret == 0) {
+	timeout = wait_for_completion_timeout(&dev->cmd_complete, HZ);
+	if (timeout == 0) {
 		dev_err(dev->dev, "controller timed out\n");
 		/* i2c_dw_init implicitly disables the adapter */
 		i2c_dw_init(dev);
-- 
1.7.10.4
