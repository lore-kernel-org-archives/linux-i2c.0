From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v6 4/8] i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
Date: Tue,  2 May 2017 17:12:22 +0800
Message-ID: <1493716346-58517-5-git-send-email-preid@electromag.com.au>
References: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:34700 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751520AbdEBJMm (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 2 May 2017 05:12:42 -0400
In-Reply-To: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, peda@axentia.se, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, benjamin.tissoires@redhat.com

Add a call to of_i2c_setup_smbus_alert when a i2c adapter is registered
so the the smbalert driver can be registered.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/i2c-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index d2402bb..626471b 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -40,6 +40,7 @@
 #include <linux/gpio.h>
 #include <linux/hardirq.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/idr.h>
 #include <linux/init.h>
 #include <linux/irqflags.h>
@@ -2045,6 +2046,9 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 		dev_warn(&adap->dev,
 			 "Failed to create compatibility class link\n");
 #endif
+	res = of_i2c_setup_smbus_alert(adap);
+	if (res)
+		goto out_list;
 
 	i2c_init_recovery(adap);
 
-- 
1.8.3.1
