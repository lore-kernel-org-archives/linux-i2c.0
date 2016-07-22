From: Jan Kandziora <jjj@gmx.de>
Subject: Re: [PATCH 2/2] add w1_ds28e17 driver for the DS28E17 Onewire to I2C
 master bridge
Date: Fri, 22 Jul 2016 22:52:18 +0200
Message-ID: <57928782.1040101@gmx.de>
References: <578A95E4.1080903@gmx.de> <20160721070220.GE1664@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:59932 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbcGVUwX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 22 Jul 2016 16:52:23 -0400
In-Reply-To: <20160721070220.GE1664@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Evgeniy Polyakov <zbr@ioremap.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 21.07.2016 um 09:02 schrieb Wolfram Sang:
>> + +	  In addition, that new I2C bus is accessible from userspace
>> through +	  a /dev/i2c-nnn device node if you have enabled +
>> "Device Drivers->I2C Support->I2C device interface"
>> (CONFIG_I2C_CHARDEV).
> 
> I think the last paragraph can go. This is standard I2C behaviour
> and Kconfig is not the right place to document this.
> 
I changed the first paragraph, too "to be used by the kernel and
userspace tools".


>> + +#include <linux/kernel.h> +#include <linux/module.h> +#include
>> <linux/moduleparam.h> +#include <linux/device.h> +#include
>> <linux/types.h> +#include <linux/delay.h> +#include
>> <linux/slab.h> +#include <linux/crc16.h> +#include
>> <linux/uaccess.h> +#include <linux/i2c.h>
> 
> If you sort these, it is easier to avoid duplicates later.
> 
Done.


>> + +#define CRC16_INIT 0 + +#include "../w1.h" +#include
>> "../w1_int.h" +#include "../w1_family.h" + + +/* Module setup.
>> */ +MODULE_LICENSE("GPL");
> 
> "GPL v2"
> 
Done.


>> +MODULE_AUTHOR("Jan Kandziora <jjj@gmx.de>"); 
>> +MODULE_DESCRIPTION("w1 family 19 driver for DS28E17, 1-wire to
>> I2C master bridge"); +MODULE_ALIAS("w1-family-"
>> __stringify(W1_FAMILY_DS28E17)); + + +/* Default I2C speed to be
>> set when a DS28E17 is detected. */ +static char i2c_speed = 1; 
>> +module_param_named(speed, i2c_speed, byte, (S_IRUSR |
>> S_IWUSR)); +MODULE_PARM_DESC(speed, "Default I2C speed to be set
>> when a DS28E17 is detected");
> 
> I don't see any documentation what 0,1,2 means. I think it would be
> more user friendly to actually use the kHz values here.
> 
Okay.


> 
>> +/* Default I2C stretch value to be set when a DS28E17 is
>> detected. */ +static char i2c_stretch = 1; 
>> +module_param_named(stretch, i2c_stretch, byte, (S_IRUSR |
>> S_IWUSR)); +MODULE_PARM_DESC(stretch, "Default I2C stretch value
>> to be set when a DS28E17 is detected");
> 
> No documentation what the value means.
> 
In which file(s) should I document it?


>> +	if (w1_buf[0] & W1_F19_STATUS_ADDRESS) +		dev_warn(&sl->dev,
>> "i2c device not responding\n");
> 
> This should ideally return -ENXIO.
> 
Done.


>> +	if (w1_buf[0] & W1_F19_STATUS_START) +		dev_warn(&sl->dev, "i2c
>> start condition invalid\n");
> 
> Does that mean "arbitration lost"? Then it should return
> "-EAGAIN".
> 
The DS28E17 datasheet says nothing about it but 0="start" and
1="invalid start", page 23.

I think you are right, this has to be arbitration lost. EAGAIN and no
warning message then.


>> + +	/* Check input. */ +	if (i2c_address > 0x7F
> 
> The i2c core checks that for you.
> 
Done.


>> +			|| count == 0)
> 
> For that case, better return -EOPNOTSUPP;
> 
Done.



>> + +		/* Resume to same DS28E17. */ +		if
>> (w1_reset_resume_command(sl->master)) +			return -ENXIO;
> 
> -ENXIO? Please check Documentation/i2c/fault-codes if that fits
> 



>> + +	/* Check input. */ +	if (i2c_address > 0x7F +			|| count >
>> W1_F19_READ_DATA_LIMIT
> 
> Since you have a quirk structure, the core checks this for you,
> too.
> 
Okay, removed.


>> +			|| count == 0) +		return -EINVAL;
> 
> -EOPNOTSUPP.
> 
Done.


>> +	/* Warnings. */ +	if (w1_buf[0] & W1_F19_STATUS_CRC) +
>> dev_warn(&sl->dev, "crc16 mismatch\n"); +	if (w1_buf[0] &
>> W1_F19_STATUS_ADDRESS) +		dev_warn(&sl->dev, "i2c device not
>> responding\n"); +	if (w1_buf[0] & W1_F19_STATUS_START) +
>> dev_warn(&sl->dev, "i2c start condition invalid\n");
> 
> Same as above.
> 
Done.


>> + +	/* Check input. */ +	if (i2c_address > 0x7F +			|| wcount ==
>> 0 +			|| rcount > W1_F19_READ_DATA_LIMIT +			|| rcount == 0) +
>> return -EINVAL;
> 
> Same comments as above
> 
Done.


>> + +	/* Warnings. */ +	if (w1_buf[0] & W1_F19_STATUS_CRC) +
>> dev_warn(&sl->dev, "crc16 mismatch\n"); +	if (w1_buf[0] &
>> W1_F19_STATUS_ADDRESS) +		dev_warn(&sl->dev, "i2c device not
>> responding\n"); +	if (w1_buf[0] & W1_F19_STATUS_START) +
>> dev_warn(&sl->dev, "i2c start condition invalid\n"); +	if
>> ((w1_buf[0] & (W1_F19_STATUS_CRC | W1_F19_STATUS_ADDRESS)) == 0 +
>> && w1_buf[1] != 0) { +		dev_warn(&sl->dev, "i2c short write, %d
>> bytes not acknowledged\n", +			w1_buf[1]); +	} + +	/* Check error
>> conditions. */ +	if (w1_buf[0] != 0 || w1_buf[1] != 0) +		return
>> -EIO;
> 
> ditto. Maybe you should put this parsing into a seperate function?
> 
Done: w1_f19_error().


>> + +	/* Read received I2C data from DS28E17. */ +	return
>> w1_read_block(sl->master, rbuffer, rcount); +} + + +/* Do an I2C
>> master transfer. */ +static int w1_f19_i2c_master_transfer(struct
>> i2c_adapter *adapter, +	struct i2c_msg *msgs, int num) +{ +
>> struct w1_slave *sl = (struct w1_slave *) adapter->algo_data; +
>> int i = 0; +	int result = 0; + +	/* Return if no messages to
>> send/receive. */ +	if (num == 0) +		return 0;
> 
> Heh, I was about to write "the core will check this for you", but
> it doesn't. I'll send a patch to fix that, thanks! So please remove
> it here.
> 
You're welcome. And done.



>> + +/* I2C algorithm. */ +static const struct i2c_algorithm
>> w1_f19_i2c_algorithm = { +	.master_xfer    =
>> w1_f19_i2c_master_transfer, +	.smbus_xfer     = NULL,
> 
> Not needed.
> 
Done.


>> +	.functionality  = w1_f19_i2c_functionality,
> 
> You could add the quirks struct here since it is static.
> 
Done.


>> + +/* All attributes. */ +static struct attribute *w1_f19_attrs[]
>> = { +	&dev_attr_speed.attr, +	&dev_attr_stretch.attr, +	NULL, 
>> +}; + +static const struct attribute_group w1_f19_group = { +
>> .attrs		= w1_f19_attrs, +}; + +static const struct
>> attribute_group *w1_f19_groups[] = { +	&w1_f19_group, +	NULL, 
>> +};
> 
> sysfs files need documentation in Documentation/ABI/testing/.
> 
Ah, okay. Will add that.


>> + + +/* Slave add and remove functions. */ +static int
>> w1_f19_add_slave(struct w1_slave *sl) +{ +	struct w1_f19_data
>> *data = NULL; + +	/* Allocate memory for slave specific data. */ 
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> 
> I don't know w1 much. Isn't there a device so we could use
> devm_kzalloc?
> 
Evgeniy?


>> +	if (!data) +		return -ENOMEM; +	sl->family_data = data; + +	/*
>> Setup default I2C speed on slave. */ +	if (i2c_speed == 0 ||
>> i2c_speed == 1 || i2c_speed == 2) { +		__w1_f19_set_i2c_speed(sl,
>> i2c_speed); +	}	else { +		/* +		 * A module parameter of anything
>> else than 0, 1, 2 +		 * means not to touch the speed of the
>> DS28E17. +		 * We assume 400kBaud. +		 */
> 
> I suggest to to use 100kHz as the default. That's what all devices
> have to support. 400kHz is common, but still optional.
> 
Okay.


>> +		data->speed = 1; +	} + +	/* +	 * Setup default busy stretch +
>> * configuration for the DS28E17. +	 */ +	data->stretch =
>> i2c_stretch; + +	/* Setup I2C adapter. */ +	data->adapter.owner
>> = THIS_MODULE; +	data->adapter.class      = 0;
> 
> Not needed with kzalloc.
> 
Okay.


>> +	data->adapter.algo       = &w1_f19_i2c_algorithm; +
>> data->adapter.alogo_data  = (void *) sl;
> 
> No need to cast to void*.
> 
Ah.


>> +	strcpy(data->adapter.name, "w1-"); +	strcat(data->adapter.name,
>> sl->name); +	data->adapter.dev.parent = &sl->dev; +
>> data->adapter.quirks     = &w1_f19_i2c_adapter_quirks; + +	return
>> i2c_add_adapter(&data->adapter); +} + +static void
>> w1_f19_remove_slave(struct w1_slave *sl) +{ +	/* Delete I2C
>> adapter. */ +	i2c_del_adapter(&(((struct w1_f19_data
>> *)(sl->family_data))->adapter));
> 
> Would be more readable if you'd use a 'family_data' variable as an 
> intermediate step.
> 
Done.


>> + +	/* Free slave specific data. */ +	kfree(sl->family_data); +
>> sl->family_data = NULL; +} + + +/* Declarations within the w1
>> subsystem. */ +static struct w1_family_ops w1_f19_fops = { +
>> .add_slave = w1_f19_add_slave, +	.remove_slave =
>> w1_f19_remove_slave, +	.groups = w1_f19_groups, +}; + +static
>> struct w1_family w1_family_19 = { +	.fid = W1_FAMILY_DS28E17, +
>> .fops = &w1_f19_fops, +}; + + +/* Module init and remove
>> functions. */ +static int __init w1_f19_init(void) +{ +	return
>> w1_register_family(&w1_family_19); +} + +static void __exit
>> w1_f19_fini(void) +{ +	w1_unregister_family(&w1_family_19); +} + 
>> +module_init(w1_f19_init); +module_exit(w1_f19_fini);
> 
> use the 'module_driver' macro?
> 
To be honest, the examples of the __driver argument I found in the few
other drivers which use that macro made me shy away.

It's like doing the taxes. Forms and more forms to fill out...

I would use it if someone tells me what to fill in there.

Kind regards

	Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAleSh38ACgkQzGZqmZvWQdnQ5wCeO7Wv9VcA4fK/2F7hX7t2BC9X
8EIAnAwUCI5uka3EzE9HhGkwZHHgdQjF
=AwYi
-----END PGP SIGNATURE-----
