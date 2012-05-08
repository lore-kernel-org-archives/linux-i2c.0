From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 14/15] drivers/regulators: Enable the ab8500 for Device
 Tree
Date: Tue, 08 May 2012 13:04:49 +0100
Message-ID: <4FA90BE1.3050304@linaro.org>
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

On 07/05/12 18:08, Mark Brown wrote:
> On Fri, May 04, 2012 at 07:23:24PM +0100, Lee Jones wrote:
>
> Once again, please try to make sure your changelog matches the
> subsystem.  This also isn't consistent with the other regulator chang=
e
> further up the series :(
>
> You've also not included any binding documenation here, binding
> documentation should be included for new bindings.
>
>>
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

of_regulator_match() didn't exist when I wrote this. In fact, it only=20
made it into -next a couple of days ago. Besides, it doesn't satisfy th=
e=20
needs of this code segment. of_regulator_match() is a(nother) wrapper=20
around of_get_regulation_constraints(), which is only used to populate=20
'struct regulation_constraints constraints' after being provided with a=
=20
selection of .compatible strings.

I'd be happy to use an API for what this is trying to achieve, however=20
there aren't any as far as I know.

>> +	/* Register each ab8500 regulator found in the Device Tree. */
>> +	for_each_child_of_node(np, child) {
>> +		ab8500_regulator =3D of_get_regulator_init_data(&pdev->dev, child=
);
>
> Definitely don't do this - you should unconditionally register all th=
e
> regulators that physically exist, this allows users to inspect their
> state even if they aren't used.

No problem. Thanks for the information. I'll change that and re-submit.

> It's possible the original driver has this bug (I didn't check but
>
>> +		if (strcmp(ab8500_regulator->constraints.name, "dummy"))
>> +			ab8500_regulator_register(pdev, ab8500_regulator, id, child);
>
> This is really broken - the whole purpose of allowing users to specif=
y a
> name in the constraints is to allow them to assign a name that's
> meaningful for their board so they can tie the software in with the
> schematic which we will display in diagnostics.  Forcing them to spec=
ify
> magic strings as the supply name defeats this and makes diagnostics f=
rom
> the kernel more obscure.

Noted. I'll have that changed to. Thanks.

>>   	pdata =3D dev_get_platdata(ab8500->dev);
>> -	if (!pdata) {
>> -		dev_err(&pdev->dev, "null pdata\n");
>> +	if (!pdata&&  !np) {
>> +		dev_err(&pdev->dev, "null pdata and no device tree found\n");
>>   		return -EINVAL;
>>   	}
>
> Neither should be mandatory.

Okay.

Thanks for the review Mark. I'll get it fixed up and supply early next =
week.

Kind regards,
Lee

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
