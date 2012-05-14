From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Mon, 14 May 2012 16:49:21 +0100
Message-ID: <4FB12981.8050603@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org> <1336155805-18554-15-git-send-email-lee.jones@linaro.org> <20120507170832.GO17002@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120507170832.GO17002-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Mark,

Looking at this now.

>> +static __devinit int
>> +ab8500_regulator_of_probe(struct platform_device *pdev, struct devi=
ce_node *np)
>> +{
>> +	struct regulator_init_data *ab8500_regulator;
>> +	struct device_node *child;
>> +	int err, value, i, id =3D 0;
>> +
>> +	/* Initialise regulator registers to platform specific values. */
>> +	for (i =3D 0; i<  ARRAY_SIZE(ab8500_reg_init); i++) {
>> +		err =3D of_property_read_u32(np, ab8500_reg_init[i].of_name,&valu=
e);
>> +		if (err<  0)
>> +			return err;
>> +
>> +		err =3D ab8500_regulator_init_registers(pdev, i, value);
>> +		if (err<  0)
>> +			return err;
>
> You should be using of_regulator_match() for this (I think it's suppo=
sed
> to do an equivalent job...) rather than open coding.

I've ripped this out completely and the code appears to continue be=20
fully functional. Happy days! :)

>> +	/* Register each ab8500 regulator found in the Device Tree. */
>> +	for_each_child_of_node(np, child) {
>> +		ab8500_regulator =3D of_get_regulator_init_data(&pdev->dev, child=
);
>
> Definitely don't do this - you should unconditionally register all th=
e
> regulators that physically exist, this allows users to inspect their
> state even if they aren't used.
>
> It's possible the original driver has this bug (I didn't check but

The original driver places each of the registers inside a structure=20
within the driver itself and recursively registers them from there. The=
=20
constraints are united with the correct element using #defines.

Can't we just assume that all of the regulators will be put into the=20
Device Tree? As this is what I'll be doing.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
