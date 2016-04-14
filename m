From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] i2c: efm32: Prevent potential division by zero
Date: Thu, 14 Apr 2016 15:42:54 +0800
Message-ID: <1460619774.4294.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34325 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbcDNHm7 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 14 Apr 2016 03:42:59 -0400
Received: by mail-pf0-f194.google.com with SMTP id d184so6384859pfc.1
        for <linux-i2c@vger.kernel.org>; Thu, 14 Apr 2016 00:42:59 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <kernel@pengutronix.de>, linux-i2c@vger.kernel.org

Make sure we don't OOPS in case clock-frequency is set to 0 in a DT. The
variable set here is later used as a divisor.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/i2c/busses/i2c-efm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
index 8eff627..394c695 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -389,7 +389,7 @@ static int efm32_i2c_probe(struct platform_device *pdev)
 	ddata->location = location;
 
 	ret = of_property_read_u32(np, "clock-frequency", &frequency);
-	if (!ret) {
+	if (!ret && frequency != 0) {
 		dev_dbg(&pdev->dev, "using frequency %u\n", frequency);
 	} else {
 		frequency = 100000;
-- 
2.5.0
