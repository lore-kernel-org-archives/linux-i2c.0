From: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-scmi: support IBM SMBus CMI devices
Date: Mon, 26 Oct 2009 10:54:06 +0800
Message-ID: <20091026025406.GC8086@crane-desktop>
References: <20091020231149.GM26149@tux1.beaverton.ibm.com> <20091021023016.GC32413@crane-desktop> <200910210857.13978.bjorn.helgaas@hp.com> <20091021173733.GN26149@tux1.beaverton.ibm.com> <20091022071748.GA17917@crane-desktop> <20091022174304.GO26149@tux1.beaverton.ibm.com> <20091023044451.GB1367@crane-desktop> <20091023170306.GP26149@tux1.beaverton.ibm.com> <20091025103932.31ce9a6d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091025103932.31ce9a6d-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: djwong-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Darrick,

I have modified the source as Jean suggested. Please apply.

---
>From 5b745774be8fe3f9670fe296b56a0c2964a362f8 Mon Sep 17 00:00:00 2001
From: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 23 Oct 2009 10:13:58 +0800
Subject: [PATCH] i2c-scmi: support IBM SMBus CMI devices

*) add a new HID for IBM SMBus CMI devices
*) add methods for IBM SMBus CMI devices
*) hook different HID with different control methods set

Signed-off-by: Crane Cai <crane.cai-5C7GfCeVMHo@public.gmane.org>
---
 drivers/i2c/busses/i2c-scmi.c |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-scmi.c b/drivers/i2c/busses/i2c-scmi.c
index b4a55d4..d68b44f 100644
--- a/drivers/i2c/busses/i2c-scmi.c
+++ b/drivers/i2c/busses/i2c-scmi.c
@@ -33,6 +33,7 @@ struct acpi_smbus_cmi {
 	u8 cap_info:1;
 	u8 cap_read:1;
 	u8 cap_write:1;
+	struct smbus_methods_t *methods;
 };
 
 static const struct smbus_methods_t smbus_methods = {
@@ -41,8 +42,16 @@ static const struct smbus_methods_t smbus_methods = {
 	.mt_sbw  = "_SBW",
 };
 
+/* Some IBM BIOSes omit the leading underscore */
+static const struct smbus_methods_t ibm_smbus_methods = {
+	.mt_info = "SBI_",
+	.mt_sbr  = "SBR_",
+	.mt_sbw  = "SBW_",
+};
+
 static const struct acpi_device_id acpi_smbus_cmi_ids[] = {
-	{"SMBUS01", 0},
+	{"SMBUS01", (kernel_ulong_t)&smbus_methods},
+	{"SMBUSIBM", (kernel_ulong_t)&ibm_smbus_methods},
 	{"", 0}
 };
 
@@ -150,11 +159,11 @@ acpi_smbus_cmi_access(struct i2c_adapter *adap, u16 addr, unsigned short flags,
 
 	if (read_write == I2C_SMBUS_READ) {
 		protocol |= ACPI_SMBUS_PRTCL_READ;
-		method = smbus_methods.mt_sbr;
+		method = smbus_cmi->methods->mt_sbr;
 		input.count = 3;
 	} else {
 		protocol |= ACPI_SMBUS_PRTCL_WRITE;
-		method = smbus_methods.mt_sbw;
+		method = smbus_cmi->methods->mt_sbw;
 		input.count = 5;
 	}
 
@@ -290,13 +299,13 @@ static int acpi_smbus_cmi_add_cap(struct acpi_smbus_cmi *smbus_cmi,
 	union acpi_object *obj;
 	acpi_status status;
 
-	if (!strcmp(name, smbus_methods.mt_info)) {
+	if (!strcmp(name, smbus_cmi->methods->mt_info)) {
 		status = acpi_evaluate_object(smbus_cmi->handle,
-					smbus_methods.mt_info,
+					smbus_cmi->methods->mt_info,
 					NULL, &buffer);
 		if (ACPI_FAILURE(status)) {
 			ACPI_ERROR((AE_INFO, "Evaluating %s: %i",
-				   smbus_methods.mt_info, status));
+				   smbus_cmi->methods->mt_info, status));
 			return -EIO;
 		}
 
@@ -319,9 +328,9 @@ static int acpi_smbus_cmi_add_cap(struct acpi_smbus_cmi *smbus_cmi,
 
 		kfree(buffer.pointer);
 		smbus_cmi->cap_info = 1;
-	} else if (!strcmp(name, smbus_methods.mt_sbr))
+	} else if (!strcmp(name, smbus_cmi->methods->mt_sbr))
 		smbus_cmi->cap_read = 1;
-	else if (!strcmp(name, smbus_methods.mt_sbw))
+	else if (!strcmp(name, smbus_cmi->methods->mt_sbw))
 		smbus_cmi->cap_write = 1;
 	else
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Unsupported CMI method: %s\n",
@@ -349,6 +358,7 @@ static acpi_status acpi_smbus_cmi_query_methods(acpi_handle handle, u32 level,
 static int acpi_smbus_cmi_add(struct acpi_device *device)
 {
 	struct acpi_smbus_cmi *smbus_cmi;
+	const struct acpi_device_id *id;
 
 	smbus_cmi = kzalloc(sizeof(struct acpi_smbus_cmi), GFP_KERNEL);
 	if (!smbus_cmi)
@@ -362,6 +372,11 @@ static int acpi_smbus_cmi_add(struct acpi_device *device)
 	smbus_cmi->cap_read = 0;
 	smbus_cmi->cap_write = 0;
 
+	for (id = acpi_smbus_cmi_ids; id->id[0]; id++)
+		if (!strcmp(id->id, acpi_device_hid(device)))
+			smbus_cmi->methods =
+				(struct smbus_methods_t *) id->driver_data;
+
 	acpi_walk_namespace(ACPI_TYPE_METHOD, smbus_cmi->handle, 1,
 			    acpi_smbus_cmi_query_methods, smbus_cmi, NULL);
 
-- 
1.6.0.4


On Sun, Oct 25, 2009 at 10:39:32AM +0100, Jean Delvare wrote:
> > +	for (id = (struct acpi_device_id *)acpi_smbus_cmi_ids; id->id[0]; id++)
> 
> This cast shouldn't be needed. The problem is that you should have
> declared "id" const in the first place.
> 
> > +		if (!strcmp((char *) id->id, acpi_device_hid(device)))
> 
> This cast doesn't seem needed either. At least I don't get any warning
> without it, do you?
> 

-- 
Best Regards,
- Crane
