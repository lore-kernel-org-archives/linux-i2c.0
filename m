From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 1/5] i2c: mux: pca954x: Add missing pca9542 definition to chip_desc
Date: Wed,  4 Jan 2017 17:29:53 +0800
Message-ID: <1483522197-38819-2-git-send-email-preid@electromag.com.au>
References: <1483522197-38819-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:42906 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965378AbdADNnx (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Jan 2017 08:43:53 -0500
In-Reply-To: <1483522197-38819-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: peda@axentia.se, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

The spec for the pca954x was missing. This chip is the same as the pca9540
except that it has interrupt lines. While the i2c_device_id table mapped
the pca9542 to the pca9540 definition the compatible table did not. In
preparation for irq support add the pca9542 definition.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/muxes/i2c-mux-pca954x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 8bc3d36..981d145 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -83,6 +83,11 @@ struct pca954x {
 		.enable = 0x4,
 		.muxtype = pca954x_ismux,
 	},
+	[pca_9542] = {
+		.nchans = 2,
+		.enable = 0x4,
+		.muxtype = pca954x_ismux,
+	},
 	[pca_9543] = {
 		.nchans = 2,
 		.muxtype = pca954x_isswi,
@@ -109,7 +114,7 @@ struct pca954x {
 
 static const struct i2c_device_id pca954x_id[] = {
 	{ "pca9540", pca_9540 },
-	{ "pca9542", pca_9540 },
+	{ "pca9542", pca_9542 },
 	{ "pca9543", pca_9543 },
 	{ "pca9544", pca_9544 },
 	{ "pca9545", pca_9545 },
-- 
1.8.3.1
