From: Eric Auger <eric.auger@redhat.com>
Subject: [PATCH] i2c: fix ACPI_I2C_OPREGION dependency
Date: Wed, 22 Nov 2017 18:05:57 +0100
Message-ID: <1511370357-17184-1-git-send-email-eric.auger@redhat.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbdKVRGJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 22 Nov 2017 12:06:09 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, okaya@codeaurora.org

If CONFIG_I2C=m we fail getting ACPI_I2C_OPREGION set. Let's
make ACPI_I2C_OPREGION depend on I2C.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
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
