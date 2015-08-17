From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFC v2 0/1] i2c: acpi: scan ACPI enumerated I2C mux channels
Date: Mon, 17 Aug 2015 15:03:05 +0300
Message-ID: <20150817120305.GB1552@lahna.fi.intel.com>
References: <1439510358-16664-1-git-send-email-dustin@cumulusnetworks.com>
 <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1439580693-5538-1-git-send-email-dustin@cumulusnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dustin Byford <dustin@cumulusnetworks.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 14, 2015 at 12:31:32PM -0700, Dustin Byford wrote:
> 
> (v2 corrects cc: list)
> 
> I would like to add support for scanning I2C devices connected to ACPI
> OF compatible muxes described in ASL like this:
> 
> Device (MUX0)
> {
>     Name (_ADR, 0x70)
>     Name (_HID, "PRP0001")
>     Name (_CRS, ResourceTemplate()
>     {
>         I2cSerialBus (0x70, ControllerInitiated, I2C_SPEED,
>                       AddressingMode7Bit, "^^SMB2", 0x00,
>                       ResourceConsumer,,)
>     })
>     Name (_DSD, Package ()
>     {
>         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>             Package (2) { "compatible", "nxp,pca9548" },
>         }

Nice, you are using _DSD :-)

>     })
> 
>     // MUX channels
>     Device (CH00) { Name (_ADR, 0x0) }
> }
> 
> Scope(MUX0.CH00)
> {
>     Device (TMP0) {
>         /* Temp sensor ASL, for example. */
>     }
> }
> 
> It seems like a reasonable way to describe a common I2C component and
> kernel support is almost there.
> 
> I had to:
> 
> 1) Find and set an ACPI companion for the "virtual" I2C adapters created
>    for each mux channel.
> 
> 2) Make sure to scan adap.dev when registering devices under each mux
>    channel.
> 
> At first, I was confused about why adap.dev->parent is used in
> acpi_i2c_register_devices().  I found b34bb1ee from 4/2013 (ACPI / I2C:
> Use parent's ACPI_HANDLE()), which offers an explanation.
> 
> This patch works well, but I'm not sure about the code to just fall back
> to using adap.dev when adap.dev->parent doesn't have an ACPI companion.
> Is there a more explicit check I can make to determine if the adapter
> represents a mux channel?

I think the current code in I2C core is not actually doing the right
thing according the ACPI spec at least. To my understanding you can have
device with I2cSerialBus resource _anywhere_ in the namespace, not just
directly below the host controller. It's the ResourceSource attribute
that tells the corresponding host controller.

I wonder if it helps if we scan the whole namespace for devices with
I2cSerialBus that matches the just registered adapter? Something like
the patch below.

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c83e4d13cfc5..2a309d27421a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -94,27 +94,40 @@ struct gsb_buffer {
 	};
 } __packed;
 
-static int acpi_i2c_add_resource(struct acpi_resource *ares, void *data)
+struct acpi_i2c_lookup {
+	struct i2c_board_info *info;
+	acpi_handle adapter_handle;
+	acpi_handle device_handle;
+};
+
+static int acpi_i2c_find_address(struct acpi_resource *ares, void *data)
 {
-	struct i2c_board_info *info = data;
+	struct acpi_i2c_lookup *lookup = data;
+	struct i2c_board_info *info = lookup->info;
+	struct acpi_resource_i2c_serialbus *sb;
+	acpi_handle adapter_handle;
+	acpi_status status;
 
-	if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS) {
-		struct acpi_resource_i2c_serialbus *sb;
+	if (info->addr || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return 1;
 
-		sb = &ares->data.i2c_serial_bus;
-		if (!info->addr && sb->type == ACPI_RESOURCE_SERIAL_TYPE_I2C) {
-			info->addr = sb->slave_address;
-			if (sb->access_mode == ACPI_I2C_10BIT_MODE)
-				info->flags |= I2C_CLIENT_TEN;
-		}
-	} else if (!info->irq) {
-		struct resource r;
+	sb = &ares->data.i2c_serial_bus;
+	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
+		return 1;
 
-		if (acpi_dev_resource_interrupt(ares, 0, &r))
-			info->irq = r.start;
+	/*
+	 * Extract the ResourceSource and make sure that the handle matches
+	 * with the I2C adapter handle.
+	 */
+	status = acpi_get_handle(lookup->device_handle,
+				 sb->resource_source.string_ptr,
+				 &adapter_handle);
+	if (ACPI_SUCCESS(status) && adapter_handle == lookup->adapter_handle) {
+		info->addr = sb->slave_address;
+		if (sb->access_mode == ACPI_I2C_10BIT_MODE)
+			info->flags |= I2C_CLIENT_TEN;
 	}
 
-	/* Tell the ACPI core to skip this resource */
 	return 1;
 }
 
@@ -123,6 +136,8 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 {
 	struct i2c_adapter *adapter = data;
 	struct list_head resource_list;
+	struct acpi_i2c_lookup lookup;
+	struct resource_entry *entry;
 	struct i2c_board_info info;
 	struct acpi_device *adev;
 	int ret;
@@ -135,14 +150,37 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 	memset(&info, 0, sizeof(info));
 	info.fwnode = acpi_fwnode_handle(adev);
 
+	memset(&lookup, 0, sizeof(lookup));
+	lookup.adapter_handle = ACPI_HANDLE(adapter->dev.parent);
+	lookup.device_handle = handle;
+	lookup.info = &info;
+
+	/*
+	 * Look up for I2cSerialBus resource with ResourceSource that
+	 * matches with this adapter.
+	 */
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list,
-				     acpi_i2c_add_resource, &info);
+				     acpi_i2c_find_address, &lookup);
 	acpi_dev_free_resource_list(&resource_list);
 
 	if (ret < 0 || !info.addr)
 		return AE_OK;
 
+	/* Then fill IRQ number if any */
+	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+	if (ret < 0)
+		return AE_OK;
+
+	resource_list_for_each_entry(entry, &resource_list) {
+		if (resource_type(entry->res) == IORESOURCE_IRQ) {
+			info.irq = entry->res->start;
+			break;
+		}
+	}
+
+	acpi_dev_free_resource_list(&resource_list);
+
 	adev->power.flags.ignore_parent = true;
 	strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
 	if (!i2c_new_device(adapter, &info)) {
@@ -155,6 +193,8 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
 	return AE_OK;
 }
 
+#define ACPI_I2C_MAX_SCAN_DEPTH 32
+
 /**
  * acpi_i2c_register_devices - enumerate I2C slave devices behind adapter
  * @adap: pointer to adapter
@@ -165,17 +205,13 @@ static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level,
  */
 static void acpi_i2c_register_devices(struct i2c_adapter *adap)
 {
-	acpi_handle handle;
 	acpi_status status;
 
-	if (!adap->dev.parent)
-		return;
-
-	handle = ACPI_HANDLE(adap->dev.parent);
-	if (!handle)
+	if (!adap->dev.parent || !has_acpi_companion(adap->dev.parent))
 		return;
 
-	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+				     ACPI_I2C_MAX_SCAN_DEPTH,
 				     acpi_i2c_add_device, NULL,
 				     adap, NULL);
 	if (ACPI_FAILURE(status))
