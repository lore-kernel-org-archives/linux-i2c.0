From: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] i2c: wmt: match return type of wait_for_completion_timeout
Date: Sun,  8 Feb 2015 05:43:52 -0500
Message-ID: <1423392232-12937-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

return type of wait_for_completion_timeout is unsigned long not int. as 
wait_result is only used for wait_for_completion_timeout here the type 
is simply changed to unsigned long.

Signed-off-by: Nicholas Mc Guire <hofrat-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>
---

Patch was only compile tested with vt8500_v6_v7_defconfig
(implies CONFIG_I2C_WMT=y)

Patch is against 3.19.0-rc7 (localversion-next is -next-20150204)

 drivers/i2c/busses/i2c-wmt.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-wmt.c b/drivers/i2c/busses/i2c-wmt.c
index 82ea349..464600a 100644
--- a/drivers/i2c/busses/i2c-wmt.c
+++ b/drivers/i2c/busses/i2c-wmt.c
@@ -128,7 +128,8 @@ static int wmt_i2c_write(struct i2c_adapter *adap, struct i2c_msg *pmsg,
 {
 	struct wmt_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
 	u16 val, tcr_val;
-	int ret, wait_result;
+	int ret;
+	unsigned long wait_result;
 	int xfer_len = 0;
 
 	if (!(pmsg->flags & I2C_M_NOSTART)) {
@@ -218,7 +219,8 @@ static int wmt_i2c_read(struct i2c_adapter *adap, struct i2c_msg *pmsg,
 {
 	struct wmt_i2c_dev *i2c_dev = i2c_get_adapdata(adap);
 	u16 val, tcr_val;
-	int ret, wait_result;
+	int ret;
+	unsigned long wait_result;
 	u32 xfer_len = 0;
 
 	if (!(pmsg->flags & I2C_M_NOSTART)) {
-- 
1.7.10.4
