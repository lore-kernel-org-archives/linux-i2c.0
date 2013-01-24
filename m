From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Thu, 24 Jan 2013 14:17:55 +0530
Message-ID: <CAKohpo=HhdsVRqzGN87yUSz3rEn-3MHEh3rM0-XJJgcX19kXUg@mail.gmail.com>
References: <547205b4f54e6b48746efc7c22ccc0a59bd9b659.1354502924.git.viresh.kumar@linaro.org>
	<20130124072445.GA8364@nekote.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130124072445.GA8364-8EAEigeeuNG034pCzgS/Qg7AFbiQbgqx@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 24 January 2013 12:54, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> Hi Viresh,

Hi Wolfram

> I think we are getting close.

Wow!!

> On Mon, Dec 03, 2012 at 08:24:04AM +0530, Viresh Kumar wrote:
>> This doesn't support multi-master recovery for now.
>
> Assuming that recover_bus is not called on BUS_BUSY but on TIMEOUTs,,
> this should work?

@Uwe/Paul: ??

>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>> +/* 10^6/KHz for delay in ns */
>> +unsigned long clk_delay = DIV_ROUND_UP(1000000, DEFAULT_CLK_RATE * 2);
>
> no global variable. should go into the function needing it.

I kept it to make sure we don't do this calculation every time... I would like
to keep it for better performance..

>> +static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
>> +{
>> +     struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
>> +     struct device *dev = &adap->dev;
>> +     int ret = 0;
>> +
>> +     ret = gpio_request_one(bri->scl_gpio, GPIOF_OPEN_DRAIN |
>> +                     GPIOF_OUT_INIT_HIGH, "i2c-scl");
>> +     if (ret) {
>> +             dev_warn(dev, "gpio request fail: %d\n", bri->scl_gpio);
>> +             return ret;
>> +     }
>> +
>> +     if (!bri->skip_sda_polling) {
>
> * if (is_valid_gpio(bri->sda_gpio)) ...

Hmm.. looks pretty good and correct. Will buy this one :)

>> +             if (gpio_request_one(bri->sda_gpio, GPIOF_IN, "i2c-sda")) {
>> +                     /* work without sda polling */
>> +                     dev_warn(dev, "can't get sda: %d. Skip sda polling\n",
>> +                                     bri->sda_gpio);
>> +                     bri->skip_sda_polling = true;
>
> * Instead of above line:
>         bri->get_sda = get_sda_gpio_value;

Hmm.. couldn't get this one...
So, what i understood is, because we don't have skip_sda_polling now, we
have to choose some other way to say, we don't support sda.. so we can
mark get_sda as NULL. right?

>> +static int i2c_generic_recovery(struct i2c_adapter *adap)
>> +{
>> +     struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
>> +     int i, val = 0;
>> +
>> +     if (bri->prepare_recovery)
>> +             bri->prepare_recovery(bri);
>
> prepare_recovery and unprepare should be in i2c_generic_scl_recovery and
> i2c_generic_gpio_recovery since they are probably needed to turn SDA/SCL
> into GPIOs and back. We want that before the gpio_get/put routines.

i2c_generic_recovery() is an local routine called from both scl and
gpio recovery
routines. So, keeping a single copy of prepare/unprepare calls makes more sense.

The other point about getting gpios first and then calling prepare..
I don't think that would be right thing to do. Suppose we call prepare
first, which would
update padmux on the board. At this time gpio may be in output mode and my burn
our boards. So, its better to get gpios in desired modes and then change muxing.

>> +     /* SCL shouldn't be low here */
>> +     if (!bri->get_scl(adap)) {
>> +             dev_err(&adap->dev, "SCL is stuck Low, exiting recovery.\n");
>
> returning -EBUSY?

Yes. Will recheck on errors returned from the routine.

>> +                     /* Check SCL again to see fault condition */
>> +                     if (!bri->get_scl(adap)) {
>> +                             dev_err(&adap->dev, "SCL is stuck Low during recovery, exiting recovery.\n");
>
> returning -EBUSY?
> This scl check should not depend on skip_sda_polling, or?

yes.

>> +                             goto unprepare;
>> +                     }
>> +
>> +                     if (bri->get_sda(adap))
>> +                             break;
>
> Checking SDA should be done before setting SCL? That would
>
> a) let us escape early if SDA got HIGH magically somehow until we enter
>    the for loop for the first time
> b) breaking out of the for loop after the last pulse is moot

Good one.

>> +                             dev_warn(&adap->dev,
>> +                                             "!get_sda. skip sda polling\n");
>
> That message needs improvement ("!get_sda").

+1

All other comments are accepted too.. Hopefully it may get in 3.9 :)
