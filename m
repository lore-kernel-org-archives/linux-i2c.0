From: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
Subject: Re: [PATCH v5] i2c-gpio: add devicetree support
Date: Wed, 23 Feb 2011 21:18:15 +0800
Message-ID: <4D650917.8000201@wytron.com.tw>
References: <1297304967-3759-1-git-send-email-thomas@wytron.com.tw> <1297650610-12400-1-git-send-email-thomas@wytron.com.tw> <20110223011232.GC15795@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110223011232.GC15795-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nios2-dev-1eJk0qcHJCcaeqlQEoCUNoJY59XmG8rH@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On 02/23/2011 09:12 AM, Ben Dooks wrote:
> On Mon, Feb 14, 2011 at 10:30:10AM +0800, Thomas Chou wrote:
>> From: Albert Herranz<albert_herranz-mRCrAkd8dF0@public.gmane.org>
>>
>> This patch adds devicetree support to i2c-gpio driver. The allocation
>> of local data is integrated to a private structure, and use devm_*
>> helper for easy cleanup.
>>
>> It is base on an earlier patch for gc-linux from
>> Albert Herranz<albert_herranz-mRCrAkd8dF0@public.gmane.org>.
>>
>> Signed-off-by: Thomas Chou<thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>
>> CC: Albert Herranz<albert_herranz-mRCrAkd8dF0@public.gmane.org>
>> Acked-by: Haavard Skinnemoen<hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>> for v2.6.39
>> v2 move of nodes probing to a hook, which will be optimized out
>>       when devicetree is not used.
>>     use linux/gpio.h.
>>     move binding doc to i2c/i2c-gpio.txt.
>> v3 use speed-hz instead of udelay in dts binding.
>>     condition the devicetree probe.
>> v4 simplify private allocation.
>> v5 condition module device table export for of.
>>

>> +/* Check if devicetree nodes exist and build platform data */
>> +static int i2c_gpio_of_probe(struct platform_device *pdev,
>> +			     struct i2c_gpio_platform_data *pdata)
>> +{
>> +	struct device_node *np = pdev->dev.of_node;
>> +	const __be32 *prop;
>> +	int sda_pin, scl_pin;
>> +	int len;
>> +
>> +	if (!np || of_gpio_count(np)<  2)
>> +		return -ENXIO;
>
> Would prefer to see different return code, most bus probe functions
> tend to drop these without signalling to the user as they assume the
> device was either never there or totally faulty.
>
>> +	sda_pin = of_get_gpio_flags(np, 0, NULL);
>> +	scl_pin = of_get_gpio_flags(np, 1, NULL);
>> +	if (sda_pin<  0 || scl_pin<  0) {
>> +		pr_err("%s: invalid GPIO pins, sda=%d/scl=%d\n",
>> +		       np->full_name, sda_pin, scl_pin);
>> +		return -ENXIO;
>> +	}
>
> see same as above.
>
>> +	pdata->sda_pin = sda_pin;
>> +	pdata->scl_pin = scl_pin;
>> +	prop = of_get_property(np, "sda-is-open-drain", NULL);
>> +	if (prop)
>> +		pdata->sda_is_open_drain = 1;
>> +	prop = of_get_property(np, "scl-is-open-drain", NULL);
>> +	if (prop)
>> +		pdata->scl_is_open_drain = 1;
>> +	prop = of_get_property(np, "scl-is-output-only", NULL);
>> +	if (prop)
>> +		pdata->scl_is_output_only = 1;
>> +	prop = of_get_property(np, "speed-hz",&len);
>> +	if (prop&&  len>= sizeof(__be32))
>> +		pdata->udelay = DIV_ROUND_UP(1000000, be32_to_cpup(prop) * 2);
>> +	prop = of_get_property(np, "timeout",&len);
>> +	if (prop&&  len>= sizeof(__be32))
>> +		pdata->timeout = msecs_to_jiffies(be32_to_cpup(prop));
>> +
>> +	return 0;
>> +}
>> +#else
>> +static int i2c_gpio_of_probe(struct platform_device *pdev,
>> +			     struct i2c_gpio_platform_data *pdata)
>> +{
>> +	return -ENXIO;
>> +}
>
> might be valid here, however can we make this NULL if no support?
>

Thanks. How about return NULL if no support, and return pdata if support?

- Thomas
