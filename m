From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5/7] i2c: print more info when of_i2c_notify fails
Date: Sat,  9 Jul 2016 13:35:02 +0900
Message-ID: <1468038904-2571-6-git-send-email-wsa@the-dreams.de>
References: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37718 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbcGIEfo (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 9 Jul 2016 00:35:44 -0400
In-Reply-To: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>

Use dev_err instead of pr_err for more details.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/i2c/i2c-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index a94e7ccb9c3067..57fe66cc855163 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2109,8 +2109,8 @@ static int of_i2c_notify(struct notifier_block *nb, unsigned long action,
 		put_device(&adap->dev);
 
 		if (IS_ERR(client)) {
-			pr_err("%s: failed to create for '%s'\n",
-					__func__, rd->dn->full_name);
+			dev_err(&adap->dev, "failed to create client for '%s'\n",
+				 rd->dn->full_name);
 			return notifier_from_errno(PTR_ERR(client));
 		}
 		break;
-- 
2.8.1
