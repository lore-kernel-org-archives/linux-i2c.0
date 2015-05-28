From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/12] i2c: pxa: enable/disable irq across message xfer
Date: Thu, 28 May 2015 18:59:21 +0530
Message-ID: <55671831.7010903@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org> <1432818224-17070-9-git-send-email-vaibhav.hiremath@linaro.org> <20150528131707.GB2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150528131707.GB2067-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



On Thursday 28 May 2015 06:47 PM, Russell King - ARM Linux wrote:
> On Thu, May 28, 2015 at 06:33:40PM +0530, Vaibhav Hiremath wrote:
>> In order to avoid "spurious irq" caused by CP polling mode,
>> enable irq at the entry of i2c_pxa_xfer() fn and disable it
>> again before exit.
>
> NAK.
>
> It's really not nice for drivers to disable a potentially shared interrupt.
> If the interrupt is shared, you disable the interrupt for other users of
> that interrupt as well.  See:
>
> commit c66dc529194be374556d166ee7ddb84a7d1d302b
> Author: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> Date:   Wed Feb 23 12:38:18 2011 +0100
>
>      i2c-pxa2xx: add support for shared IRQ handler
>
>      Sodaville has three of them on a single IRQ. IRQF_DISABLED is removed
>      because it is a NOP allready and scheduled for removal.
>
>      Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
>      Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>      Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>
> So you're breaking Sodaville.
>

Got it.

I will drop this patch from the series.

Before submitting next version, will wait for review on other patches.

Thanks,
Vaibhav
