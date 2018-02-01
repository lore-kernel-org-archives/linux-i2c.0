From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] i2c-mux-reg: Delete an error message for a failed memory
 allocation in i2c_mux_reg_probe_dt()
Date: Thu, 1 Feb 2018 17:24:10 +0100
Message-ID: <224a8918-f882-9ab1-218c-83df93d4cb2f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:58943 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751567AbeBAQY1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 1 Feb 2018 11:24:27 -0500
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, York Sun <yorksun@freescale.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@nokia.com>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Feb 2018 17:17:19 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index c948e5a4cb04..f624ed64a47b 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -127,10 +127,8 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 	values = devm_kzalloc(&pdev->dev,
 			      sizeof(*mux->data.values) * mux->data.n_values,
 			      GFP_KERNEL);
-	if (!values) {
-		dev_err(&pdev->dev, "Cannot allocate values array");
+	if (!values)
 		return -ENOMEM;
-	}
 
 	for_each_child_of_node(np, child) {
 		of_property_read_u32(child, "reg", values + i);
-- 
2.16.1
