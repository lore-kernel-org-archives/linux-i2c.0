From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v5 4/5] dt: bindings: i2c-mux-pca954x: Add documentation
 for nxp,irq-mask-enable
Date: Tue, 17 Jan 2017 10:43:37 +0100
Message-ID: <96f3cc0e-9c73-4af4-f072-5a1aeceb67af@axentia.se>
References: <1484640029-22870-1-git-send-email-preid@electromag.com.au>
 <1484640029-22870-5-git-send-email-preid@electromag.com.au>
 <9190ec70-eda4-5e44-a85a-211945c30eeb@axentia.se>
 <aeab2bbe-e243-98f6-b07f-76e4dda62fd6@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <aeab2bbe-e243-98f6-b07f-76e4dda62fd6-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-01-17 10:28, Phil Reid wrote:
> On 17/01/2017 16:57, Peter Rosin wrote:
>> On 2017-01-17 09:00, Phil Reid wrote:
>>> Unfortunately some hardware device will assert their irq line immediately
>>> on power on and provide no mechanism to mask the irq. As the i2c muxes
>>> provide no method to mask irq line this provides a work around by keeping
>>> the parent irq masked until enough device drivers have loaded to service
>>> all pending interrupts.
>>>
>>> For example the the ltc1760 assert its SMBALERT irq immediately on power
>>> on. With two ltc1760 attached to bus 0 & 1 on a pca954x mux when the first
>>> device is registered irq are enabled and fire continuously as the second
>>> device driver has not yet loaded. Setting this parameter to <1 1> will
>>> delay the irq being enabled until both devices are ready.
>>
> G'day Peter,
> 
> 
>> Hang on, does this suggestion I made make any sense at all? Maybe it does,
>> but does the pca954x driver even get notified of any but the first irq client
>> that unmasks interrupts on a mux segment? How can it count the number of
>> active irq clients if not?
> 
> Good question.
> 
> So what I did to test is setup my 2 ltc1760s to use the same irq on the pca954x.
> Using the latest patch series.
> 
> Adding a log message into the irq_unmask function got the following.
> 	dev_err(&data->client->dev, "irq_unmask %d %x %d", pos, data->irq_mask, data->irq_enabled);
> 
> dmesg | grep irq_unmask
> [    4.392098] pca954x 4-0070: irq_unmask 0 1 1
> 
> 
> But Looks like both got registered ok to the same irq.
> cat /proc/interrupts
> 161:          0          0  i2c-mux-pca954x   0 Level     15-000a, 16-000a
> 
> So from this testing, it doesn't look like it gets called multiple times.

As I suspected, thanks for verifying!

> So back to the bitmask for the dt do you think.

Looking at kernel/irq/chip.c:irq_enable (and struct irq_chip docs), I get the
feeling that if you provide the irq_enable operation (and maybe irq_disable too?),
that might get us more info?

> I think the interrupt enablelogic is correct now.
> 
>>
>> I'm truly sorry for the trouble I'm causing by not just saying how it should
>> be done from the start, but I feel like I've been thrown in at the deep end
>> when it comes to interrupt controllers...
> 
> No problem. I'm learning a couple things as we go.
> Should help me out on other drivers :)

Yes, I'm also picking up a few bits here and there...

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
