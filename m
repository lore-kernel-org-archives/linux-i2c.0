From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/7] i2c: cleanup i2c_register_adapter() by refactoring recovery init
Date: Sat,  9 Jul 2016 13:34:59 +0900
Message-ID: <1468038904-2571-3-git-send-email-wsa@the-dreams.de>
References: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37715 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbcGIEfa (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 9 Jul 2016 00:35:30 -0400
In-Reply-To: <1468038904-2571-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>

Move recovery init to a seperate function to let have
i2c_register_adapter() less lines and to avoid goto and a label.
Refactor string handling there for consistency and to save some bytes.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/i2c-core.c | 76 ++++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 34 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 7e6ff6d4cf659a..cc3e3bf986591c 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -666,6 +666,47 @@ int i2c_recover_bus(struct i2c_adapter *adap)
 }
 EXPORT_SYMBOL_GPL(i2c_recover_bus);
 
+static void i2c_init_recovery(struct i2c_adapter *adap)
+{
+	struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
+	char *err_str;
+
+	if (!bri)
+		return;
+
+	if (!bri->recover_bus) {
+		err_str = "no recover_bus() found";
+		goto err;
+	}
+
+	/* Generic GPIO recovery */
+	if (bri->recover_bus == i2c_generic_gpio_recovery) {
+		if (!gpio_is_valid(bri->scl_gpio)) {
+			err_str = "invalid SCL gpio";
+			goto err;
+		}
+
+		if (gpio_is_valid(bri->sda_gpio))
+			bri->get_sda = get_sda_gpio_value;
+		else
+			bri->get_sda = NULL;
+
+		bri->get_scl = get_scl_gpio_value;
+		bri->set_scl = set_scl_gpio_value;
+	} else if (bri->recover_bus == i2c_generic_scl_recovery) {
+		/* Generic SCL recovery */
+		if (!bri->set_scl || !bri->get_scl) {
+			err_str = "no {get|set}_scl() found";
+			goto err;
+		}
+	}
+
+	return;
+ err:
+	dev_err(&adap->dev, "Not using recovery: %s\n", err_str);
+	adap->bus_recovery_info = NULL;
+}
+
 static int i2c_device_probe(struct device *dev)
 {
 	struct i2c_client	*client = i2c_verify_client(dev);
@@ -1616,41 +1657,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 			 "Failed to create compatibility class link\n");
 #endif
 
-	/* bus recovery specific initialization */
-	if (adap->bus_recovery_info) {
-		struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
-
-		if (!bri->recover_bus) {
-			dev_err(&adap->dev, "No recover_bus() found, not using recovery\n");
-			adap->bus_recovery_info = NULL;
-			goto exit_recovery;
-		}
-
-		/* Generic GPIO recovery */
-		if (bri->recover_bus == i2c_generic_gpio_recovery) {
-			if (!gpio_is_valid(bri->scl_gpio)) {
-				dev_err(&adap->dev, "Invalid SCL gpio, not using recovery\n");
-				adap->bus_recovery_info = NULL;
-				goto exit_recovery;
-			}
-
-			if (gpio_is_valid(bri->sda_gpio))
-				bri->get_sda = get_sda_gpio_value;
-			else
-				bri->get_sda = NULL;
-
-			bri->get_scl = get_scl_gpio_value;
-			bri->set_scl = set_scl_gpio_value;
-		} else if (bri->recover_bus == i2c_generic_scl_recovery) {
-			/* Generic SCL recovery */
-			if (!bri->set_scl || !bri->get_scl) {
-				dev_err(&adap->dev, "No {get|set}_scl() found, not using recovery\n");
-				adap->bus_recovery_info = NULL;
-			}
-		}
-	}
+	i2c_init_recovery(adap);
 
-exit_recovery:
 	/* create pre-declared device nodes */
 	of_i2c_register_devices(adap);
 	acpi_i2c_register_devices(adap);
-- 
2.8.1
