From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 2/2] eeprom: at24: drop unnecessary label
Date: Mon, 20 May 2019 09:10:42 +0200
Message-ID: <20190520071042.21072-3-brgl@bgdev.pl>
References: <20190520071042.21072-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190520071042.21072-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

If we move the nvmem registration above the pm enable calls and the
test read, we can drop the error label and make the code more readable
as there's now only a single place where we must call
pm_runtime_disable() in error path.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 43 ++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index bdeec0777029..ba8e73812644 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -685,23 +685,6 @@ static int at24_probe(struct i2c_client *client)
 			return err;
 	}
 
-	i2c_set_clientdata(client, at24);
-
-	/* enable runtime pm */
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
-	/*
-	 * Perform a one-byte test read to verify that the
-	 * chip is functional.
-	 */
-	err = at24_read(at24, 0, &test_byte, 1);
-	pm_runtime_idle(dev);
-	if (err) {
-		err = -ENODEV;
-		goto err_runtime_pm;
-	}
-
 	nvmem_config.name = dev_name(dev);
 	nvmem_config.dev = dev;
 	nvmem_config.read_only = !writable;
@@ -717,9 +700,24 @@ static int at24_probe(struct i2c_client *client)
 	nvmem_config.size = byte_len;
 
 	at24->nvmem = devm_nvmem_register(dev, &nvmem_config);
-	if (IS_ERR(at24->nvmem)) {
-		err = PTR_ERR(at24->nvmem);
-		goto err_runtime_pm;
+	if (IS_ERR(at24->nvmem))
+		return PTR_ERR(at24->nvmem);
+
+	i2c_set_clientdata(client, at24);
+
+	/* enable runtime pm */
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	/*
+	 * Perform a one-byte test read to verify that the
+	 * chip is functional.
+	 */
+	err = at24_read(at24, 0, &test_byte, 1);
+	pm_runtime_idle(dev);
+	if (err) {
+		pm_runtime_disable(dev);
+		return -ENODEV;
 	}
 
 	dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
@@ -727,11 +725,6 @@ static int at24_probe(struct i2c_client *client)
 		 writable ? "writable" : "read-only", at24->write_max);
 
 	return 0;
-
-err_runtime_pm:
-	pm_runtime_disable(dev);
-
-	return err;
 }
 
 static int at24_remove(struct i2c_client *client)
-- 
2.21.0
