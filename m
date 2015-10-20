From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [RESEND PATCH 1/4] i2c: ibm-iic: Fix module autoload for OF platform driver
Date: Tue, 20 Oct 2015 15:16:27 +0100
Message-ID: <1445350590-25911-2-git-send-email-luisbg@osg.samsung.com>
References: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445350590-25911-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, wsa@the-dreams.de, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, heiko@sntech.de, b.galvani@gmail.com, Luis de Bethencourt <luis@debethencourt.com>, Luis de Bethencourt <luisbg@osg.samsung.com>
List-Id: linux-i2c@vger.kernel.org

From: Luis de Bethencourt <luis@debethencourt.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/i2c/busses/i2c-ibm_iic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 722f839..ab49230 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -798,6 +798,7 @@ static const struct of_device_id ibm_iic_match[] = {
 	{ .compatible = "ibm,iic", },
 	{}
 };
+MODULE_DEVICE_TABLE(of, ibm_iic_match);
 
 static struct platform_driver ibm_iic_driver = {
 	.driver = {
-- 
2.5.3
