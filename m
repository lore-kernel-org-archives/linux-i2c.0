From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Mon, 19 Jan 2015 13:25:05 -0800
Message-ID: <54BD7631.50205@broadcom.com>
References: <20150115084119.GN22880@pengutronix.de> <54B98C18.4080807@broadcom.com> <20150117160113.GA22880@pengutronix.de> <54BABEE9.8070801@broadcom.com> <20150117201849.GC22880@pengutronix.de> <54BACB66.6040909@broadcom.com> <20150117211017.GD22880@pengutronix.de> <54BAD391.9080909@broadcom.com> <20150117224021.GA26493@n2100.arm.linux.org.uk> <54BAFEA9.9040900@broadcom.com> <20150119192805.GF26493@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150119192805.GF26493-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 1/19/2015 11:28 AM, Russell King - ARM Linux wrote:
> On Sat, Jan 17, 2015 at 04:30:33PM -0800, Ray Jui wrote:
>>
>>
>> On 1/17/2015 2:40 PM, Russell King - ARM Linux wrote:
>>> On Sat, Jan 17, 2015 at 01:26:41PM -0800, Ray Jui wrote:
>>>> 	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
>>>>
>>>> 	/* disable all interrupts */
>>>> 	writel(0, iproc_i2c->base + IE_OFFSET);
>>>>
>>>> 	if (!time_left && !atomic_read(&iproc_i2c->transfer_is_successful)) {
>>>
>>> Why are you using atomic_read() here?
>>>
>> transfer_is_successful 1) will be reset to 0 in this function (before
>> kick start the I2C transfer), 2) will be set to 1 in the ISR (to signal
>> completion of the I2C transfer), and 3) will be checked in this function
>> here. I thought that means I should declare it volatile, because it can
>> be modified in both the process context and interrupt context (and I use
>> atomic because I remember Linux checkpatch warns against using volatile)?
> 
> You don't need volatile or atomic_t for that.
> 
> Rather than switching to atomic_t when seeing the checkpatch warning,
> you'd do better to read Documentation/volatile-considered-harmful.txt
> to understand why checkpatch issues the warning, and realise that you
> don't need it for the above.
> 
> Note that in the above code, the compiler can't make an assumption
> about iproc_i2c->transfer_is_successful because it can't tell whether
> a called function (eg, wait_for_completion_timeout()) could modify it.
> 
Got it. Thanks.

> Another possible issue with the above code are these lines:
> 
> 	/* disable all interrupts */
> 	writel(0, iproc_i2c->base + IE_OFFSET);
> 
> It would be nice to think that would hit the hardware immediately, but
> that's making assumptions about hardware which are not necessary true.
> Your interrupt handler could even be running on another CPU after you've
> asked for that register to be written.
> 
> Depending on what you're trying to achieve here, you may need:
> 
> 	/* disable all interrupts */
> 	writel(0, iproc_i2c->base + IE_OFFSET);
> 	/* read it back to ensure the write has hit */
> 	readl(iproc_i2c->base + IE_OFFSET);
> 
> 	/* make sure the interrupt handler isn't running */
> 	synchronize_irq(...->irq);
> 
> if what you're trying to do is to ensure that the interrupt handler has
> finished running.
> 
This will be the most robust way of handling this. Given that we've
added an additional flag to check to make sure there's no interrupt
missed after wait_for_completion_timeout times out, it makes sense to
ensure that by the time when we check the flag there's no pending irq.
I'll add this to the driver and make 'xfer_is_done' an 'int' instead of
'atomic_t'. I will also add the call to readl to flush the write in the
remove function after interrupts are disabled.
