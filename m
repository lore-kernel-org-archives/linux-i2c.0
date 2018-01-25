From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH v3] ACPI: Force I2C to be selected as a built-in module
Date: Thu, 25 Jan 2018 10:43:31 -0500
Message-ID: <1516895011-17588-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, timur@codeaurora.org
Cc: eric.auger@redhat.com, hdegoede@redhat.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, rjw@rjwysocki.net, Sinan Kaya <okaya@codeaurora.org>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

From: Auger Eric <eric.auger@redhat.com>

If I2C is built as a module, ACPI_I2C_OPREGION cannot be set
and any ACPI opregion calls targeting I2C fail with no opregion found.

Commit da3c6647ee08 ("I2C/ACPI: Clean up I2C ACPI code and Add
CONFIG_I2C_ACPI config") says following:

"Current there is a race between removing I2C ACPI operation region
and ACPI AML code accessing."

This patch forces core I2C support to be compiled as a built-in
module if ACPI is selected as code is not ready for dynamic module
removal.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 4650539..5b48098 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -9,6 +9,8 @@ menuconfig ACPI
 	depends on IA64 || X86 || ARM64
 	depends on PCI
 	select PNP
+	# force building I2C in on ACPI systems, for opregion availability
+	imply I2C
 	default y if (IA64 || X86)
 	help
 	  Advanced Configuration and Power Interface (ACPI) support for 
-- 
1.9.1
