From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 4/7] i2c/pxa2xx: add support for shared IRQ handler
Date: Thu, 25 Nov 2010 11:48:30 +0100
Message-ID: <4CEE3EFE.2080909@linutronix.de>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>	<1290633617-15311-5-git-send-email-bigeasy@linutronix.de> <AANLkTik11gr1fg=vht2FYBpDZBBhxLXezS8ih752xj=5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTik11gr1fg=vht2FYBpDZBBhxLXezS8ih752xj=5@mail.gmail.com>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sodaville-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Haojian Zhuang wrote:
>> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
>> index dc66fde..7647361 100644
>> --- a/drivers/i2c/busses/i2c-pxa.c
>> +++ b/drivers/i2c/busses/i2c-pxa.c
>> @@ -905,11 +905,17 @@ static void i2c_pxa_irq_rxfull(struct pxa_i2c *i2c, u32 isr)
>>        writel(icr, _ICR(i2c));
>>  }
>>
>> +#define VALID_INT_SOURCE       (ISR_SSD | ISR_ALD | ISR_ITE | ISR_IRF | \
>> +                               ISR_SAD | ISR_BED)
>>  static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id)
>>  {
>>        struct pxa_i2c *i2c = dev_id;
>>        u32 isr = readl(_ISR(i2c));
>>
>> +       isr &= VALID_INT_SOURCE;
>> +       if (!isr)
>> +               return IRQ_NONE;
>> +
> 
> If you return at here, the valid interrupt status event won't be
> cleared in IRQ handler. So I2C interrupt handler will be triggered at
> next time.

The point here is that I have a shared handler and I have to know if my
i2c device issued an interrupt or another device. If I return here then it
was not my i2c device bot some other device hanging on the same interrupt
line.
I can't simply test for !isr (without VALID_INT_SOURCE) because some bits
in this register have nothing todo with the interrupt status as it.

Sebastian
