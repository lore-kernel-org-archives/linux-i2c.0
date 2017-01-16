From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/2] i2c: pca9541: Export OF device ID table as module aliases
Date: Mon, 16 Jan 2017 10:54:55 -0300
Message-ID: <1484574895-952-2-git-send-email-javier@osg.samsung.com>
References: <1484574895-952-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484574895-952-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

The I2C core always reports a MODALIAS of the form i2c:<foo> even if the
device was registered via OF, this means that exporting the OF device ID
table device aliases in the module is not needed. But in order to change
how the core reports modaliases to user-space, it's better to export it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/i2c/muxes/i2c-mux-pca9541.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index 4ea7e691afc7..77840f7845a1 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -90,6 +90,7 @@ static const struct of_device_id pca9541_of_match[] = {
 	{ .compatible = "nxp,pca9541" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, pca9541_of_match);
 #endif
 
 /*
-- 
2.7.4
