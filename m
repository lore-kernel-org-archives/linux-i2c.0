From: Peter Rosin <peda@axentia.se>
Subject: Re: [RFC PATCH 1/1] i2c: i2c-mux-pca954x: Add interrupt controller
 support.
Date: Mon, 1 Aug 2016 10:22:11 +0200
Message-ID: <61f5c328-9bbe-82c1-a969-60d1dae7db22@axentia.se>
References: <1469588756-70579-1-git-send-email-preid@electromag.com.au>
 <1469588756-70579-2-git-send-email-preid@electromag.com.au>
 <e96c68d6-7905-7bee-2173-b66d29e9969b@axentia.se>
 <4ce345bd-c618-eff8-a68e-632dd99e8239@electromag.com.au>
 <b9f67d9d-6d22-6bc8-16f6-e65ea2e853a0@axentia.se>
 <8efb7100-9a19-dd38-f10c-891905fc8e23@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ve1eur01on0100.outbound.protection.outlook.com ([104.47.1.100]:7929
	"EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750780AbcHAIWe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 1 Aug 2016 04:22:34 -0400
In-Reply-To: <8efb7100-9a19-dd38-f10c-891905fc8e23@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016-08-01 08:25, Phil Reid wrote:
> On 29/07/2016 13:48, Peter Rosin wrote:
>> Ok, I think I get the problem, but I too am at a loss and see no elegant solution.
>> One sad thing about your workaround is that it is not working at all unless there
>> is an irq user on all mux child segments that unmasks the corresponding irq. Right?
>>
>> I think the default should be that the driver assumes sane HW, i.e. the irq inputs
>> are not asserted unless some driver is able to clear them. You can then add an
>> option to keep irqs disabled when the mask "is wrong". As a bonus, I think this
>> "is wrong" test should be configurable so that you specify a bitmask of irqs that
>> all has to be unmasked for the irq to be enabled (and use that instead of the 0x3
>> in the pca954x_irq_mask/pca954x_irq_unmask functions). That makes the workaround
>> more flexible.
> 
> Correct, It works for my use case at the moment. There would need to be a way to define a mask.
> Via device tree for example.

Yes, some optional property in DT was my vision also.

> I think sane devices that have irq masking don't really need the pca954x to be a irq source.
> They could be configured with a shared IRQ as the pCA954x just ANDs then incoming lines together.

Right. And I suppose we don't know if this is already happening... AFAIU,
that approach would still work even if pca954x is made an interrupt source.
Or?

I mean, as you say, the pca954x functions as an electrical AND, and if
interrupt clients register with whatever the parent interrupt controller
is, they would be not be affected if there is also an interrupt controller
for pca954x?

Yes, such imaginary uses could have just wired all the irq lines together,
but we don't know if they actually did that or if they possibly went via
the irq routing in the pca954x for whatever reason...

> So does my use case and workaround justify the complexity added to the driver?
> 
> Thou there is possibly a performance benefit from reading the pca954x to dispatch the appropriate
> irq, which would save alot of i2c transactions to probe each possible irq source device and assocaited
> i2c mux switching.
> 
> WDYR?

It was the last bit that I also realized, and it would be nice to not have to
dig through all irq devices on the child side of the mux (and other clients
sharing the irq line with the pca954x for that matter). In theory there could
be quite a few...

So, yes, I think it might be worthwhile to make it an interrupt controller.
And then the tweak with your mask is no longer the big part of it...

BTW, you also need to change bindings docs in
Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt

I also noticed that you are using irq_domain_add_legacy which is marked as,
*tada* legacy, and that most drivers should use a linear domain. Sounds like
a linear domain fits the use case here, no?

And another note, the workaround for your limited hw is rather non-generic.
I mean, if the irq line from the pca954x to the parent interrupt controller
is shared with something else, then there would still be a flood even with
the workaround. Or am I misunderstanding that?

Cheers,
Peter
