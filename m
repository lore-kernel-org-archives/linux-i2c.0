From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [Patch V3 2/5] ACPI: Add acpi_bus_attach_private_data() to facilitate to attach data to ACPI handle
Date: Tue, 20 May 2014 20:59:21 +0800
Message-ID: <1400590764-11108-3-git-send-email-tianyu.lan@intel.com>
References: <1400590764-11108-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400590764-11108-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, rjw@rjwysocki.net, mika.westerberg@linux.intel.com, awilliam@redhat.com, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

There is already acpi_bus_get_private_data() to get ACPI handle data
which is associated with acpi_bus_private_data_handler(). This patch
is to add acpi_bus_attach_private_data() to make a pair and facilitate
to attach and get data to/from ACPI handle.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/bus.c      | 28 ++++++++++++++++++++++++----
 include/acpi/acpi_bus.h |  2 ++
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index cf925c4..8445d57 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -132,6 +132,21 @@ void acpi_bus_private_data_handler(acpi_handle handle,
 }
 EXPORT_SYMBOL(acpi_bus_private_data_handler);
 
+int acpi_bus_attach_private_data(acpi_handle handle, void *data)
+{
+	acpi_status status;
+
+	status = acpi_attach_data(handle,
+			acpi_bus_private_data_handler, data);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(handle, "Error attaching device data\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_bus_attach_private_data);
+
 int acpi_bus_get_private_data(acpi_handle handle, void **data)
 {
 	acpi_status status;
@@ -140,15 +155,20 @@ int acpi_bus_get_private_data(acpi_handle handle, void **data)
 		return -EINVAL;
 
 	status = acpi_get_data(handle, acpi_bus_private_data_handler, data);
-	if (ACPI_FAILURE(status) || !*data) {
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No context for object [%p]\n",
-				handle));
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(handle, "No context for object\n");
 		return -ENODEV;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL(acpi_bus_get_private_data);
+EXPORT_SYMBOL_GPL(acpi_bus_get_private_data);
+
+void acpi_bus_detach_private_data(acpi_handle handle)
+{
+	acpi_detach_data(handle, acpi_bus_private_data_handler);
+}
+EXPORT_SYMBOL_GPL(acpi_bus_detach_private_data);
 
 void acpi_bus_no_hotplug(acpi_handle handle)
 {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 84a2e29..d2006ca 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -406,6 +406,8 @@ extern struct kobject *acpi_kobj;
 extern int acpi_bus_generate_netlink_event(const char*, const char*, u8, int);
 void acpi_bus_private_data_handler(acpi_handle, void *);
 int acpi_bus_get_private_data(acpi_handle, void **);
+int acpi_bus_attach_private_data(acpi_handle, void *);
+void acpi_bus_detach_private_data(acpi_handle);
 void acpi_bus_no_hotplug(acpi_handle handle);
 extern int acpi_notifier_call_chain(struct acpi_device *, u32, u32);
 extern int register_acpi_notifier(struct notifier_block *);
-- 
1.8.3.1
