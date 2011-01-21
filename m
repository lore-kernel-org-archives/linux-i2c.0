From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 2/2] MAX8997/8966 PMIC Regulator Driver Initial Release
Date: Fri, 21 Jan 2011 19:16:04 +0000
Message-ID: <20110121191604.GK22414@opensource.wolfsonmicro.com>
References: <1294988018-25100-1-git-send-email-myungjoo.ham@samsung.com>
 <1294988018-25100-3-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1294988018-25100-3-git-send-email-myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 14, 2011 at 03:53:38PM +0900, MyungJoo Ham wrote:
> This patch supports PMIC/Regulator part of MAX8997/MAX8966 MFD.
> In this initial release, selecting voltages or current-limit
> and switching on/off the regulators are supported.

Mostly good, a few stylistic things and this is out of date for the
current regulator API.

> +static int max8997_get_voltage(struct regulator_dev *rdev)
> +{

> +	ret = max8997_list_voltage(rdev, val);
> +	if (ret == -EINVAL) {
> +		int ldo = max8997_get_ldo(rdev);

It'd probably be easier to just define separate get_voltage() and
list_voltage() functions for these regulators.

> +static int max8997_set_voltage_ldo(struct regulator_dev *rdev,
> +               int min_uV, int max_uV)

This needs updating for the current API in -next (and 2.6.38).

> +	if ((ldo > MAX8997_BUCK7 || ldo < MAX8997_LDO1) &&
> +			ldo != MAX8997_CHARGER_CV &&
> +			ldo != MAX8997_CHARGER &&
> +			ldo != MAX8997_CHARGER_TOPOFF)
> +		return -EINVAL;
> +	if (ldo == MAX8997_BUCK6)
> +		return -EINVAL;

A switch statement for the valid regulators might be clearer.

> +static int max8997_set_voltage_buck(struct regulator_dev *rdev,
> +		int min_uV, int max_uV)

API update needed here too.

> +static int max8997_set_voltage_safeout(struct regulator_dev *rdev,
> +		int min_uV, int max_uV)
> +{

Here also.  Given that you've got a separate set_voltage() the comment
about a separate get_voltage() above seems even stronger.

> +static inline unsigned int max8997_buck_voltage(int uV)
> +{
> +	int step;
> +
> +	if (uV <= 650000)
> +		return 0x0;
> +	if (uV >= 2225000)
> +		return 0x3f;
> +
> +	step = uV - 650000;
> +	step /= 25000;
> +
> +	return step + 1;
> +}

Shouldn't this code be shared with set_voltage()?  Or...

> +		max8997_update_reg(i2c, MAX8997_REG_BUCK1DVS(i),
> +				max8997_buck_voltage(pdata->buck1_voltage[i]),
> +				0x3f);
> +		max8997_update_reg(i2c, MAX8997_REG_BUCK2DVS(i),
> +				max8997_buck_voltage(pdata->buck2_voltage[i]),
> +				0x3f);
> +		max8997_update_reg(i2c, MAX8997_REG_BUCK5DVS(i),
> +				max8997_buck_voltage(pdata->buck5_voltage[i]),
> +				0x3f);

...just call your set_voltage() operation directly for these?

> +		if (gpio_is_valid(pdata->buck125_gpios[0]) &&
> +				gpio_is_valid(pdata->buck125_gpios[1]) &&
> +				gpio_is_valid(pdata->buck125_gpios[2])) {

Strange indentation here.
