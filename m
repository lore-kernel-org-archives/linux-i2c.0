From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH v2] i2c: designware: fixup return handling of wait_for_completion_timeout
Date: Tue, 10 Feb 2015 03:11:14 -0500
Message-ID: <1423555874-19650-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Du Wenkai <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int, rather
than introducing a new variable the wait_for_completion_timeout is moved
into the if condition as the return value is only used to detect timeout.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

v2: Aside from the newly added variable having the wrong type (...) the
    preferred solution is to simply wrap wait_for_completion_timeout into
    the condition as the remaining jiffies is actually not used - suggested
    be Jarkko Nikula <jarkko.nikula-VuQAYsv1561d/zcNHIZz5Q@public.gmane.org

Patch was compile tested with x86_64_defconfig +
CONFIG_X86_AMD_PLATFORM_DEVICE=y, CONFIG_I2C_DESIGNWARE_PLATFORM=m
(implies CONFIG_I2C_DESIGNWARE_CORE=y)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150209)

 drivers/i2c/busses/i2c-designware-core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 6e25c01..6f19a33 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -656,8 +656,7 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	i2c_dw_xfer_init(dev);
 
 	/* wait for tx to complete */
-	ret = wait_for_completion_timeout(&dev->cmd_complete, HZ);
-	if (ret == 0) {
+	if (!wait_for_completion_timeout(&dev->cmd_complete, HZ)) {
 		dev_err(dev->dev, "controller timed out\n");
 		/* i2c_dw_init implicitly disables the adapter */
 		i2c_dw_init(dev);
-- 
1.7.10.4
