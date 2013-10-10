From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 1/3] ACPI / PM: allow child devices to ignore parent power state
Date: Thu, 10 Oct 2013 13:28:46 +0300
Message-ID: <1381400928-2689-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1381327461-10562-1-git-send-email-mika.westerberg@linux.intel.com>
 <1381400928-2689-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381400928-2689-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, Aaron Lu <aaron.lu@intel.com>, Lv Zheng <lv.zheng@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Some serial buses like I2C and SPI don't require that the parent device is
in D0 before any of its children transitions to D0, but instead the parent
device can control its own power independently from the children.

This does not follow the ACPI specification as it requires the parent to be
powered on before its children. However, Windows seems to ignore this
requirement so I think we can do the same in Linux.

Implement this by adding a new power flag 'ignore_parent' to struct
acpi_device.  If this flag is set the ACPI core ignores checking of the
parent device power state when the device is powered on/off.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/device_pm.c | 8 +++++---
 include/acpi/acpi_bus.h  | 3 ++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 59d3202..ca723a4 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -118,9 +118,10 @@ int acpi_device_get_power(struct acpi_device *device, int *state)
 	/*
 	 * If we were unsure about the device parent's power state up to this
 	 * point, the fact that the device is in D0 implies that the parent has
-	 * to be in D0 too.
+	 * to be in D0 too, except if ignore_parent is set.
 	 */
-	if (device->parent && device->parent->power.state == ACPI_STATE_UNKNOWN
+	if (!device->power.flags.ignore_parent && device->parent
+	    && device->parent->power.state == ACPI_STATE_UNKNOWN
 	    && result == ACPI_STATE_D0)
 		device->parent->power.state = ACPI_STATE_D0;
 
@@ -177,7 +178,8 @@ int acpi_device_set_power(struct acpi_device *device, int state)
 			 acpi_power_state_string(state));
 		return -ENODEV;
 	}
-	if (device->parent && (state < device->parent->power.state)) {
+	if (!device->power.flags.ignore_parent &&
+	    device->parent && (state < device->parent->power.state)) {
 		dev_warn(&device->dev,
 			 "Cannot transition to power state %s for parent in %s\n",
 			 acpi_power_state_string(state),
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 02e113b..e830ab0 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -222,7 +222,8 @@ struct acpi_device_power_flags {
 	u32 power_resources:1;	/* Power resources */
 	u32 inrush_current:1;	/* Serialize Dx->D0 */
 	u32 power_removed:1;	/* Optimize Dx->D0 */
-	u32 reserved:28;
+	u32 ignore_parent:1;	/* Power is independent of parent power state */
+	u32 reserved:27;
 };
 
 struct acpi_device_power_state {
-- 
1.8.4.rc3
