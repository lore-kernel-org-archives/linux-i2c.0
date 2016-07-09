From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/7] i2c: improve error messages in i2c_register_adapter()
Date: Sat,  9 Jul 2016 13:35:00 +0900
Message-ID: <1468038904-2571-4-git-send-email-wsa@the-dreams.de>
References: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37716 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbcGIEff (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 9 Jul 2016 00:35:35 -0400
In-Reply-To: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

Switch to WARN if no adapter name is given, otherwise we won't know who
missed to do that. Add error message if device registration fails.
Update error message for missing algo to match style of the others.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index cc3e3bf986591c..36183eacec105b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1610,14 +1610,11 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	}
 
 	/* Sanity checks */
-	if (unlikely(adap->name[0] == '\0')) {
-		pr_err("i2c-core: Attempt to register an adapter with "
-		       "no name!\n");
+	if (WARN(!adap->name[0], "i2c adapter has no name"))
 		goto out_list;
-	}
-	if (unlikely(!adap->algo)) {
-		pr_err("i2c-core: Attempt to register adapter '%s' with "
-		       "no algo!\n", adap->name);
+
+	if (!adap->algo) {
+		pr_err("i2c-core: adapter '%s': no algo supplied!\n", adap->name);
 		goto out_list;
 	}
 
@@ -1640,8 +1637,11 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.bus = &i2c_bus_type;
 	adap->dev.type = &i2c_adapter_type;
 	res = device_register(&adap->dev);
-	if (res)
+	if (res) {
+		pr_err("i2c-core: adapter '%s': can't register device (%d)\n",
+			adap->name, res);
 		goto out_list;
+	}
 
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
-- 
2.8.1
