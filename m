From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] i2c: core: Reduce stack size of acpi_i2c_space_handler()
Date: Wed, 29 Apr 2015 15:44:37 +0300
Message-ID: <1430311477-21759-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1430311477-21759-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430311477-21759-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

sizeof(struct i2c_client) is 1088 bytes on a CONFIG_X86_64=3Dy build an=
d
produces following warning when CONFIG_FRAME_WARN is set to 1024:

drivers/i2c/i2c-core.c: In function =E2=80=98acpi_i2c_space_handler=E2=80=
=99:
drivers/i2c/i2c-core.c:367:1: warning: the frame size of 1152 bytes is
larger than 1024 bytes [-Wframe-larger-than=3D]

This is not critical given that kernel stack is 16 kB on x86_64 but let=
s
reduce the stack usage by allocating the struct i2c_client from the hea=
p.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 051aa3a811a8..3f25d758d83e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -258,7 +258,7 @@ acpi_i2c_space_handler(u32 function, acpi_physical_=
address command,
 	struct acpi_connection_info *info =3D &data->info;
 	struct acpi_resource_i2c_serialbus *sb;
 	struct i2c_adapter *adapter =3D data->adapter;
-	struct i2c_client client;
+	struct i2c_client *client;
 	struct acpi_resource *ares;
 	u32 accessor_type =3D function >> 16;
 	u8 action =3D function & ACPI_IO_MASK;
@@ -269,6 +269,12 @@ acpi_i2c_space_handler(u32 function, acpi_physical=
_address command,
 	if (ACPI_FAILURE(ret))
 		return ret;
=20
+	client =3D kzalloc(sizeof(*client), GFP_KERNEL);
+	if (!client) {
+		ret =3D AE_NO_MEMORY;
+		goto err;
+	}
+
 	if (!value64 || ares->type !=3D ACPI_RESOURCE_TYPE_SERIAL_BUS) {
 		ret =3D AE_BAD_PARAMETER;
 		goto err;
@@ -280,74 +286,73 @@ acpi_i2c_space_handler(u32 function, acpi_physica=
l_address command,
 		goto err;
 	}
=20
-	memset(&client, 0, sizeof(client));
-	client.adapter =3D adapter;
-	client.addr =3D sb->slave_address;
+	client->adapter =3D adapter;
+	client->addr =3D sb->slave_address;
=20
 	if (sb->access_mode =3D=3D ACPI_I2C_10BIT_MODE)
-		client.flags |=3D I2C_CLIENT_TEN;
+		client->flags |=3D I2C_CLIENT_TEN;
=20
 	switch (accessor_type) {
 	case ACPI_GSB_ACCESS_ATTRIB_SEND_RCV:
 		if (action =3D=3D ACPI_READ) {
-			status =3D i2c_smbus_read_byte(&client);
+			status =3D i2c_smbus_read_byte(client);
 			if (status >=3D 0) {
 				gsb->bdata =3D status;
 				status =3D 0;
 			}
 		} else {
-			status =3D i2c_smbus_write_byte(&client, gsb->bdata);
+			status =3D i2c_smbus_write_byte(client, gsb->bdata);
 		}
 		break;
=20
 	case ACPI_GSB_ACCESS_ATTRIB_BYTE:
 		if (action =3D=3D ACPI_READ) {
-			status =3D i2c_smbus_read_byte_data(&client, command);
+			status =3D i2c_smbus_read_byte_data(client, command);
 			if (status >=3D 0) {
 				gsb->bdata =3D status;
 				status =3D 0;
 			}
 		} else {
-			status =3D i2c_smbus_write_byte_data(&client, command,
+			status =3D i2c_smbus_write_byte_data(client, command,
 					gsb->bdata);
 		}
 		break;
=20
 	case ACPI_GSB_ACCESS_ATTRIB_WORD:
 		if (action =3D=3D ACPI_READ) {
-			status =3D i2c_smbus_read_word_data(&client, command);
+			status =3D i2c_smbus_read_word_data(client, command);
 			if (status >=3D 0) {
 				gsb->wdata =3D status;
 				status =3D 0;
 			}
 		} else {
-			status =3D i2c_smbus_write_word_data(&client, command,
+			status =3D i2c_smbus_write_word_data(client, command,
 					gsb->wdata);
 		}
 		break;
=20
 	case ACPI_GSB_ACCESS_ATTRIB_BLOCK:
 		if (action =3D=3D ACPI_READ) {
-			status =3D i2c_smbus_read_block_data(&client, command,
+			status =3D i2c_smbus_read_block_data(client, command,
 					gsb->data);
 			if (status >=3D 0) {
 				gsb->len =3D status;
 				status =3D 0;
 			}
 		} else {
-			status =3D i2c_smbus_write_block_data(&client, command,
+			status =3D i2c_smbus_write_block_data(client, command,
 					gsb->len, gsb->data);
 		}
 		break;
=20
 	case ACPI_GSB_ACCESS_ATTRIB_MULTIBYTE:
 		if (action =3D=3D ACPI_READ) {
-			status =3D acpi_gsb_i2c_read_bytes(&client, command,
+			status =3D acpi_gsb_i2c_read_bytes(client, command,
 					gsb->data, info->access_length);
 			if (status > 0)
 				status =3D 0;
 		} else {
-			status =3D acpi_gsb_i2c_write_bytes(&client, command,
+			status =3D acpi_gsb_i2c_write_bytes(client, command,
 					gsb->data, info->access_length);
 		}
 		break;
@@ -361,6 +366,7 @@ acpi_i2c_space_handler(u32 function, acpi_physical_=
address command,
 	gsb->status =3D status;
=20
 err:
+	kfree(client);
 	ACPI_FREE(ares);
 	return ret;
 }
--=20
2.1.4
