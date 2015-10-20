From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [RESEND PATCH 3/4] i2c: rk3x: Fix module autoload for OF platform driver
Date: Tue, 20 Oct 2015 15:16:29 +0100
Message-ID: <1445350590-25911-4-git-send-email-luisbg@osg.samsung.com>
References: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:38363 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753122AbbJTOQe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 20 Oct 2015 10:16:34 -0400
In-Reply-To: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, heiko@sntech.de, b.galvani@gmail.com, Luis de Bethencourt <luis@debethencourt.com>, Luis de Bethencourt <luisbg@osg.samsung.com>

From: Luis de Bethencourt <luis@debethencourt.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/i2c/busses/i2c-rk3x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 72e97e30..c1935eb 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -858,6 +858,7 @@ static const struct of_device_id rk3x_i2c_match[] = {
 	{ .compatible = "rockchip,rk3288-i2c", .data = (void *)&soc_data[2] },
 	{},
 };
+MODULE_DEVICE_TABLE(of, rk3x_i2c_match);
 
 static int rk3x_i2c_probe(struct platform_device *pdev)
 {
-- 
2.5.3
