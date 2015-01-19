From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v6 2/3] i2c: iproc: Add Broadcom iProc I2C Driver
Date: Mon, 19 Jan 2015 13:31:25 -0800
Message-ID: <54BD77AD.3080209@broadcom.com>
References: <rjui@broadcom.com> <1421695428-19102-1-git-send-email-rjui@broadcom.com> <1421695428-19102-3-git-send-email-rjui@broadcom.com> <20150119194420.GG26493@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150119194420.GG26493-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, =?windows-1252?Q?Uwe_Kleine-K=F6n?= =?windows-1252?Q?ig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org



On 1/19/2015 11:44 AM, Russell King - ARM Linux wrote:
> To see why atomic_t is pure obfuscation:
> 
> typedef struct {
>         int counter;
> } atomic_t;
> 
> So, counter is a plain int.
> 
> On Mon, Jan 19, 2015 at 11:23:47AM -0800, Ray Jui wrote:
>> +static irqreturn_t bcm_iproc_i2c_isr(int irq, void *data)
>> +{
>> +	struct bcm_iproc_i2c_dev *iproc_i2c = data;
>> +	u32 status = readl(iproc_i2c->base + IS_OFFSET);
>> +
>> +	status &= ISR_MASK;
>> +
>> +	if (!status)
>> +		return IRQ_NONE;
>> +
>> +	writel(status, iproc_i2c->base + IS_OFFSET);
>> +	atomic_set(&iproc_i2c->xfer_is_done, 1);
> 
> #define atomic_set(v,i) (((v)->counter) = (i))
> 
> So, this is the same as doing:
> 
> 	iproc_i2c->xfer_is_done.counter = 1;
> 
> which is merely setting the 'int' to 1.
> 
>> +	time_left = wait_for_completion_timeout(&iproc_i2c->done, time_left);
>> +
>> +	/* disable all interrupts */
>> +	writel(0, iproc_i2c->base + IE_OFFSET);
>> +
>> +	if (!time_left && !atomic_read(&iproc_i2c->xfer_is_done)) {
> 
> #define atomic_read(v)  ACCESS_ONCE((v)->counter)
> 
> This is practically the same as:
> 
> 	if (!time_left && !iproc_i2c->xfer_is_done.counter) {
> 
> except that this access will be guaranteed to happen just once at this
> location (see ACCESS_ONCE() in include/linux/compiler.h).
> 
> However, complete()..wait_for_completion() ensures that there are
> barriers in the way: complete takes a spinlock on the waiter, so the
> write to iproc_i2c->xfer_is_done.counter will be visible by the time
> wait_for_completion() returns, and wait_for_completion() also does.
> The same spinlock is also manipulated by wait_for_completion(), which
> means there's barriers there as well, so it can't cache the value of
> "counter" across that call.
> 
> So, the "volatile" access guaranteed by ACCESS_ONCE() isn't even
> needed here.
> 
> (It would be needed if you were spinning in a loop, calling no other
> functions - but then you're supposed to use cpu_relax() in that
> circumstance, which has a compiler barrier in it, which ensures that
> it will re-read such a variable each time.)
> 
I really learned a good lesson here. Thanks for the thorough explanation!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
