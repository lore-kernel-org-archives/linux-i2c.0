From: Claudio Foellmi <claudio.foellmi@ergon.ch>
Subject: [PATCH] i2c: generic recovery: check SCL before SDA
Date: Thu,  5 Oct 2017 14:44:14 +0200
Message-ID: <1507207454-25158-1-git-send-email-claudio.foellmi@ergon.ch>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.ergon.ch ([87.239.214.68]:41713 "EHLO mx1.ergon.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751532AbdJEMpa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 5 Oct 2017 08:45:30 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Move the check for a stuck SCL before the check for a high SDA.
This prevent false positives in the specific case that SDA is fine
and SCL is stuck, which previously returned 0.

Also check SDA again after the loop, if we can.
Together, these changes should lead to a lot more failed
recoveries being caught and returning error codes.

Signed-off-by: Claudio Foellmi <claudio.foellmi@ergon.ch>
---
I'm not sure if the null check for get_sda really is necessary
(are there really any drivers that can access scl but not sda?),
but I kept it in just in case.

 drivers/i2c/i2c-core-base.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 56e4658..65a0415 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -205,9 +205,6 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
 	 */
 	while (i++ < RECOVERY_CLK_CNT * 2) {
 		if (val) {
-			/* Break if SDA is high */
-			if (bri->get_sda && bri->get_sda(adap))
-					break;
 			/* SCL shouldn't be low here */
 			if (!bri->get_scl(adap)) {
 				dev_err(&adap->dev,
@@ -215,6 +212,9 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
 				ret = -EBUSY;
 				break;
 			}
+			/* Break if SDA is high */
+			if (bri->get_sda && bri->get_sda(adap))
+				break;
 		}
 
 		val = !val;
@@ -222,6 +222,10 @@ static int i2c_generic_recovery(struct i2c_adapter *adap)
 		ndelay(RECOVERY_NDELAY);
 	}
 
+	/* check if recovery actually succeeded */
+	if (bri->get_sda && !bri->get_sda(adap))
+		ret = -EBUSY;
+
 	if (bri->unprepare_recovery)
 		bri->unprepare_recovery(adap);
 
-- 
2.7.4
