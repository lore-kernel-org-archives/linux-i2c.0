From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] acpi: Support IBM SMBus CMI devices
Date: Tue, 9 Mar 2010 10:40:17 +0100
Message-ID: <20100309104017.021cf584@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Linux I2C <linux-i2c@vger.kernel.org>, "Darrick J. Wong" <djwong@us.ibm.com>
List-Id: linux-i2c@vger.kernel.org

From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: acpi: Support IBM SMBus CMI devices

On some old IBM workstations and desktop computers, the BIOS presents in the
DSDT an SMBus object that is missing the HID identifier that the i2c-scmi
driver looks for.  Modify the ACPI device scan code to insert the missing HID
if it finds an IBM system with such an object.

Affected machines: IntelliStation Z20/Z30.  Note that the i2c-i801 driver no
longer works on these machines because of ACPI resource conflicts.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
v2 contains minor tweaks suggested by Jean Delvare.

Len, I want this in kernel 2.6.34. It has been waiting for too long
already, considering that it fixes a regression. SMBus stopped working
on these machines in kernel 2.6.32. Driver i2c-scmi was supposed to
take over the native i2c-i801 driver, but the non-standard IBM
implementation came in the way, and this is why this patch is needed.

So, please understand that, if this patch is not in 2.6.34-rc2, I will
have to push it myself together with the i2c-scmi side of the fix. If
you want some adjustments to be made, please speak up now.

 drivers/acpi/scan.c         |   38 ++++++++++++++++++++++++++++++++++++++
 include/acpi/acpi_drivers.h |    2 ++
 2 files changed, 40 insertions(+)


--- linux-2.6.34-rc1.orig/drivers/acpi/scan.c	2010-03-09 08:24:53.000000000 +0100
+++ linux-2.6.34-rc1/drivers/acpi/scan.c	2010-03-09 09:50:12.000000000 +0100
@@ -8,6 +8,7 @@
 #include <linux/acpi.h>
 #include <linux/signal.h>
 #include <linux/kthread.h>
+#include <linux/dmi.h>
 
 #include <acpi/acpi_drivers.h>
 
@@ -1032,6 +1033,41 @@ static void acpi_add_id(struct acpi_devi
 	list_add_tail(&id->list, &device->pnp.ids);
 }
 
+/*
+ * Old IBM workstations have a DSDT bug wherein the SMBus object
+ * lacks the SMBUS01 HID and the methods do not have the necessary "_"
+ * prefix.  Work around this.
+ */
+static int acpi_ibm_smbus_match(struct acpi_device *device)
+{
+	acpi_handle h_dummy;
+	struct acpi_buffer path = {ACPI_ALLOCATE_BUFFER, NULL};
+	int result;
+
+	if (!dmi_name_in_vendors("IBM"))
+		return -ENODEV;
+
+	/* Look for SMBS object */
+	result = acpi_get_name(device->handle, ACPI_SINGLE_NAME, &path);
+	if (result)
+		return result;
+
+	if (strcmp("SMBS", path.pointer)) {
+		result = -ENODEV;
+		goto out;
+	}
+
+	/* Does it have the necessary (but misnamed) methods? */
+	result = -ENODEV;
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "SBI", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "SBR", &h_dummy)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "SBW", &h_dummy)))
+		result = 0;
+out:
+	kfree(path.pointer);
+	return result;
+}
+
 static void acpi_device_set_id(struct acpi_device *device)
 {
 	acpi_status status;
@@ -1082,6 +1118,8 @@ static void acpi_device_set_id(struct ac
 			acpi_add_id(device, ACPI_BAY_HID);
 		else if (ACPI_SUCCESS(acpi_dock_match(device)))
 			acpi_add_id(device, ACPI_DOCK_HID);
+		else if (!acpi_ibm_smbus_match(device))
+			acpi_add_id(device, ACPI_SMBUS_IBM_HID);
 
 		break;
 	case ACPI_BUS_TYPE_POWER:
--- linux-2.6.34-rc1.orig/include/acpi/acpi_drivers.h	2010-03-09 08:25:29.000000000 +0100
+++ linux-2.6.34-rc1/include/acpi/acpi_drivers.h	2010-03-09 09:50:12.000000000 +0100
@@ -65,6 +65,8 @@
 #define ACPI_VIDEO_HID			"LNXVIDEO"
 #define ACPI_BAY_HID			"LNXIOBAY"
 #define ACPI_DOCK_HID			"LNXDOCK"
+/* Quirk for broken IBM BIOSes */
+#define ACPI_SMBUS_IBM_HID		"SMBUSIBM"
 
 /*
  * For fixed hardware buttons, we fabricate acpi_devices with HID


-- 
Jean Delvare
