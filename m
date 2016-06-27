From: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
Subject: [PATCH] i2c: i2c-mux-reg: wrong condition checked for
 of_address_to_resource return value
Date: Mon, 27 Jun 2016 11:21:48 +0200
Message-ID: <20160627092144.GA20023@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db3on0131.outbound.protection.outlook.com ([157.55.234.131]:49312
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750870AbcF0Kze (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 27 Jun 2016 06:55:34 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, peda@axentia.se, linux-i2c@vger.kernel.org
Cc: alexander.sverdlin@nokia.com

of_address_to_resource return 0 on successful call but
devm_ioremap_resource is called only if it returns non-zero value

Signed-off-by: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 26e7c51..012a7ab 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -145,7 +145,7 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 		mux->data.idle_in_use = true;
 
 	/* map address from "reg" if exists */
-	if (of_address_to_resource(np, 0, &res)) {
+	if (!of_address_to_resource(np, 0, &res)) {
 		mux->data.reg_size = resource_size(&res);
 		mux->data.reg = devm_ioremap_resource(&pdev->dev, &res);
 		if (IS_ERR(mux->data.reg))
-- 
2.5.0
