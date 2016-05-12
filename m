From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: only check scl functions when using generic recovery
Date: Thu, 12 May 2016 11:25:19 +0200
Message-ID: <1463045119-7375-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44919 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbcELJZ2 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 12 May 2016 05:25:28 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Peter Griffin <peter.griffin@linaro.org>

A custom recovery function doesn't need these pointers to be populated
because it may work differently internally.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Tested-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/i2c/i2c-core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 9da44616252995..af11b658984d76 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1594,10 +1594,12 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 
 			bri->get_scl = get_scl_gpio_value;
 			bri->set_scl = set_scl_gpio_value;
-		} else if (!bri->set_scl || !bri->get_scl) {
+		} else if (bri->recover_bus == i2c_generic_scl_recovery) {
 			/* Generic SCL recovery */
-			dev_err(&adap->dev, "No {get|set}_gpio() found, not using recovery\n");
-			adap->bus_recovery_info = NULL;
+			if (!bri->set_scl || !bri->get_scl) {
+				dev_err(&adap->dev, "No {get|set}_scl() found, not using recovery\n");
+				adap->bus_recovery_info = NULL;
+			}
 		}
 	}
 
-- 
2.8.1
