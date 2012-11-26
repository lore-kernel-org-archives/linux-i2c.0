From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V7 1/2] i2c/adapter: Add bus recovery infrastructure
Date: Mon, 26 Nov 2012 07:58:45 +0530
Message-ID: <CAKohpo=_2xwj+NCpZPB1EsWiGPLafc3XKVbRT+690AkHB76AWw@mail.gmail.com>
References: <71e27515a050a2c7d18272b84ff7ec3ec8b11cae.1353824555.git.viresh.kumar@linaro.org>
	<50B20670.5070509@pcserviceselectronics.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50B20670.5070509-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Paul Carpenter <paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org>
Cc: u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 25 November 2012 17:22, Paul Carpenter
<paul-YHLC2tV1sDlxR4N9A70vTlRxknfHcPLb9dF7HbQ/qKg@public.gmane.org> wrote:
> Viresh Kumar wrote:
>> Add i2c bus recovery infrastructure to i2c adapters as specified in the
>> i2c
>> protocol Rev. 03 section 3.1.16 titled "Bus clear".
>>
>> http://www.nxp.com/documents/user_manual/UM10204.pdf
>
> You should also take note of section 3.1.14 and its notes on Software
> Reset -
>     "Precautions must be taken to ensure that a device is not
>      pulling down the SDA or SCL line after applying the supply
>      voltage, since these low levels would block the bus"

Hmm.. This patch has taken a very long time for being accepted, and the
reason for that was, it was generalizing much more than what is required.

And I am not sure, if checking SCL low would be considered like that only. :)

@Wolfram: I would need your point of view on that, before trying it out.

>> +static int i2c_get_gpios_for_recovery(struct i2c_adapter *adap)
>> +{
>> +    struct i2c_bus_recovery_info *bri = adap->bus_recovery_info;
>> +    struct device *dev = &adap->dev;
>> +    int ret = 0;
>
> Where is the check that SCL is NOT low (bus fault or device doing clock
> stretching)

Pending for Wolfram's point of view :)

>> +static int i2c_generic_recovery(struct i2c_adapter *adap)
>> +{
>> +    /*
>> +     * By this time SCL is high, as we need to give 9 falling-rising
>> edges
>> +     */
>
> In my view that needs to be done by an actual check of the real SCL not
> assumption.

Checking that would be tricky. For GPIO recovery, we have to make it GPIO
first in input mode and read its value. Right?

>> +    delay = DIV_ROUND_UP(delay, bri->clock_rate_khz * 2);
>> +
>> +    for (i = 0; i < RECOVERY_CLK_CNT * 2; i++, val = !val) {
>> +        bri->set_scl(adap, val);
>> +        ndelay(delay);
>> +
>> +        /* break if sda got high, check only when scl line is high */
>> +        if (!bri->skip_sda_polling && val)
>
> Dont use 'val' read the actual SCL line which ensures you you are not
> wasting your time because of hardware fault. Possibly saving your GPIO
> from being stuck permanently.

Again, wolfram can decide if it is really required :)

--
viresh
