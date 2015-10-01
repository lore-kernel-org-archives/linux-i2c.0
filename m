From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/8] mfd: core: redo ACPI matching of the children devices
Date: Thu,  1 Oct 2015 14:20:24 +0300
Message-ID: <1443698430-74415-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1443698430-74415-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

There is at least one board on the market, i.e. Intel Galileo Gen2, that uses
_ADR to distinguish the devices under one actual device. Due to this we have to
improve the quirk in the MFD core to handle that board.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/acpi/enumeration.txt | 11 +++++---
 drivers/mfd/mfd-core.c             | 52 ++++++++++++++++++++++++++------------
 include/linux/mfd/core.h           | 10 ++++++--
 3 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/Documentation/acpi/enumeration.txt b/Documentation/acpi/enumeration.txt
index b731b29..a91ec5a 100644
--- a/Documentation/acpi/enumeration.txt
+++ b/Documentation/acpi/enumeration.txt
@@ -347,13 +347,18 @@ For the first case, the MFD drivers do not need to do anything. The
 resulting child platform device will have its ACPI_COMPANION() set to point
 to the parent device.
 
-If the ACPI namespace has a device that we can match using an ACPI id,
-the id should be set like:
+If the ACPI namespace has a device that we can match using an ACPI id or ACPI
+adr, the cell should be set like:
+
+	static struct mfd_cell_acpi_match my_subdevice_cell_acpi_match = {
+		.pnpid = "XYZ0001",
+		.adr = 0,
+	};
 
 	static struct mfd_cell my_subdevice_cell = {
 		.name = "my_subdevice",
 		/* set the resources relative to the parent */
-		.acpi_pnpid = "XYZ0001",
+		.acpi_match = &my_subdevice_cell_acpi_match,
 	};
 
 The ACPI id "XYZ0001" is then used to lookup an ACPI device directly under
diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index c17635d..60b60dc 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -82,29 +82,49 @@ static int mfd_platform_add_cell(struct platform_device *pdev,
 static void mfd_acpi_add_device(const struct mfd_cell *cell,
 				struct platform_device *pdev)
 {
-	struct acpi_device *parent_adev;
+	const struct mfd_cell_acpi_match *match = cell->acpi_match;
+	struct acpi_device *parent, *child;
 	struct acpi_device *adev;
 
-	parent_adev = ACPI_COMPANION(pdev->dev.parent);
-	if (!parent_adev)
+	parent = ACPI_COMPANION(pdev->dev.parent);
+	if (!parent)
 		return;
 
 	/*
-	 * MFD child device gets its ACPI handle either from the ACPI
-	 * device directly under the parent that matches the acpi_pnpid or
-	 * it will use the parent handle if is no acpi_pnpid is given.
+	 * MFD child device gets its ACPI handle either from the ACPI device
+	 * directly under the parent that matches the either _HID or _CID, or
+	 * _ADR or it will use the parent handle if is no ID is given.
+	 *
+	 * Note that use of _ADR is a grey area in the ACPI specification,
+	 * though Intel Galileo Gen2 is using it to distinguish the children
+	 * devices.
 	 */
-	adev = parent_adev;
-	if (cell->acpi_pnpid) {
-		struct acpi_device_id ids[2] = {};
-		struct acpi_device *child_adev;
-
-		strlcpy(ids[0].id, cell->acpi_pnpid, sizeof(ids[0].id));
-		list_for_each_entry(child_adev, &parent_adev->children, node)
-			if (acpi_match_device_ids(child_adev, ids)) {
-				adev = child_adev;
-				break;
+	adev = parent;
+	if (match) {
+		if (match->pnpid) {
+			struct acpi_device_id ids[2] = {};
+
+			strlcpy(ids[0].id, match->pnpid, sizeof(ids[0].id));
+			list_for_each_entry(child, &parent->children, node) {
+				if (acpi_match_device_ids(child, ids)) {
+					adev = child;
+					break;
+				}
+			}
+		} else {
+			unsigned long long adr;
+			acpi_status status;
+
+			list_for_each_entry(child, &parent->children, node) {
+				status = acpi_evaluate_integer(child->handle,
+							       "_ADR", NULL,
+							       &adr);
+				if (ACPI_SUCCESS(status) && match->adr == adr) {
+					adev = child;
+					break;
+				}
 			}
+		}
 	}
 
 	ACPI_COMPANION_SET(&pdev->dev, adev);
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index a76bc10..27dac3f 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -18,6 +18,12 @@
 
 struct irq_domain;
 
+/* Matches ACPI PNP id, either _HID or _CID, or ACPI _ADR */
+struct mfd_cell_acpi_match {
+	const char			*pnpid;
+	const unsigned long long	adr;
+};
+
 /*
  * This struct describes the MFD part ("cell").
  * After registration the copy of this structure will become the platform data
@@ -44,8 +50,8 @@ struct mfd_cell {
 	 */
 	const char		*of_compatible;
 
-	/* Matches ACPI PNP id, either _HID or _CID */
-	const char		*acpi_pnpid;
+	/* Matches ACPI */
+	const struct mfd_cell_acpi_match	*acpi_match;
 
 	/*
 	 * These resources can be specified relative to the parent device.
-- 
2.5.1

