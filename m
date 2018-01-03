From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v2] i2c: Allow ACPI_I2C_OPREGION if I2C is built as a module
Date: Wed,  3 Jan 2018 15:02:31 +0100
Message-ID: <1514988151-12248-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751858AbeACOCm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 3 Jan 2018 09:02:42 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, okaya@codeaurora.org

If I2C is built as a module, ACPI_I2C_OPREGION cannot be set
and any ACPI opregion calls targeting I2C fail with no opregion found.

This patch allows ACPI_I2C_OPREGION to be enabled both if I2C is
built into the kernel or built as a module.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- reword the commit message
---
 drivers/i2c/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index efc3354..5951e9d 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -26,7 +26,7 @@ config I2C
 
 config ACPI_I2C_OPREGION
 	bool "ACPI I2C Operation region support"
-	depends on I2C=y && ACPI
+	depends on I2C && ACPI
 	default y
 	help
 	  Say Y here if you want to enable ACPI I2C operation region support.
-- 
2.5.5
