From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 02/14] eeprom: at24: move at24_read() below at24_eeprom_write()
Date: Sun, 29 May 2016 23:53:40 +0200
Message-ID: <1464558832-2262-3-git-send-email-bgolaszewski@baylibre.com>
References: <1464558832-2262-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464558832-2262-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, GregKH <greg@kroah.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

In preparation for splitting at24_eeprom_write() & at24_eeprom_read()
into smaller, specialized routines move at24_read() below, so that it
won't be intertwined with the low-level EEPROM accessors.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 64 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 411600d..e12d76f 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -249,38 +249,6 @@ static ssize_t at24_eeprom_read(struct at24_data *at24, char *buf,
 	return -ETIMEDOUT;
 }
 
-static int at24_read(void *priv, unsigned int off, void *val, size_t count)
-{
-	struct at24_data *at24 = priv;
-	char *buf = val;
-
-	if (unlikely(!count))
-		return count;
-
-	/*
-	 * Read data from chip, protecting against concurrent updates
-	 * from this host, but not from other I2C masters.
-	 */
-	mutex_lock(&at24->lock);
-
-	while (count) {
-		int	status;
-
-		status = at24_eeprom_read(at24, buf, off, count);
-		if (status < 0) {
-			mutex_unlock(&at24->lock);
-			return status;
-		}
-		buf += status;
-		off += status;
-		count -= status;
-	}
-
-	mutex_unlock(&at24->lock);
-
-	return 0;
-}
-
 /*
  * Note that if the hardware write-protect pin is pulled high, the whole
  * chip is normally write protected. But there are plenty of product
@@ -366,6 +334,38 @@ static ssize_t at24_eeprom_write(struct at24_data *at24, const char *buf,
 	return -ETIMEDOUT;
 }
 
+static int at24_read(void *priv, unsigned int off, void *val, size_t count)
+{
+	struct at24_data *at24 = priv;
+	char *buf = val;
+
+	if (unlikely(!count))
+		return count;
+
+	/*
+	 * Read data from chip, protecting against concurrent updates
+	 * from this host, but not from other I2C masters.
+	 */
+	mutex_lock(&at24->lock);
+
+	while (count) {
+		int	status;
+
+		status = at24_eeprom_read(at24, buf, off, count);
+		if (status < 0) {
+			mutex_unlock(&at24->lock);
+			return status;
+		}
+		buf += status;
+		off += status;
+		count -= status;
+	}
+
+	mutex_unlock(&at24->lock);
+
+	return 0;
+}
+
 static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
-- 
2.7.4
