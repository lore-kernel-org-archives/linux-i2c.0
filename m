From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH V1] eeprom: at24: add TPF0001 ACPI ID for 24c1024 device
Date: Mon, 27 Jan 2020 11:35:41 +0100
Message-ID: <20200127103541.6975-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36285 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgA0Kfr (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Jan 2020 05:35:47 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Markus Pietrek <mpie@msc-ge.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

From: Markus Pietrek <mpie@msc-ge.com>

This ID is used at leas on some variants of MSC C6B-SLH board.

Signed-off-by: Markus Pietrek <mpie@msc-ge.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/misc/eeprom/at24.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2cccd82a3106..1c8e2ff96d9d 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -228,6 +228,7 @@ MODULE_DEVICE_TABLE(of, at24_of_match);
 
 static const struct acpi_device_id at24_acpi_ids[] = {
 	{ "INT3499",	(kernel_ulong_t)&at24_data_INT3499 },
+	{ "TPF0001",	(kernel_ulong_t)&at24_data_24c1024 },
 	{ /* END OF LIST */ }
 };
 MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
-- 
2.25.0
