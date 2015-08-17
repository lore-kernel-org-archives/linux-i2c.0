From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] i2c: add i2c-lpc2k driver
Date: Mon, 17 Aug 2015 22:37:19 +0200
Message-ID: <CAGhQ9VzO=mQyCB2B-2Ys32amRNcPVicZWKVygssZmN+NURXKsQ@mail.gmail.com>
References: <1439748617-7683-1-git-send-email-manabian@gmail.com>
	<1439748617-7683-2-git-send-email-manabian@gmail.com>
	<20150817201830.GA11033@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150817201830.GA11033@laptop>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ariel D'Alessandro <ariel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 17 August 2015 at 22:18, Ezequiel Garcia
<ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org> wrote:
> On 16 Aug 08:10 PM, Joachim Eastwood wrote:
> [..]
>> +
>> +static int 2(struct lpc2k_i2c *i2c)
>> +{
>> +     unsigned long timeout = jiffies + msecs_to_jiffies(1000);
>> +
>> +     /*1
>> +      * If the transfer needs to abort for some reason, we'll try to
>> +      * force a stop condition to clear any pending bus conditions
>> +      */
>> +     writel(LPC24XX_STO, i2c->base + LPC24XX_I2CONSET);
>> +
>> +     /* Wait for status change */
>> +     while (readl(i2c->base + LPC24XX_I2STAT) != M_I2C_IDLE) {
>> +             if (time_after(jiffies, timeout)) {
>> +                     /* Bus was not idle, try to reset adapter */
>> +                     i2c_lpc2k_reset(i2c);
>> +                     return -EBUSY;
>> +             }
>> +
>> +             cpu_relax();
>> +     }
>
> I believe you can use readl_{relaxed}_poll_timeout_{atomic} here.

I did consider it, but since I don't have a good to way test the code
path I left it as it was.
Also since readl_{relaxed}_poll_timeout_{atomic} takes parameters in
us it seemed unsuitable for a 1s total sleep, but I may be wrong.

> Ccing Ariel, maybe he can help with a test.

That would be great.

regards,
Joachim Eastwood
