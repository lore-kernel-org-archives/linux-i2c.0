From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/2] i2c: mv64xxx: propagate the return value of platform_get_irq()
Date: Tue, 16 May 2017 14:07:25 +0200
Message-ID: <1494936445-27331-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1494936445-27331-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:44690 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752211AbdEPMHb (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 May 2017 08:07:31 -0400
In-Reply-To: <1494936445-27331-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

platform_get_irq() returns an error code, so instead of inventing our
own error code (-ENXIO), return the one provided by
platform_get_irq(). Most notably, this allows an -EPROBE_DEFER
returned by platform_get_irq() to be propagate as the return value of
->probe(), which allows deferred probing of the interrupt controller.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index f0a4d15..f0ddf7d 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -918,7 +918,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
 			goto exit_clk;
 	}
 	if (drv_data->irq < 0) {
-		rc = -ENXIO;
+		rc = drv_data->irq;
 		goto exit_reset;
 	}
 
-- 
2.7.4
