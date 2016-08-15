From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 7/8] i2c: pca9541: add device tree binding
Date: Mon, 15 Aug 2016 15:40:30 +0200
Message-ID: <1471268431-5148-8-git-send-email-peda@axentia.se>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0137.outbound.protection.outlook.com ([104.47.2.137]:2648
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753151AbcHONl4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 15 Aug 2016 09:41:56 -0400
In-Reply-To: <1471268431-5148-1-git-send-email-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>

No longer rely on the implicit matching with the i2c device name, use
an explicit compatible string instead.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index f052c3067791..4ea7e691afc7 100644
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
@@ -383,6 +390,7 @@ static int pca9541_remove(struct i2c_client *client)
 static struct i2c_driver pca9541_driver = {
 	.driver = {
 		   .name = "pca9541",
+		   .of_match_table = of_match_ptr(pca9541_of_match),
 		   },
 	.probe = pca9541_probe,
 	.remove = pca9541_remove,
-- 
2.1.4
