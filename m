From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: move acpi code back into the core
Date: Tue, 23 Sep 2014 09:37:13 +0800
Message-ID: <5420CEC9.1030400@intel.com>
References: <1411420006-4713-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411420006-4713-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2014=E5=B9=B409=E6=9C=8823=E6=97=A5 05:06, Wolfram Sang wrote:
> Commit 5d98e61d337c ("I2C/ACPI: Add i2c ACPI operation region support=
") renamed
> the i2c-core module. This may cause regressions for distributions, so=
 put the
> ACPI code back into the core. No code was changed.
>=20
> Reported-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> ---
>=20
> Lan Tianyi, this is a patch I expected to get from you, fully tested.=
 Since we
> are approaching the final release soon, I did it now. Please do test =
this
> patch. All I can do is build test (it works for me, build robots are =
still
> running). If nobody tests this, I have to revert the ACPI changes of =
this
> cycle.

Hi Wolfram:

Sorry for later response due to sickness. I can't write this patch in
time. Sorry again. I will test it soon.

>=20
> Jean, can you have a look, too?
>=20
> We can think of something better for the next release, but for now, t=
his should be it.
>=20
>  MAINTAINERS            |   1 -
>  drivers/i2c/Makefile   |   5 +-
>  drivers/i2c/i2c-acpi.c | 364 ---------------------------------------=
----------
>  drivers/i2c/i2c-core.c | 345 +++++++++++++++++++++++++++++++++++++++=
+++++++
>  4 files changed, 346 insertions(+), 369 deletions(-)
>  delete mode 100644 drivers/i2c/i2c-acpi.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 809ecd680d88..e3682d0dea1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4477,7 +4477,6 @@ M:	Mika Westerberg <mika.westerberg-VuQAYsv1560/9W2qTSuDoA@public.gmane.org=
=2Ecom>
>  L:	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>  L:	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>  S:	Maintained
> -F:	drivers/i2c/i2c-acpi.c
> =20
>  I2C-TAOS-EVM DRIVER
>  M:	Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
> diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
> index e0228b228256..1722f50f2473 100644
> --- a/drivers/i2c/Makefile
> +++ b/drivers/i2c/Makefile
> @@ -2,11 +2,8 @@
>  # Makefile for the i2c core.
>  #
> =20
> -i2ccore-y :=3D i2c-core.o
> -i2ccore-$(CONFIG_ACPI)	 	+=3D i2c-acpi.o
> -
>  obj-$(CONFIG_I2C_BOARDINFO)	+=3D i2c-boardinfo.o
> -obj-$(CONFIG_I2C)		+=3D i2ccore.o
> +obj-$(CONFIG_I2C)		+=3D i2c-core.o
>  obj-$(CONFIG_I2C_SMBUS)		+=3D i2c-smbus.o
>  obj-$(CONFIG_I2C_CHARDEV)	+=3D i2c-dev.o
>  obj-$(CONFIG_I2C_MUX)		+=3D i2c-mux.o
> diff --git a/drivers/i2c/i2c-acpi.c b/drivers/i2c/i2c-acpi.c
> deleted file mode 100644
> index 0dbc18c15c43..000000000000
> --- a/drivers/i2c/i2c-acpi.c
> +++ /dev/null
> @@ -1,364 +0,0 @@
> -/*
> - * I2C ACPI code
> - *
> - * Copyright (C) 2014 Intel Corp
> - *
> - * Author: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, b=
ut
> - * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHA=
NTABILITY
> - * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public =
License
> - * for more details.
> - */
> -#define pr_fmt(fmt) "I2C/ACPI : " fmt
> -
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/err.h>
> -#include <linux/i2c.h>
> -#include <linux/acpi.h>
> -
> -struct acpi_i2c_handler_data {
> -	struct acpi_connection_info info;
> -	struct i2c_adapter *adapter;
> -};
> -
> -struct gsb_buffer {
> -	u8	status;
> -	u8	len;
> -	union {
> -		u16	wdata;
> -		u8	bdata;
> -		u8	data[0];
> -	};
> -} __packed;
> -
> -static int acpi_i2c_add_resource(struct acpi_resource *ares, void *d=
ata)
> -{
> -	struct i2c_board_info *info =3D data;
> -
> -	if (ares->type =3D=3D ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> -		struct acpi_resource_i2c_serialbus *sb;
> -
> -		sb =3D &ares->data.i2c_serial_bus;
> -		if (sb->type =3D=3D ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> -			info->addr =3D sb->slave_address;
> -			if (sb->access_mode =3D=3D ACPI_I2C_10BIT_MODE)
> -				info->flags |=3D I2C_CLIENT_TEN;
> -		}
> -	} else if (info->irq < 0) {
> -		struct resource r;
> -
> -		if (acpi_dev_resource_interrupt(ares, 0, &r))
> -			info->irq =3D r.start;
> -	}
> -
> -	/* Tell the ACPI core to skip this resource */
> -	return 1;
> -}
> -
> -static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level=
,
> -				       void *data, void **return_value)
> -{
> -	struct i2c_adapter *adapter =3D data;
> -	struct list_head resource_list;
> -	struct i2c_board_info info;
> -	struct acpi_device *adev;
> -	int ret;
> -
> -	if (acpi_bus_get_device(handle, &adev))
> -		return AE_OK;
> -	if (acpi_bus_get_status(adev) || !adev->status.present)
> -		return AE_OK;
> -
> -	memset(&info, 0, sizeof(info));
> -	info.acpi_node.companion =3D adev;
> -	info.irq =3D -1;
> -
> -	INIT_LIST_HEAD(&resource_list);
> -	ret =3D acpi_dev_get_resources(adev, &resource_list,
> -				     acpi_i2c_add_resource, &info);
> -	acpi_dev_free_resource_list(&resource_list);
> -
> -	if (ret < 0 || !info.addr)
> -		return AE_OK;
> -
> -	adev->power.flags.ignore_parent =3D true;
> -	strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
> -	if (!i2c_new_device(adapter, &info)) {
> -		adev->power.flags.ignore_parent =3D false;
> -		dev_err(&adapter->dev,
> -			"failed to add I2C device %s from ACPI\n",
> -			dev_name(&adev->dev));
> -	}
> -
> -	return AE_OK;
> -}
> -
> -/**
> - * acpi_i2c_register_devices - enumerate I2C slave devices behind ad=
apter
> - * @adap: pointer to adapter
> - *
> - * Enumerate all I2C slave devices behind this adapter by walking th=
e ACPI
> - * namespace. When a device is found it will be added to the Linux d=
evice
> - * model and bound to the corresponding ACPI handle.
> - */
> -void acpi_i2c_register_devices(struct i2c_adapter *adap)
> -{
> -	acpi_handle handle;
> -	acpi_status status;
> -
> -	if (!adap->dev.parent)
> -		return;
> -
> -	handle =3D ACPI_HANDLE(adap->dev.parent);
> -	if (!handle)
> -		return;
> -
> -	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> -				     acpi_i2c_add_device, NULL,
> -				     adap, NULL);
> -	if (ACPI_FAILURE(status))
> -		dev_warn(&adap->dev, "failed to enumerate I2C slaves\n");
> -}
> -
> -#ifdef CONFIG_ACPI_I2C_OPREGION
> -static int acpi_gsb_i2c_read_bytes(struct i2c_client *client,
> -		u8 cmd, u8 *data, u8 data_len)
> -{
> -
> -	struct i2c_msg msgs[2];
> -	int ret;
> -	u8 *buffer;
> -
> -	buffer =3D kzalloc(data_len, GFP_KERNEL);
> -	if (!buffer)
> -		return AE_NO_MEMORY;
> -
> -	msgs[0].addr =3D client->addr;
> -	msgs[0].flags =3D client->flags;
> -	msgs[0].len =3D 1;
> -	msgs[0].buf =3D &cmd;
> -
> -	msgs[1].addr =3D client->addr;
> -	msgs[1].flags =3D client->flags | I2C_M_RD;
> -	msgs[1].len =3D data_len;
> -	msgs[1].buf =3D buffer;
> -
> -	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> -	if (ret < 0)
> -		dev_err(&client->adapter->dev, "i2c read failed\n");
> -	else
> -		memcpy(data, buffer, data_len);
> -
> -	kfree(buffer);
> -	return ret;
> -}
> -
> -static int acpi_gsb_i2c_write_bytes(struct i2c_client *client,
> -		u8 cmd, u8 *data, u8 data_len)
> -{
> -
> -	struct i2c_msg msgs[1];
> -	u8 *buffer;
> -	int ret =3D AE_OK;
> -
> -	buffer =3D kzalloc(data_len + 1, GFP_KERNEL);
> -	if (!buffer)
> -		return AE_NO_MEMORY;
> -
> -	buffer[0] =3D cmd;
> -	memcpy(buffer + 1, data, data_len);
> -
> -	msgs[0].addr =3D client->addr;
> -	msgs[0].flags =3D client->flags;
> -	msgs[0].len =3D data_len + 1;
> -	msgs[0].buf =3D buffer;
> -
> -	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> -	if (ret < 0)
> -		dev_err(&client->adapter->dev, "i2c write failed\n");
> -
> -	kfree(buffer);
> -	return ret;
> -}
> -
> -static acpi_status
> -acpi_i2c_space_handler(u32 function, acpi_physical_address command,
> -			u32 bits, u64 *value64,
> -			void *handler_context, void *region_context)
> -{
> -	struct gsb_buffer *gsb =3D (struct gsb_buffer *)value64;
> -	struct acpi_i2c_handler_data *data =3D handler_context;
> -	struct acpi_connection_info *info =3D &data->info;
> -	struct acpi_resource_i2c_serialbus *sb;
> -	struct i2c_adapter *adapter =3D data->adapter;
> -	struct i2c_client client;
> -	struct acpi_resource *ares;
> -	u32 accessor_type =3D function >> 16;
> -	u8 action =3D function & ACPI_IO_MASK;
> -	acpi_status ret =3D AE_OK;
> -	int status;
> -
> -	ret =3D acpi_buffer_to_resource(info->connection, info->length, &ar=
es);
> -	if (ACPI_FAILURE(ret))
> -		return ret;
> -
> -	if (!value64 || ares->type !=3D ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> -		ret =3D AE_BAD_PARAMETER;
> -		goto err;
> -	}
> -
> -	sb =3D &ares->data.i2c_serial_bus;
> -	if (sb->type !=3D ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> -		ret =3D AE_BAD_PARAMETER;
> -		goto err;
> -	}
> -
> -	memset(&client, 0, sizeof(client));
> -	client.adapter =3D adapter;
> -	client.addr =3D sb->slave_address;
> -	client.flags =3D 0;
> -
> -	if (sb->access_mode =3D=3D ACPI_I2C_10BIT_MODE)
> -		client.flags |=3D I2C_CLIENT_TEN;
> -
> -	switch (accessor_type) {
> -	case ACPI_GSB_ACCESS_ATTRIB_SEND_RCV:
> -		if (action =3D=3D ACPI_READ) {
> -			status =3D i2c_smbus_read_byte(&client);
> -			if (status >=3D 0) {
> -				gsb->bdata =3D status;
> -				status =3D 0;
> -			}
> -		} else {
> -			status =3D i2c_smbus_write_byte(&client, gsb->bdata);
> -		}
> -		break;
> -
> -	case ACPI_GSB_ACCESS_ATTRIB_BYTE:
> -		if (action =3D=3D ACPI_READ) {
> -			status =3D i2c_smbus_read_byte_data(&client, command);
> -			if (status >=3D 0) {
> -				gsb->bdata =3D status;
> -				status =3D 0;
> -			}
> -		} else {
> -			status =3D i2c_smbus_write_byte_data(&client, command,
> -					gsb->bdata);
> -		}
> -		break;
> -
> -	case ACPI_GSB_ACCESS_ATTRIB_WORD:
> -		if (action =3D=3D ACPI_READ) {
> -			status =3D i2c_smbus_read_word_data(&client, command);
> -			if (status >=3D 0) {
> -				gsb->wdata =3D status;
> -				status =3D 0;
> -			}
> -		} else {
> -			status =3D i2c_smbus_write_word_data(&client, command,
> -					gsb->wdata);
> -		}
> -		break;
> -
> -	case ACPI_GSB_ACCESS_ATTRIB_BLOCK:
> -		if (action =3D=3D ACPI_READ) {
> -			status =3D i2c_smbus_read_block_data(&client, command,
> -					gsb->data);
> -			if (status >=3D 0) {
> -				gsb->len =3D status;
> -				status =3D 0;
> -			}
> -		} else {
> -			status =3D i2c_smbus_write_block_data(&client, command,
> -					gsb->len, gsb->data);
> -		}
> -		break;
> -
> -	case ACPI_GSB_ACCESS_ATTRIB_MULTIBYTE:
> -		if (action =3D=3D ACPI_READ) {
> -			status =3D acpi_gsb_i2c_read_bytes(&client, command,
> -					gsb->data, info->access_length);
> -			if (status > 0)
> -				status =3D 0;
> -		} else {
> -			status =3D acpi_gsb_i2c_write_bytes(&client, command,
> -					gsb->data, info->access_length);
> -		}
> -		break;
> -
> -	default:
> -		pr_info("protocol(0x%02x) is not supported.\n", accessor_type);
> -		ret =3D AE_BAD_PARAMETER;
> -		goto err;
> -	}
> -
> -	gsb->status =3D status;
> -
> - err:
> -	ACPI_FREE(ares);
> -	return ret;
> -}
> -
> -
> -int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
> -{
> -	acpi_handle handle =3D ACPI_HANDLE(adapter->dev.parent);
> -	struct acpi_i2c_handler_data *data;
> -	acpi_status status;
> -
> -	if (!handle)
> -		return -ENODEV;
> -
> -	data =3D kzalloc(sizeof(struct acpi_i2c_handler_data),
> -			    GFP_KERNEL);
> -	if (!data)
> -		return -ENOMEM;
> -
> -	data->adapter =3D adapter;
> -	status =3D acpi_bus_attach_private_data(handle, (void *)data);
> -	if (ACPI_FAILURE(status)) {
> -		kfree(data);
> -		return -ENOMEM;
> -	}
> -
> -	status =3D acpi_install_address_space_handler(handle,
> -				ACPI_ADR_SPACE_GSBUS,
> -				&acpi_i2c_space_handler,
> -				NULL,
> -				data);
> -	if (ACPI_FAILURE(status)) {
> -		dev_err(&adapter->dev, "Error installing i2c space handler\n");
> -		acpi_bus_detach_private_data(handle);
> -		kfree(data);
> -		return -ENOMEM;
> -	}
> -
> -	return 0;
> -}
> -
> -void acpi_i2c_remove_space_handler(struct i2c_adapter *adapter)
> -{
> -	acpi_handle handle =3D ACPI_HANDLE(adapter->dev.parent);
> -	struct acpi_i2c_handler_data *data;
> -	acpi_status status;
> -
> -	if (!handle)
> -		return;
> -
> -	acpi_remove_address_space_handler(handle,
> -				ACPI_ADR_SPACE_GSBUS,
> -				&acpi_i2c_space_handler);
> -
> -	status =3D acpi_bus_get_private_data(handle, (void **)&data);
> -	if (ACPI_SUCCESS(status))
> -		kfree(data);
> -
> -	acpi_bus_detach_private_data(handle);
> -}
> -#endif
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index 632057a44615..3fbd5d5c38bf 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -27,6 +27,8 @@
>     OF support is copyright (c) 2008 Jochen Friedrich <jochen@scram.d=
e>
>     (based on a previous patch from Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>) a=
nd
>     (c) 2013  Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> +   I2C ACPI code Copyright (C) 2014 Intel Corp
> +   Author: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>   */
> =20
>  #include <linux/module.h>
> @@ -78,6 +80,349 @@ void i2c_transfer_trace_unreg(void)
>  	static_key_slow_dec(&i2c_trace_msg);
>  }
> =20
> +#if defined(CONFIG_ACPI)
> +struct acpi_i2c_handler_data {
> +	struct acpi_connection_info info;
> +	struct i2c_adapter *adapter;
> +};
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
> +static int acpi_i2c_add_resource(struct acpi_resource *ares, void *d=
ata)
> +{
> +	struct i2c_board_info *info =3D data;
> +
> +	if (ares->type =3D=3D ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> +		struct acpi_resource_i2c_serialbus *sb;
> +
> +		sb =3D &ares->data.i2c_serial_bus;
> +		if (sb->type =3D=3D ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> +			info->addr =3D sb->slave_address;
> +			if (sb->access_mode =3D=3D ACPI_I2C_10BIT_MODE)
> +				info->flags |=3D I2C_CLIENT_TEN;
> +		}
> +	} else if (info->irq < 0) {
> +		struct resource r;
> +
> +		if (acpi_dev_resource_interrupt(ares, 0, &r))
> +			info->irq =3D r.start;
> +	}
> +
> +	/* Tell the ACPI core to skip this resource */
> +	return 1;
> +}
> +
> +static acpi_status acpi_i2c_add_device(acpi_handle handle, u32 level=
,
> +				       void *data, void **return_value)
> +{
> +	struct i2c_adapter *adapter =3D data;
> +	struct list_head resource_list;
> +	struct i2c_board_info info;
> +	struct acpi_device *adev;
> +	int ret;
> +
> +	if (acpi_bus_get_device(handle, &adev))
> +		return AE_OK;
> +	if (acpi_bus_get_status(adev) || !adev->status.present)
> +		return AE_OK;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.acpi_node.companion =3D adev;
> +	info.irq =3D -1;
> +
> +	INIT_LIST_HEAD(&resource_list);
> +	ret =3D acpi_dev_get_resources(adev, &resource_list,
> +				     acpi_i2c_add_resource, &info);
> +	acpi_dev_free_resource_list(&resource_list);
> +
> +	if (ret < 0 || !info.addr)
> +		return AE_OK;
> +
> +	adev->power.flags.ignore_parent =3D true;
> +	strlcpy(info.type, dev_name(&adev->dev), sizeof(info.type));
> +	if (!i2c_new_device(adapter, &info)) {
> +		adev->power.flags.ignore_parent =3D false;
> +		dev_err(&adapter->dev,
> +			"failed to add I2C device %s from ACPI\n",
> +			dev_name(&adev->dev));
> +	}
> +
> +	return AE_OK;
> +}
> +
> +/**
> + * acpi_i2c_register_devices - enumerate I2C slave devices behind ad=
apter
> + * @adap: pointer to adapter
> + *
> + * Enumerate all I2C slave devices behind this adapter by walking th=
e ACPI
> + * namespace. When a device is found it will be added to the Linux d=
evice
> + * model and bound to the corresponding ACPI handle.
> + */
> +void acpi_i2c_register_devices(struct i2c_adapter *adap)
> +{
> +	acpi_handle handle;
> +	acpi_status status;
> +
> +	if (!adap->dev.parent)
> +		return;
> +
> +	handle =3D ACPI_HANDLE(adap->dev.parent);
> +	if (!handle)
> +		return;
> +
> +	status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +				     acpi_i2c_add_device, NULL,
> +				     adap, NULL);
> +	if (ACPI_FAILURE(status))
> +		dev_warn(&adap->dev, "failed to enumerate I2C slaves\n");
> +}
> +
> +#ifdef CONFIG_ACPI_I2C_OPREGION
> +static int acpi_gsb_i2c_read_bytes(struct i2c_client *client,
> +		u8 cmd, u8 *data, u8 data_len)
> +{
> +
> +	struct i2c_msg msgs[2];
> +	int ret;
> +	u8 *buffer;
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
> +		dev_err(&client->adapter->dev, "i2c read failed\n");
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
> +	u8 *buffer;
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
> +		dev_err(&client->adapter->dev, "i2c write failed\n");
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
> +	acpi_status ret =3D AE_OK;
> +	int status;
> +
> +	ret =3D acpi_buffer_to_resource(info->connection, info->length, &ar=
es);
> +	if (ACPI_FAILURE(ret))
> +		return ret;
> +
> +	if (!value64 || ares->type !=3D ACPI_RESOURCE_TYPE_SERIAL_BUS) {
> +		ret =3D AE_BAD_PARAMETER;
> +		goto err;
> +	}
> +
> +	sb =3D &ares->data.i2c_serial_bus;
> +	if (sb->type !=3D ACPI_RESOURCE_SERIAL_TYPE_I2C) {
> +		ret =3D AE_BAD_PARAMETER;
> +		goto err;
> +	}
> +
> +	memset(&client, 0, sizeof(client));
> +	client.adapter =3D adapter;
> +	client.addr =3D sb->slave_address;
> +	client.flags =3D 0;
> +
> +	if (sb->access_mode =3D=3D ACPI_I2C_10BIT_MODE)
> +		client.flags |=3D I2C_CLIENT_TEN;
> +
> +	switch (accessor_type) {
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
> +	default:
> +		pr_info("protocol(0x%02x) is not supported.\n", accessor_type);
> +		ret =3D AE_BAD_PARAMETER;
> +		goto err;
> +	}
> +
> +	gsb->status =3D status;
> +
> + err:
> +	ACPI_FREE(ares);
> +	return ret;
> +}
> +
> +
> +int acpi_i2c_install_space_handler(struct i2c_adapter *adapter)
> +{
> +	acpi_handle handle =3D ACPI_HANDLE(adapter->dev.parent);
> +	struct acpi_i2c_handler_data *data;
> +	acpi_status status;
> +
> +	if (!handle)
> +		return -ENODEV;
> +
> +	data =3D kzalloc(sizeof(struct acpi_i2c_handler_data),
> +			    GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->adapter =3D adapter;
> +	status =3D acpi_bus_attach_private_data(handle, (void *)data);
> +	if (ACPI_FAILURE(status)) {
> +		kfree(data);
> +		return -ENOMEM;
> +	}
> +
> +	status =3D acpi_install_address_space_handler(handle,
> +				ACPI_ADR_SPACE_GSBUS,
> +				&acpi_i2c_space_handler,
> +				NULL,
> +				data);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&adapter->dev, "Error installing i2c space handler\n");
> +		acpi_bus_detach_private_data(handle);
> +		kfree(data);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +void acpi_i2c_remove_space_handler(struct i2c_adapter *adapter)
> +{
> +	acpi_handle handle =3D ACPI_HANDLE(adapter->dev.parent);
> +	struct acpi_i2c_handler_data *data;
> +	acpi_status status;
> +
> +	if (!handle)
> +		return;
> +
> +	acpi_remove_address_space_handler(handle,
> +				ACPI_ADR_SPACE_GSBUS,
> +				&acpi_i2c_space_handler);
> +
> +	status =3D acpi_bus_get_private_data(handle, (void **)&data);
> +	if (ACPI_SUCCESS(status))
> +		kfree(data);
> +
> +	acpi_bus_detach_private_data(handle);
> +}
> +#endif
> +#endif /* CONFIG_ACPI */
> +
>  /* -----------------------------------------------------------------=
-------- */
> =20
>  static const struct i2c_device_id *i2c_match_id(const struct i2c_dev=
ice_id *id,
>=20


--=20
Best regards
Tianyu Lan
