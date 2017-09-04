From: Divagar Mohandass <divagar.mohandass@intel.com>
Subject: [PATCH v6 2/3] eeprom: at24: add support to fetch eeprom device property "size"
Date: Mon,  4 Sep 2017 15:58:47 +0530
Message-ID: <1504520928-5191-3-git-send-email-divagar.mohandass@intel.com>
References: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:48946 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753473AbdIDK2T (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 4 Sep 2017 06:28:19 -0400
In-Reply-To: <1504520928-5191-1-git-send-email-divagar.mohandass@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, sakari.ailus@iki.fi
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, Divagar Mohandass <divagar.mohandass@intel.com>

Obtain the size of the EEPROM chip from DT if the "size" property is
specified for the device.

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
