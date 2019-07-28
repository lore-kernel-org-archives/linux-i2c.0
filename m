From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH v2 1/2] eeprom: at24: make spd world-readable again
Date: Sun, 28 Jul 2019 18:41:38 +0200
Message-ID: <20190728184138.78afc30f@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

The integration of the at24 driver into the nvmem framework broke the
world-readability of spd EEPROMs. Fix it.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 57d155506dd5 ("eeprom: at24: extend driver to plug into the NVMEM framework")
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>
---
Note: This is only the 1st half of the fix, the nvmem core driver
also needs to be fixed.

Changes since V1:
 * Split into 2 patches, one to the at24 driver and one to the nvmem
   core.

 drivers/misc/eeprom/at24.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-5.1.orig/drivers/misc/eeprom/at24.c	2019-07-28 16:52:06.550918923 +0200
+++ linux-5.1/drivers/misc/eeprom/at24.c	2019-07-28 16:53:28.104167083 +0200
@@ -719,7 +719,7 @@ static int at24_probe(struct i2c_client
 	nvmem_config.name = dev_name(dev);
 	nvmem_config.dev = dev;
 	nvmem_config.read_only = !writable;
-	nvmem_config.root_only = true;
+	nvmem_config.root_only = !(flags & AT24_FLAG_IRUGO);
 	nvmem_config.owner = THIS_MODULE;
 	nvmem_config.compat = true;
 	nvmem_config.base_dev = dev;


-- 
Jean Delvare
SUSE L3 Support
