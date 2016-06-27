From: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
Subject: [PATCH v2] i2c: i2c-mux-reg: wrong condition checked for
 of_address_to_resource return value
Date: Mon, 27 Jun 2016 12:57:47 +0200
Message-ID: <20160627105747.GA20280@nokia.com>
References: <20160627092144.GA20023@nokia.com>
 <20160627092624.GC1602@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-am1on0125.outbound.protection.outlook.com ([157.56.112.125]:18434
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751701AbcF0K6R (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 27 Jun 2016 06:58:17 -0400
Content-Disposition: inline
In-Reply-To: <20160627092624.GC1602@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, peda@axentia.se, linux-i2c@vger.kernel.org
Cc: alexander.sverdlin@nokia.com

of_address_to_resource return 0 on successful call but
devm_ioremap_resource is called only if it returns non-zero value

Signed-off-by: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
Changelog:
v2:
    Changed style of conditional expression as suggested by Wolfram.
 
 drivers/i2c/muxes/i2c-mux-reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 26e7c51..c6a90b4 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -145,7 +145,7 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 		mux->data.idle_in_use = true;
 
 	/* map address from "reg" if exists */
-	if (of_address_to_resource(np, 0, &res)) {
+	if (of_address_to_resource(np, 0, &res) == 0) {
 		mux->data.reg_size = resource_size(&res);
 		mux->data.reg = devm_ioremap_resource(&pdev->dev, &res);
 		if (IS_ERR(mux->data.reg))
-- 
2.5.0
