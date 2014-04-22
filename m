From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [Resend Patch 7/9] I2C/ACPI: Add i2c ACPI operation region
 support
Date: Tue, 22 Apr 2014 14:36:38 +0300
Message-ID: <20140422113638.GK30677@intel.com>
References: <1397654682-7094-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-1-git-send-email-tianyu.lan@intel.com>
 <1398147855-9868-8-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1398147855-9868-8-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: wsa@the-dreams.de, rjw@rjwysocki.net, awilliam@redhat.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 22, 2014 at 02:24:13PM +0800, Lan Tianyu wrote:
> diff --git a/drivers/i2c/i2c-acpi.c b/drivers/i2c/i2c-acpi.c
> new file mode 100644
> index 0000000..942abdf
> --- /dev/null
> +++ b/drivers/i2c/i2c-acpi.c
> @@ -0,0 +1,282 @@
> +/*
> + * I2C ACPI code
> + *
> + * Copyright (C) 2014 Intel Corp
> + *
> + * Author: Lan Tianyu <tianyu.lan@intel.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHA=
NTABILITY
> + * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public =
License
> + * for more details.
> + */
> +#define pr_fmt(fmt) "I2C/ACPI : " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/acpi.h>
> +
> +struct acpi_i2c_handler_data {
> +	struct acpi_connection_info info;
> +	struct i2c_adapter *adapter;
> +} __packed;

Why __packed?

> +
> +struct gsb_buffer {
> +	u8	status;
> +	u8	len;
> +	union {
> +		u16	wdata;
> +		u8	bdata;
> +		u8	data[0];
> +	};
> +} __packed;
> +
> +static int acpi_gsb_i2c_read_bytes(struct i2c_client *client,
> +		u8 cmd, u8 *data, u8 data_len)
> +{
> +
> +	struct i2c_msg msgs[2];
> +	int ret;
> +	u8  *buffer;

You seem to have two spaces here.

> +
> +	buffer =3D kzalloc(data_len, GFP_KERNEL);
> +	if (!buffer)
> +		return AE_NO_MEMORY;
> +
> +	msgs[0].addr =3D client->addr;
> +	msgs[0].flags =3D client->flags;
> +	msgs[0].len =3D 1;
> +	msgs[0].buf =3D &cmd;
> +
> +	msgs[1].addr =3D client->addr;
> +	msgs[1].flags =3D client->flags | I2C_M_RD;
> +	msgs[1].len =3D data_len;
> +	msgs[1].buf =3D buffer;
> +
> +	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret < 0)
> +		pr_err("i2c read failed\n");
> +	else
> +		memcpy(data, buffer, data_len);
> +
> +	kfree(buffer);
> +	return ret;
> +}
> +
> +static int acpi_gsb_i2c_write_bytes(struct i2c_client *client,
> +		u8 cmd, u8 *data, u8 data_len)
> +{
> +
> +	struct i2c_msg msgs[1];
> +	u8  *buffer;

Ditto.

> +	int ret =3D AE_OK;
> +
> +	buffer =3D kzalloc(data_len + 1, GFP_KERNEL);
> +	if (!buffer)
> +		return AE_NO_MEMORY;
> +
> +	buffer[0] =3D cmd;
> +	memcpy(buffer + 1, data, data_len);
> +
> +	msgs[0].addr =3D client->addr;
> +	msgs[0].flags =3D client->flags;
> +	msgs[0].len =3D data_len + 1;
> +	msgs[0].buf =3D buffer;
> +
> +	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +	if (ret < 0)
> +		pr_err("i2c write failed\n");

Since you have pointer to the adapter, can't you use dev_err() instead?

> +
> +	kfree(buffer);
> +	return ret;
> +}
> +
> +static acpi_status
> +acpi_i2c_space_handler(u32 function, acpi_physical_address command,
> +			u32 bits, u64 *value64,
> +			void *handler_context, void *region_context)
> +{
> +	struct gsb_buffer *gsb =3D (struct gsb_buffer *)value64;
> +	struct acpi_i2c_handler_data *data =3D handler_context;
> +	struct acpi_connection_info *info =3D &data->info;
> +	struct acpi_resource_i2c_serialbus *sb;
> +	struct i2c_adapter *adapter =3D data->adapter;
> +	struct i2c_client client;
> +	struct acpi_resource *ares;
> +	u32 accessor_type =3D function >> 16;
> +	u8 action =3D function & ACPI_IO_MASK;
> +	int status;
> +
> +	acpi_buffer_to_resource(info->connection, info->length, &ares);
> +	if (!value64 || ares->type !=3D ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +		return AE_BAD_PARAMETER;
> +
> +	sb =3D &ares->data.i2c_serial_bus;
> +	if (sb->type !=3D ACPI_RESOURCE_SERIAL_TYPE_I2C)
> +		return AE_BAD_PARAMETER;

Do you leak the resource buffer here?

> +
> +	client.adapter =3D adapter;
> +	client.addr =3D sb->slave_address;
> +	client.flags =3D 0;

I'm not sure if this is the correct way to use struct i2c_client
(allocating it from stack and passing forward to functions that might
expect a real i2c_client structure). It has ->dev and all.

I'm=A0wondering if you can use i2c_transfer() and i2c_smbus_xfer() here
instead, passing just the adapter pointer?

> +
> +	if (sb->access_mode =3D=3D ACPI_I2C_10BIT_MODE)
> +		client.flags |=3D I2C_CLIENT_TEN;
> +
> +	switch (accessor_type) {
> +	case ACPI_GSB_ACCESS_ATTRIB_QUICK:
> +		if (action =3D=3D ACPI_READ)
> +			status =3D i2c_smbus_quick_read(&client);
> +		else
> +			status =3D i2c_smbus_quick_write(&client);
> +		break;
> +
> +	case ACPI_GSB_ACCESS_ATTRIB_SEND_RCV:
> +		if (action =3D=3D ACPI_READ) {
> +			status =3D i2c_smbus_read_byte(&client);
> +			if (status >=3D 0) {
> +				gsb->bdata =3D status;
> +				status =3D 0;
> +			}
> +		} else {
> +			status =3D i2c_smbus_write_byte(&client, gsb->bdata);
> +		}
> +		break;
> +
> +	case ACPI_GSB_ACCESS_ATTRIB_BYTE:
> +		if (action =3D=3D ACPI_READ) {
> +			status =3D i2c_smbus_read_byte_data(&client, command);
> +			if (status >=3D 0) {
> +				gsb->bdata =3D status;
> +				status =3D 0;
> +			}
> +		} else {
> +			status =3D i2c_smbus_write_byte_data(&client, command,
> +					gsb->bdata);
> +		}
> +		break;
> +
> +	case ACPI_GSB_ACCESS_ATTRIB_WORD:
> +		if (action =3D=3D ACPI_READ) {
> +			status =3D i2c_smbus_read_word_data(&client, command);
> +			if (status >=3D 0) {
> +				gsb->wdata =3D status;
> +				status =3D 0;
> +			}
> +		} else {
> +			status =3D i2c_smbus_write_word_data(&client, command,
> +					gsb->wdata);
> +		}
> +		break;
> +
> +	case ACPI_GSB_ACCESS_ATTRIB_BLOCK:
> +		if (action =3D=3D ACPI_READ) {
> +			status =3D i2c_smbus_read_block_data(&client, command,
> +					gsb->data);
> +			if (status >=3D 0) {
> +				gsb->len =3D status;
> +				status =3D 0;
> +			}
> +		} else {
> +			status =3D i2c_smbus_write_block_data(&client, command,
> +					gsb->len, gsb->data);
> +		}
> +		break;
> +
> +	case ACPI_GSB_ACCESS_ATTRIB_MULTIBYTE:
> +		if (action =3D=3D ACPI_READ) {
> +			status =3D acpi_gsb_i2c_read_bytes(&client, command,
> +					gsb->data, info->access_length);
> +			if (status > 0)
> +				status =3D 0;
> +		} else {
> +			status =3D acpi_gsb_i2c_write_bytes(&client, command,
> +					gsb->data, info->access_length);
> +		}
> +		break;
> +
> +	case ACPI_GSB_ACCESS_ATTRIB_WORD_CALL:
> +		status =3D i2c_smbus_word_proc_call(&client, command, gsb->wdata);
> +		if (status >=3D 0) {
> +			gsb->wdata =3D status;
> +			status =3D 0;
> +		}
> +		break;
> +
> +	case ACPI_GSB_ACCESS_ATTRIB_BLOCK_CALL:
> +		status =3D i2c_smbus_block_proc_call(&client, command, gsb->len,
> +				gsb->data);
> +		if (status > 0) {
> +			gsb->len =3D status;
> +			status =3D 0;
> +		}
> +		break;
> +
> +	default:
> +		pr_info("protocl(0x%02x) is not supported.\n", accessor_type);

protocl -> protocol

> +		return AE_BAD_PARAMETER;
> +	}
> +
> +	gsb->status =3D status;
> +	return AE_OK;
> +}
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
