From: alanx.chiang@intel.com
Subject: [RESEND PATCH v4 2/2] eeprom: at24: Add support for address-width property
Date: Wed, 25 Jul 2018 11:20:22 +0800
Message-ID: <1532488822-5622-3-git-send-email-alanx.chiang@intel.com>
References: <1532488822-5622-1-git-send-email-alanx.chiang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532488822-5622-1-git-send-email-alanx.chiang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: andy.yeh@intel.com, sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com, andriy.shevchenko@intel.com, rajmohan.mani@intel.com, andy.shevchenko@gmail.com, tfiga@chromium.org, jcliang@chromium.org, brgl@bgdev.pl, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, rpjday@crashcourse.ca, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Alan Chiang <alanx.chiang@intel.com>
List-Id: linux-i2c@vger.kernel.org

From: Alan Chiang <alanx.chiang@intel.com>

Provide a flexible way to determine the addressing bits of eeprom.
Pass the addressing bits to driver through address-width property.

Signed-off-by: Alan Chiang <alanx.chiang@intel.com>
Signed-off-by: Andy Yeh <andy.yeh@intel.com>
---
 drivers/misc/eeprom/at24.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 0c125f2..7ea640b 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -478,6 +478,23 @@ static void at24_properties_to_pdata(struct device *dev,
 	if (device_property_present(dev, "no-read-rollover"))
 		chip->flags |= AT24_FLAG_NO_RDROL;
 
+	err = device_property_read_u32(dev, "address-width", &val);
+	if (!err) {
+		switch (val) {
+		case 8:
+			if (chip->flags & AT24_FLAG_ADDR16)
+				dev_warn(dev, "Override address width to be 8, while default is 16\n");
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
