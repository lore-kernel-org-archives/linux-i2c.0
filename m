From: Axel Lin <axel.lin@ingics.com>
Subject: [RFT][PATCH 1/2] i2c: sirf: Prevent potential division by zero
Date: Wed, 13 Apr 2016 08:49:30 +0800
Message-ID: <1460508570.6009.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33200 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755763AbcDMAtg (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 12 Apr 2016 20:49:36 -0400
Received: by mail-pa0-f68.google.com with SMTP id vv3so2473287pab.0
        for <linux-i2c@vger.kernel.org>; Tue, 12 Apr 2016 17:49:35 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Barry Song <baohua@kernel.org>, Guoying Zhang <Guoying.Zhang@csr.com>, linux-i2c@vger.kernel.org

Make sure we don't OOPS in case clock-frequency is set to 0 in a DT. The
variable set here is later used as a divisor. Since the clock-frequency
property is optional in current code, use SIRFSOC_I2C_DEFAULT_SPEED
instead if clock-frequency is set to 0 in a DT.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/i2c/busses/i2c-sirf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 792a42b..82743e4 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -353,7 +353,7 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 
 	err = of_property_read_u32(pdev->dev.of_node,
 		"clock-frequency", &bitrate);
-	if (err < 0)
+	if (err < 0 || bitrate == 0)
 		bitrate = SIRFSOC_I2C_DEFAULT_SPEED;
 
 	/*
-- 
2.5.0
