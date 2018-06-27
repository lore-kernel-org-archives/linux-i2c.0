From: alanx.chiang@intel.com
Subject: [PATCH v3 2/2] eeprom: at24: Add support for address-width property
Date: Wed, 27 Jun 2018 13:46:25 +0800
Message-ID: <1530078385-1546-3-git-send-email-alanx.chiang@intel.com>
References: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530078385-1546-1-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: andy.yeh@intel.com, sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Alan Chiang <alanx.chiang@intel.com>
List-Id: linux-i2c@vger.kernel.org

From: Alan Chiang <alanx.chiang@intel.com>

Provide a flexible way to determine the addressing bits of eeprom.
Pass the addressing bits to driver through address-width property.

Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
Signed-off-by: Andy Yeh <andy.yeh@intel.com>

---
since v1
-- Add a warn message for 8-bit addressing.
since v2
-- Modify the warning message for clear.
-- Move the clearing bit operation outside of a statement.

---
 drivers/misc/eeprom/at24.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0c125f2..d606f3b 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -478,6 +478,24 @@ static void at24_properties_to_pdata(struct device *dev,
 	if (device_property_present(dev, "no-read-rollover"))
 		chip->flags |= AT24_FLAG_NO_RDROL;
 
+	err = device_property_read_u32(dev, "address-width", &val);
+	if (!err) {
+		switch (val) {
+		case 8:
+			if (chip->flags & AT24_FLAG_ADDR16)
+				dev_warn(dev, "Override address width to be 8,"
+					 "while default is 16\n");
+			chip->flags &= ~AT24_FLAG_ADDR16;
+			break;
+		case 16:
+			chip->flags |= AT24_FLAG_ADDR16;
+			break;
+		default:
+			dev_warn(dev, "Bad \"address-width\" property: %u\n",
+				 val);
+		}
+	}
+
 	err = device_property_read_u32(dev, "size", &val);
 	if (!err)
 		chip->byte_len = val;
-- 
2.7.4
