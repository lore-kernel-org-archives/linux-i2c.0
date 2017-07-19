From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 028/102] i2c: stm32f4: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:32 +0200
Message-ID: <20170719152646.25903-29-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58125 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932603AbdGSP23 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 19 Jul 2017 11:28:29 -0400
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Wolfram Sang <wsa@the-dreams.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/i2c/busses/i2c-stm32f4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stm32f4.c b/drivers/i2c/busses/i2c-stm32f4.c
index f9dd7e86b861a..4da3ce0865ebd 100644
--- a/drivers/i2c/busses/i2c-stm32f4.c
+++ b/drivers/i2c/busses/i2c-stm32f4.c
@@ -798,7 +798,7 @@ static int stm32f4_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	rst = devm_reset_control_get(&pdev->dev, NULL);
+	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rst)) {
 		dev_err(&pdev->dev, "Error: Missing controller reset\n");
 		ret = PTR_ERR(rst);
-- 
2.11.0
