From: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
Subject: [PATCH] i2c: Provide of_match_table to i2c-mux-reg
Date: Mon, 6 Jun 2016 15:51:50 +0200
Message-ID: <20160606135147.GA9810@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-am1on0110.outbound.protection.outlook.com ([157.56.112.110]:13765
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751698AbcFFPY0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 6 Jun 2016 11:24:26 -0400
Content-Disposition: inline
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: peda@axentia.se, wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: alexander.sverdlin@nokia.com

of_match_table was not filled which prevents device to be
instantiated from device tree node.

Signed-off-by: Lukasz Gemborowski <lukasz.gemborowski@nokia.com>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 6773cad..26e7c51 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -260,6 +260,7 @@ static struct platform_driver i2c_mux_reg_driver = {
 	.remove	= i2c_mux_reg_remove,
 	.driver	= {
 		.name	= "i2c-mux-reg",
+		.of_match_table = of_match_ptr(i2c_mux_reg_of_match),
 	},
 };
 
-- 
2.5.0
