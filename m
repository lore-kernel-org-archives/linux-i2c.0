From: Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH] i2c: mediatek: add i2c resume support
Date: Tue, 6 Oct 2015 17:22:56 +0800
Message-ID: <1444123376-24448-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:34105 "EHLO
	mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751382AbbJFJX1 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 6 Oct 2015 05:23:27 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Liguo Zhang <liguo.zhang@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, Xudong Chen <xudong.chen@mediatek.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>

From: Liguo Zhang <liguo.zhang@mediatek.com>

mt65xx i2c controller initial setting will be cleared after system suspend,
so we should init mt65xx i2c controller again when system resume.

Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/i2c/busses/i2c-mt65xx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index c02e6c0..9b86716 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -728,11 +728,27 @@ static int mtk_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mtk_i2c_resume(struct device *dev)
+{
+	struct mtk_i2c *i2c = dev_get_drvdata(dev);
+
+	mtk_i2c_init_hw(i2c);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops mtk_i2c_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, mtk_i2c_resume)
+};
+
 static struct platform_driver mtk_i2c_driver = {
 	.probe = mtk_i2c_probe,
 	.remove = mtk_i2c_remove,
 	.driver = {
 		.name = I2C_DRV_NAME,
+		.pm = &mtk_i2c_pm,
 		.of_match_table = of_match_ptr(mtk_i2c_of_match),
 	},
 };
-- 
1.9.1
