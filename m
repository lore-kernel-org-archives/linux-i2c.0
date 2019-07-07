From: Denis Efremov <efremov@linux.com>
Subject: [PATCH] i2c: core: make exported functions non-static
Date: Mon,  8 Jul 2019 00:04:19 +0300
Message-ID: <20190707210419.14868-1-efremov@linux.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Denis Efremov <efremov@linux.com>, Wolfram Sang <wsa@the-dreams.de>, Peter Rosin <peda@axentia.se>, Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The functions i2c_new_client_device and i2c_new_dummy_device are declared
static and marked EXPORT_SYMBOL_GPL(), which is at best an odd combination.
Because the functions were decided to be a part of API, this commit removes
the static attributes and adds the declarations to the header.

Fixes: 7159dbdae3c5 ("i2c: core: improve return value handling of i2c_new_device and i2c_new_dummy")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/i2c/i2c-core-base.c | 4 ++--
 include/linux/i2c.h         | 7 +++++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9e43508d4567..7792fa40fc32 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -721,7 +721,7 @@ static int i2c_dev_irq_from_resources(const struct resource *resources,
  * This returns the new i2c client, which may be saved for later use with
  * i2c_unregister_device(); or an ERR_PTR to describe the error.
  */
-static struct i2c_client *
+struct i2c_client *
 i2c_new_client_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 {
 	struct i2c_client	*client;
@@ -887,7 +887,7 @@ static struct i2c_driver dummy_driver = {
  * This returns the new i2c client, which should be saved for later use with
  * i2c_unregister_device(); or an ERR_PTR to describe the error.
  */
-static struct i2c_client *
+struct i2c_client *
 i2c_new_dummy_device(struct i2c_adapter *adapter, u16 address)
 {
 	struct i2c_board_info info = {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 1308126fc384..fa42f6f594ce 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -436,6 +436,10 @@ struct i2c_board_info {
 extern struct i2c_client *
 i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info);
 
+extern struct i2c_client *
+i2c_new_client_device(struct i2c_adapter *adap,
+			struct i2c_board_info const *info);
+
 /* If you don't know the exact address of an I2C device, use this variant
  * instead, which can probe for device presence in a list of possible
  * addresses. The "probe" callback function is optional. If it is provided,
@@ -457,6 +461,9 @@ extern int i2c_probe_func_quick_read(struct i2c_adapter *, unsigned short addr);
 extern struct i2c_client *
 i2c_new_dummy(struct i2c_adapter *adap, u16 address);
 
+extern struct i2c_client *
+i2c_new_dummy_device(struct i2c_adapter *adap, u16 address);
+
 extern struct i2c_client *
 devm_i2c_new_dummy_device(struct device *dev, struct i2c_adapter *adap, u16 address);
 
-- 
2.21.0
