From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 4/4] i2c: uniphier_f: error out if bus speed is zero
Date: Mon, 30 Nov 2015 18:53:36 +0900
Message-ID: <1448877216-32286-5-git-send-email-yamada.masahiro@socionext.com>
References: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from conuserg011.nifty.com ([202.248.44.37]:31259 "EHLO
	conuserg011-v.nifty.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751816AbbK3Jxn (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 30 Nov 2015 04:53:43 -0500
In-Reply-To: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

There is code to divide by "bus_speed" some lines below.
To eliminate the possibility of division by zero, bail out if
"clock-frequency" is specified as zero.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 67109e1..f3e5ff8 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -466,6 +466,11 @@ static int uniphier_fi2c_clk_init(struct device *dev,
 	if (of_property_read_u32(np, "clock-frequency", &bus_speed))
 		bus_speed = UNIPHIER_FI2C_DEFAULT_SPEED;
 
+	if (!bus_speed) {
+		dev_err(dev, "clock-freqyency should not be zero\n");
+		return -EINVAL;
+	}
+
 	if (bus_speed > UNIPHIER_FI2C_MAX_SPEED)
 		bus_speed = UNIPHIER_FI2C_MAX_SPEED;
 
-- 
1.9.1
