From: Michael Auchter <michael.auchter@ni.com>
Subject: [PATCH] misc: eeprom: at24: fix regulator underflow
Date: Tue, 10 Mar 2020 15:58:40 -0500
Message-ID: <20200310205841.123084-1-michael.auchter@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Michael Auchter <michael.auchter@ni.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The at24 driver attempts to read a byte from the device to validate that
it's actually present, and if not, disables the vcc regulator and
returns -ENODEV. However, between the read and the error handling path,
pm_runtime_idle() is called and invokes the driver's suspend callback,
which also disables the vcc regulator. This leads to an underflow of the
regulator enable count if the EEPROM is not present.

Move the pm_runtime_suspend() call to be after the error handling path
to resolve this.

Signed-off-by: Michael Auchter <michael.auchter@ni.com>
---
 drivers/misc/eeprom/at24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 031eb64549af..282c9ef68ed2 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -712,13 +712,14 @@ static int at24_probe(struct i2c_client *client)
 	 * chip is functional.
 	 */
 	err = at24_read(at24, 0, &test_byte, 1);
-	pm_runtime_idle(dev);
 	if (err) {
 		pm_runtime_disable(dev);
 		regulator_disable(at24->vcc_reg);
 		return -ENODEV;
 	}
 
+	pm_runtime_idle(dev);
+
 	if (writable)
 		dev_info(dev, "%u byte %s EEPROM, writable, %u bytes/write\n",
 			 byte_len, client->name, at24->write_max);
-- 
2.24.1
