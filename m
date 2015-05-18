From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH] i2c: eeprom: at24: Provide an EEPROM framework interface
Date: Mon, 18 May 2015 11:23:35 +0300
Message-ID: <11E4087A-B7EF-4C4B-95FD-25D96A12AB31@antoniou-consulting.com>
References: <1431502697-31333-1-git-send-email-pantelis.antoniou@konsulko.com> <20150513203646.GI4004@lukather> <C6F869D3-F558-4DCA-A551-55054BD59B39@antoniou-consulting.com> <20150515141909.GX4004@lukather>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150515141909.GX4004@lukather>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Matt Porter <mporter@konsulko.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-i2c@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Maxime,

> On May 15, 2015, at 17:19 , Maxime Ripard <maxime.ripard@free-electro=
ns.com> wrote:
>=20
> On Thu, May 14, 2015 at 09:06:23AM +0300, Pantelis Antoniou wrote:
>>=20
>>> On May 13, 2015, at 23:36 , Maxime Ripard <maxime.ripard@free-elect=
rons.com> wrote:
>>>=20
>>> Hi Pantelis,
>>>=20
>>> On Wed, May 13, 2015 at 10:38:17AM +0300, Pantelis Antoniou wrote:
>>>> For DT and in-kernel users there is no interface to the
>>>> at24 EEPROMs so provide an EEPROM framework interface.
>>>>=20
>>>> This allows us to use AT24 based EEPROMs and reference them
>>>> from within the DT tree.
>>>>=20
>>>> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
>>>=20
>>> You should probably mention that the EEPROM framework hasn't been
>>> merged yet.
>>>=20
>>=20
>> Well, that=E2=80=99s true. But it=E2=80=99s on version 4 and it does=
 do what I need it
>> to do, namely provide a DT interface for in-kernel users.
>=20
> I was just meaning that people not aware of the fact that the
> framework was not merged might apply it, and that would result in an
> instant breakage, that's all.
>=20
> It's actually pretty nice that you convert this driver over to the
> EEPROM framework.
>=20

Thanks. It=E2=80=99s really broadly used and the framework works fine.


>>=20
>>>> ---
>>>> drivers/misc/eeprom/at24.c | 222 +++++++++++++++++++++++++++++++++=
++----------
>>>> 1 file changed, 174 insertions(+), 48 deletions(-)
>>>>=20
>>>> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24=
=2Ec
>>>> index 2d3db81..afa719a 100644
>>>> --- a/drivers/misc/eeprom/at24.c
>>>> +++ b/drivers/misc/eeprom/at24.c
>>>> @@ -3,6 +3,7 @@
>>>> *
>>>> * Copyright (C) 2005-2007 David Brownell
>>>> * Copyright (C) 2008 Wolfram Sang, Pengutronix
>>>> + * Copyright (C) 2015 Pantelis Antoniou, Konsulko Group
>>>> *
>>>> * This program is free software; you can redistribute it and/or mo=
dify
>>>> * it under the terms of the GNU General Public License as publishe=
d by
>>>> @@ -23,6 +24,9 @@
>>>> #include <linux/of.h>
>>>> #include <linux/i2c.h>
>>>> #include <linux/platform_data/at24.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/eeprom-provider.h>
>>>> +#include <linux/io.h>
>>>>=20
>>>> /*
>>>> * I2C EEPROMs from most vendors are inexpensive and mostly interch=
angeable.
>>>> @@ -63,12 +67,16 @@ struct at24_data {
>>>> 	 * but not from changes by other I2C masters.
>>>> 	 */
>>>> 	struct mutex lock;
>>>> -	struct bin_attribute bin;
>>>>=20
>>>> 	u8 *writebuf;
>>>> 	unsigned write_max;
>>>> 	unsigned num_addresses;
>>>>=20
>>>> +	struct regmap_config *regmap_config;
>>>> +	struct regmap *regmap;
>>>> +	struct eeprom_config *eeprom_config;
>>>> +	struct eeprom_device *eeprom_dev;
>>>> +
>>>> 	/*
>>>> 	 * Some chips tie up multiple I2C addresses; dummy devices reserv=
e
>>>> 	 * them for us, and we'll use them with SMBus calls.
>>>> @@ -131,6 +139,8 @@ static const struct i2c_device_id at24_ids[] =3D=
 {
>>>> };
>>>> MODULE_DEVICE_TABLE(i2c, at24_ids);
>>>>=20
>>>> +static DEFINE_IDA(at24_ida);
>>>> +
>>>> /*----------------------------------------------------------------=
---------*/
>>>>=20
>>>> /*
>>>> @@ -301,17 +311,6 @@ static ssize_t at24_read(struct at24_data *at=
24,
>>>> 	return retval;
>>>> }
>>>>=20
>>>> -static ssize_t at24_bin_read(struct file *filp, struct kobject *k=
obj,
>>>> -		struct bin_attribute *attr,
>>>> -		char *buf, loff_t off, size_t count)
>>>> -{
>>>> -	struct at24_data *at24;
>>>> -
>>>> -	at24 =3D dev_get_drvdata(container_of(kobj, struct device, kobj)=
);
>>>> -	return at24_read(at24, buf, off, count);
>>>> -}
>>>> -
>>>> -
>>>> /*
>>>> * Note that if the hardware write-protect pin is pulled high, the =
whole
>>>> * chip is normally write protected. But there are plenty of produc=
t
>>>> @@ -432,21 +431,10 @@ static ssize_t at24_write(struct at24_data *=
at24, const char *buf, loff_t off,
>>>> 	return retval;
>>>> }
>>>>=20
>>>> -static ssize_t at24_bin_write(struct file *filp, struct kobject *=
kobj,
>>>> -		struct bin_attribute *attr,
>>>> -		char *buf, loff_t off, size_t count)
>>>> -{
>>>> -	struct at24_data *at24;
>>>> -
>>>> -	if (unlikely(off >=3D attr->size))
>>>> -		return -EFBIG;
>>>> -
>>>> -	at24 =3D dev_get_drvdata(container_of(kobj, struct device, kobj)=
);
>>>> -	return at24_write(at24, buf, off, count);
>>>> -}
>>>> -
>>>> /*----------------------------------------------------------------=
---------*/
>>>>=20
>>>> +/* panto: using the EEPROM framework macc is superfluous */
>>>> +
>>>=20
>>> Is it? it was kind of one of the point to be able to remove the mem=
ory
>>> accessors stuff (which is only used by that driver btw).
>>=20
>> Yes it completely redundant now. But it=E2=80=99s not my call to rem=
ove it, that would
>> be Wolfram.
>=20
> There's still a user of that stuff though, some davinci board iirc,
> that would need to port that user to the EEPROM framework too.
>=20
>>>> /*
>>>> * This lets other kernel code access the eeprom data. For example,=
 it
>>>> * might hold a board's Ethernet address, or board-specific calibra=
tion
>>>> @@ -492,6 +480,91 @@ static void at24_get_ofdata(struct i2c_client=
 *client,
>>>> { }
>>>> #endif /* CONFIG_OF */
>>>>=20
>>>> +static int regmap_at24_read(void *context,
>>>> +			    const void *reg, size_t reg_size,
>>>> +			    void *val, size_t val_size)
>>>> +{
>>>> +	struct i2c_client *client =3D context;
>>>> +	struct at24_data *at24;
>>>> +	unsigned int offset;
>>>> +	int ret;
>>>> +
>>>> +	/* reg bits is hardcoded to 32 bits */
>>>> +	BUG_ON(reg_size !=3D 4);
>>>> +	offset =3D __raw_readl(reg);
>>>> +
>>>> +	at24 =3D i2c_get_clientdata(client);
>>>> +	if (at24 =3D=3D NULL)
>>>> +		return -ENODEV;
>>>> +
>>>> +	/* val bytes is always 1 */
>>>> +	BUG_ON(at24->regmap_config->val_bits !=3D 8);
>>>> +
>>>> +	ret =3D at24_read(at24, val, offset, val_size);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +	if (ret !=3D val_size)
>>>> +		return -EINVAL;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int regmap_at24_gather_write(void *context,
>>>> +				    const void *reg, size_t reg_size,
>>>> +				    const void *val, size_t val_size)
>>>> +{
>>>> +	struct i2c_client *client =3D context;
>>>> +	struct at24_data *at24;
>>>> +	unsigned int offset;
>>>> +	int ret;
>>>> +
>>>> +	at24 =3D i2c_get_clientdata(client);
>>>> +	if (at24 =3D=3D NULL)
>>>> +		return -ENODEV;
>>>> +
>>>> +	BUG_ON(reg_size !=3D 4);
>>>> +	offset =3D __raw_readl(reg);
>>>> +
>>>> +	/* val bytes is always 1 */
>>>> +	BUG_ON(at24->regmap_config->val_bits !=3D 8);
>>>> +
>>>> +	ret =3D at24_write(at24, val, offset, val_size);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +	if (ret !=3D val_size)
>>>> +		return -EINVAL;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int regmap_at24_write(void *context, const void *data, siz=
e_t count)
>>>> +{
>>>> +	struct i2c_client *client =3D context;
>>>> +	struct at24_data *at24;
>>>> +	unsigned int reg_bytes, offset;
>>>> +
>>>> +	at24 =3D i2c_get_clientdata(client);
>>>> +	if (at24 =3D=3D NULL)
>>>> +		return -ENODEV;
>>>> +
>>>> +	reg_bytes =3D at24->regmap_config->reg_bits / 8;
>>>> +	offset =3D reg_bytes;
>>>> +
>>>> +	BUG_ON(reg_bytes !=3D 4);
>>>> +	BUG_ON(count <=3D offset);
>>>> +
>>>> +	return regmap_at24_gather_write(context, data, reg_bytes,
>>>> +			data + offset, count - offset);
>>>> +}
>>>> +
>>>> +static struct regmap_bus regmap_at24_bus =3D {
>>>> +	.read =3D regmap_at24_read,
>>>> +	.write =3D regmap_at24_write,
>>>> +	.gather_write =3D regmap_at24_gather_write,
>>>> +	.reg_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
>>>> +	.val_format_endian_default =3D REGMAP_ENDIAN_NATIVE,
>>>=20
>>> I wouldn't expect the content of the EEPROM to change of endianness
>>> when we change the kernel=E2=80=99s
>>=20
>> It doesn=E2=80=99t matter really; these EEPROMs are byte accessible,=
 and the register
>> values are completely internal to the driver.
>=20
> Ah, right. My bad :)
>=20

No worries :)

> Maxime
>=20
> --=20
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

Regards

=E2=80=94 Pantelis
