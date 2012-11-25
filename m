From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 2/2] i2c/designware: Provide i2c bus recovery support
Date: Sun, 25 Nov 2012 09:41:46 +0530
Message-ID: <CAKohpokdx91dkK3vBsjBMtc9iHypM_ZK2oJm5vcjkdiT-eW7vQ@mail.gmail.com>
References: <9adb13c1a2e35dce401b0a50e455fe1be76285a7.1349348405.git.viresh.kumar@linaro.org>
	<6262d3a8e87858d938362c4aa44caf40938f2be9.1349348405.git.viresh.kumar@linaro.org>
	<20121124210314.GC3210@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121124210314.GC3210-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 25 November 2012 02:33, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c

>> @@ -538,7 +538,12 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>>       ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete, HZ);
>>       if (ret == 0) {
>>               dev_err(dev->dev, "controller timed out\n");
>> -             i2c_dw_init(dev);
>> +             if (adap->bus_recovery_info &&
>> +                             adap->bus_recovery_info->recover_bus) {
>> +                     dev_dbg(dev->dev, "try i2c bus recovery\n");
>> +                     adap->bus_recovery_info->recover_bus(adap);
>> +             }
>> +
>
> This should be in the core?

Because wait_for_completion() would fail in controllers, so i kept this
code here. How will we come to know about xfer failure in core?

Though i realize that check for adap->bus_recovery_info->recover_bus()
is just not required.

>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
>> +     /* Bus recovery support */
>> +     pdata = dev_get_platdata(&pdev->dev);
>> +     if (pdata) {
>> +             recovery_info = kzalloc(sizeof(*recovery_info), GFP_KERNEL);
>> +             if (!recovery_info) {
>> +                     adap->bus_recovery_info = NULL;
>> +                     dev_err(&pdev->dev,
>> +                             "failure to allocate memory for bus recovery\n");
>> +                     goto skip_recovery;
>> +             }
>> +
>> +             recovery_info->is_gpio_recovery = true;
>> +             recovery_info->get_gpio = pdata->get_gpio;
>> +             recovery_info->put_gpio = pdata->put_gpio;
>> +             recovery_info->scl_gpio = pdata->scl_gpio;
>> +             recovery_info->scl_gpio_flags = pdata->scl_gpio_flags;
>> +             recovery_info->clock_rate_khz = clk_get_rate(dev->clk) / 1000;
>
> It is probably easier to define the whole bri structure in the platform
> and simply pass it on here? Hmm, now devicetree also comes to my mind.
> Will think about that a little, too, but main implementation should be
> left for someone needing that.

Ok. I didn't went for DT as recovery_info also has some routines, for which
we need special implementation for platforms.

--
viresh
