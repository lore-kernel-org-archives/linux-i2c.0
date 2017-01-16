From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/2] i2c: mux: pca954x: Export OF device ID table as module aliases
Date: Mon, 16 Jan 2017 10:54:54 -0300
Message-ID: <1484574895-952-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:58581
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751137AbdAPNzK (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 16 Jan 2017 08:55:10 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

The I2C core always reports a MODALIAS of the form i2c:<foo> even if the
device was registered via OF, this means that exporting the OF device ID
table device aliases in the module is not needed. But in order to change
how the core reports modaliases to user-space, it's better to export it.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/i2c/muxes/i2c-mux-pca954x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index dd18b9ccb1f4..a0232e079545 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -148,6 +148,7 @@ static const struct of_device_id pca954x_of_match[] = {
 	{ .compatible = "nxp,pca9548", .data = &chips[pca_9548] },
 	{}
 };
+MODULE_DEVICE_TABLE(of, pca954x_of_match);
 #endif
 
 /* Write to mux register. Don't use i2c_transfer()/i2c_smbus_xfer()
-- 
2.7.4
