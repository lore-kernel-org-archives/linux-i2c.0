From: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c: add i2c-lpc2k driver
Date: Sat, 15 Aug 2015 23:57:31 +0200
Message-ID: <CAGhQ9VxXqzM6CObsxkUKLur99SE5GGYiXAQ7hEFNiMJAXR4sbw@mail.gmail.com>
References: <1436741242-13489-1-git-send-email-manabian@gmail.com>
	<1436741242-13489-2-git-send-email-manabian@gmail.com>
	<20150815202423.GD3463@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150815202423.GD3463@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 15 August 2015 at 22:24, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> On Mon, Jul 13, 2015 at 12:47:21AM +0200, Joachim Eastwood wrote:
>> Add support for the I2C controller found on several NXP devices
>> including LPC2xxx, LPC178x/7x and LPC18xx/43xx. The controller
>> is implemented as a state machine and the driver act upon the
>> state changes when the bus is accessed.
>>
>> The I2C controller supports master/slave operation, bus
>> arbitration, programmable clock rate, and speeds up to 1 Mbit/s.
>>
>> Signed-off-by: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> Thanks for the submission! Looking mostly good already.
>
>> +static void i2c_lpc2k_pump_msg(struct lpc2k_i2c *i2c)
>> +{
>> +     unsigned char data;
>> +     u32 status;
>> +
>> +     /*
>> +      * I2C in the LPC2xxx series is basically a state machine.
>> +      * Just run through the steps based on the current status.
>> +      */
>> +     status = readl(i2c->reg_base + LPC24XX_I2STAT);
>> +
>> +     switch (status) {
>> +     case M_START:
>> +     case M_REPSTART:
>> +             /* Start bit was just sent out, send out addr and dir */
>> +             data = (i2c->msg->addr << 1);
>> +             if (i2c->msg->flags & I2C_M_RD)
>> +                     data |= 1;
>> +
>> +             writel(data, i2c->reg_base + LPC24XX_I2DAT);
>> +             writel(LPC24XX_STA, i2c->reg_base + LPC24XX_I2CONCLR);
>> +
>> +             dev_dbg(&i2c->adap.dev, "Start sent with addr 0x%02x\n", data);
>
> I assume the driver is basically working. So, in my book, most of this
> debug output is useful when the driver was developed, not so much
> afterwards. Also, it is printed in interrupt context possibly causing
> latency. However, the information is useful for understanding the
> driver, so I'd suggest to convert them into comments?

I'll go through all the dev_dbg stuff with what you wrote in mind.
Think I'll end up with removing most of it.

Think most of the debugging stuff was added by Emcraft while they were
bring it up on lpc178x and lpc18xx.


>> +     i2c->adap.nr = pdev->id;
>> +
>> +     ret = i2c_add_numbered_adapter(&i2c->adap);
>
> Intended? Most DT enabled drivers simply user i2c_add_adapter(). The
> core then takes care of aliases defined in DT.

No, it's not intended. It's an old driver and I just didn't know about
i2c_add_adapter(). I'll change it in the next version.


> And please have a look at Documentation/i2c/fault-codes. Arbitration
> Lost should be -EAGAIN, NACK should be -ENXIO, and so forth...

Ok, will do.


Thanks for looking, Wolfram. I'll address your comments and try to
send out a new version tomorrow.


regards,
Joachim Eastwood
