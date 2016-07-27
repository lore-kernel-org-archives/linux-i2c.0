From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 6/7] i2c: pca9541: add device tree binding
Date: Wed, 27 Jul 2016 10:43:29 +0200
Message-ID: <1469609010-23049-7-git-send-email-peda@axentia.se>
References: <1469609010-23049-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469609010-23049-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, Emil Velikov <emil.l.velikov@gmail.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 3cb8af635db5..40e137ae242e 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -85,6 +85,13 @@ static const struct i2c_device_id pca9541_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, pca9541_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id pca9541_of_match[] = {
+	{ .compatible = "nxp,pca9541" },
+	{}
+};
+#endif
+
 /*
  * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
  * as they will try to lock the adapter a second time.
@@ -382,6 +389,7 @@ static int pca9541_remove(struct i2c_client *client)
 static struct i2c_driver pca9541_driver = {
 	.driver = {
 		   .name = "pca9541",
+		   .of_match_table = of_match_ptr(pca9541_of_match),
 		   },
 	.probe = pca9541_probe,
 	.remove = pca9541_remove,
-- 
2.1.4
