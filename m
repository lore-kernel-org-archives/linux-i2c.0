From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] i2c: core: fix wakeup irq parsing
Date: Thu, 12 Nov 2015 15:42:26 +0200
Message-ID: <1447335746-11114-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57931 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbKLNme (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 12 Nov 2015 08:42:34 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>, "# v4 . 3" <stable@vger.kernel.org>

This patch fixes obvious copy-past error in wake up irq parsing
code which leads to the fact that dev_pm_set_wake_irq() will
be called with wrong IRQ number when "wakeup" IRQ is not
defined in DT.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: <stable@vger.kernel.org> # v4.3
Fixes: 3fffd1283927 ("i2c: allow specifying separate wakeup interrupt in device tree")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/i2c/i2c-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 040af5c..ba8eb08 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -715,7 +715,7 @@ static int i2c_device_probe(struct device *dev)
 		if (wakeirq > 0 && wakeirq != client->irq)
 			status = dev_pm_set_dedicated_wake_irq(dev, wakeirq);
 		else if (client->irq > 0)
-			status = dev_pm_set_wake_irq(dev, wakeirq);
+			status = dev_pm_set_wake_irq(dev, client->irq);
 		else
 			status = 0;
 
-- 
2.6.3
