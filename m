From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 2/2] i2c/designware: Provide i2c bus recovery support
Date: Thu, 24 Jan 2013 13:25:14 +0530
Message-ID: <CAKohponfeee+fof4fQ7CH5OYsSSBXOfV3h4GspF1F6Ncz9NnAA@mail.gmail.com>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
	<7f319334237d8cfad4e6d29499d7424c3e739608.1354502924.git.viresh.kumar@linaro.org>
	<20130124072456.GB8364@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130124072456.GB8364-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org, Vincenzo Frascino <vincenzo.frascino-qxv4g6HH51o@public.gmane.org>, Shiraz Hashim <shiraz.hashim-qxv4g6HH51o@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 24 January 2013 12:54, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> On Mon, Dec 03, 2012 at 08:24:05AM +0530, Viresh Kumar wrote:
>> @@ -538,7 +538,11 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>>       ret = wait_for_completion_interruptible_timeout(&dev->cmd_complete, HZ);
>>       if (ret == 0) {
>>               dev_err(dev->dev, "controller timed out\n");
>> -             i2c_dw_init(dev);
>> +             if (adap->bus_recovery_info) {
>> +                     dev_dbg(dev->dev, "try i2c bus recovery\n");
>> +                     adap->bus_recovery_info->recover_bus(adap);
>> +             }
>> +
>
> I think we need something like i2c_recover_bus in the core which does
> the above and also returns the return code from recover_bus. If there is
> no recover_bus it should return EOPNOTSUPP.
>
> Then the driver can do
>
>         ret = i2c_recover_bus(adap);
>         if (ret < 0)
>                 i2c_dw_init();
>
> If not calling i2c_dw_init, you will probably cause a regression.

Fair enough.

>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
>> +err_free_recovery_info:
>> +     kfree(recovery_info);

Leftover of earlier versions, my mistake :(
