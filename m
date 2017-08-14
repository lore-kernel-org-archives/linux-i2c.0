From: Divagar Mohandass <divagar.mohandass@intel.com>
Subject: [PATCH v2 2/3] eeprom: at24: add support to fetch eeprom device property "size"
Date: Tue, 15 Aug 2017 00:11:58 +0530
Message-ID: <1502736119-32084-3-git-send-email-divagar.mohandass@intel.com>
References: <1502736119-32084-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502736119-32084-1-git-send-email-divagar.mohandass@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, Divagar Mohandass <divagar.mohandass@intel.com>
List-Id: linux-i2c@vger.kernel.org

This adds support to fetch device property "size" from _DSD.

There is a CAT24C16/GT24C16S NVMEM chip part of the OV13858
camera module and it is connected to i2c bus on Intel KBL board.
This device will use the existing ACPI ID INT3499 and platform
fw will expose "read-only", "pagesize" and "size" props via _DSD.

Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
---
 drivers/misc/eeprom/at24.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 764ff5df..2199c42 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -570,6 +570,10 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
 	if (device_property_present(dev, "read-only"))
 		chip->flags |= AT24_FLAG_READONLY;
 
+	err = device_property_read_u32(dev, "size", &val);
+	if (!err)
+		chip->byte_len = val;
+
 	err = device_property_read_u32(dev, "pagesize", &val);
 	if (!err) {
 		chip->page_size = val;
-- 
1.9.1
