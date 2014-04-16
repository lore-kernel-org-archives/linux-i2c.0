From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 4/9] ACPI/Thermal: Use acpi_bus_attach_private_data() to attach private data
Date: Wed, 16 Apr 2014 21:24:37 +0800
Message-ID: <1397654682-7094-5-git-send-email-tianyu.lan@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, rjw@rjwysocki.net, lenb@kernel.org, mika.westerberg@linux.intel.com, awilliam@redhat.com, tianyu.lan@intel.com, rui.zhang@intel.com
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Use acpi_bus_attach_private_data() to attach private data
instead of acpi_attach_data().

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/thermal.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index c1e31a4..7ab9392 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -925,13 +925,10 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 	if (result)
 		return result;
 
-	status = acpi_attach_data(tz->device->handle,
-				  acpi_bus_private_data_handler,
-				  tz->thermal_zone);
-	if (ACPI_FAILURE(status)) {
-		pr_err(PREFIX "Error attaching device data\n");
+	status =  acpi_bus_attach_private_data(tz->device->handle,
+					       tz->thermal_zone);
+	if (ACPI_FAILURE(status))
 		return -ENODEV;
-	}
 
 	tz->tz_enabled = 1;
 
-- 
1.8.4.rc0.1.g8f6a3e5.dirty
