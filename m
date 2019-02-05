From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 2/2] eeprom: at24: implement support for 'num-addresses' property
Date: Tue,  5 Feb 2019 14:59:34 +0100
Message-ID: <20190205135934.18841-3-brgl@bgdev.pl>
References: <20190205135934.18841-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205135934.18841-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

If the device node defines 'num-addresses', let it override the default
behavior.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/misc/eeprom/at24.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index b806a403ca46..63aa541c9608 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -641,11 +641,14 @@ static int at24_probe(struct i2c_client *client)
 	if (!is_power_of_2(page_size))
 		dev_warn(dev, "page_size looks suspicious (no power of 2)!\n");
 
-	if (flags & AT24_FLAG_TAKE8ADDR)
-		num_addresses = 8;
-	else
-		num_addresses =	DIV_ROUND_UP(byte_len,
-			(flags & AT24_FLAG_ADDR16) ? 65536 : 256);
+	err = device_property_read_u32(dev, "num-addresses", &num_addresses);
+	if (err) {
+		if (flags & AT24_FLAG_TAKE8ADDR)
+			num_addresses = 8;
+		else
+			num_addresses =	DIV_ROUND_UP(byte_len,
+				(flags & AT24_FLAG_ADDR16) ? 65536 : 256);
+	}
 
 	if ((flags & AT24_FLAG_SERIAL) && (flags & AT24_FLAG_MAC)) {
 		dev_err(dev,
-- 
2.20.1
