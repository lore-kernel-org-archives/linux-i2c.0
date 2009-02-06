From: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
Subject: [PATCH 2/2] i2c pxa: add the force reset method.
Date: Fri,  6 Feb 2009 16:23:18 +0100
Message-ID: <1233933798-17673-2-git-send-email-giometti@linux.it>
References: <1233933798-17673-1-git-send-email-giometti@linux.it>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1233933798-17673-1-git-send-email-giometti-k2GhghHVRtY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 6af6814..ccbc9ba 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -963,6 +963,13 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 	return ret;
 }
 
+static void i2c_pxa_force_reset(struct i2c_adapter *adap)
+{
+	struct pxa_i2c *i2c = adap->algo_data;
+
+	i2c_pxa_reset(i2c);
+}
+
 static u32 i2c_pxa_functionality(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
@@ -1065,6 +1072,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	i2c->adap.algo_data = i2c;
 	i2c->adap.dev.parent = &dev->dev;
+	i2c->adap.reset	  = i2c_pxa_force_reset;
 
 	ret = i2c_add_numbered_adapter(&i2c->adap);
 	if (ret < 0) {
-- 
1.5.6.3
