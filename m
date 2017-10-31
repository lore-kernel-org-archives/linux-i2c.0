From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: Sluggish AT91 I2C driver causes SMBus timeouts
Date: Tue, 31 Oct 2017 17:10:16 +0100
Message-ID: <20171031161016.mcfxucwabzv4glyv@rfolt0960.corp.atmel.com>
References: <3d83fd8b-ade9-da10-3364-2afefa2e90af@axentia.se>
 <20171013142935.14ef302e@alans-desktop>
 <92675fc4-060b-0056-4fe8-3fe3368cb617@axentia.se>
 <20171017075807.tsh5walc3sla3pth@rfolt0960.corp.atmel.com>
 <fd09259b-9779-12de-5351-783c397d27aa@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:59151 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbdJaQK0 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 31 Oct 2017 12:10:26 -0400
Content-Disposition: inline
In-Reply-To: <fd09259b-9779-12de-5351-783c397d27aa@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>

Hi Peter,

On Wed, Oct 25, 2017 at 11:40:50PM +0200, Peter Rosin wrote:
> Hi Ludovic,
> 
> On 2017-10-17 09:58, Ludovic Desroches wrote:
> > Hi Peter,
> > 
> > On Fri, Oct 13, 2017 at 05:01:04PM +0200, Peter Rosin wrote:
> >> On 2017-10-13 15:29, Alan Cox wrote:
> >>> On Thu, 12 Oct 2017 13:35:17 +0200
> >>> Peter Rosin <peda@axentia.se> wrote:
> >>>
> >>>> Hi!
> >>>>
> >>>> I have encountered an "interesting" bug. It silently corrupts data
> >>>> and is generally nasty...
> >>>>
> >>>> On an I2C bus, driven by the at91 driver and DMA (an Atmel
> >>>> sama5d31 chip), I have an 256 byte eeprom (NXP SE97BTP). I'm using
> >>>> Linux v4.13.
> >>>
> >>> If your force the transfer to PIO does it behave ? Does the controller in
> >>> fact need to siwtch to PIO for SMBUS ?
> >>
> >> Like, what if I disable DMA?
> >>
> >> I saw no way to do that, short of short-cutting a few things in the
> >> driver code. So, did that and I cannot tickle the bug. But I don't
> >> know if that makes me safe?
> >>
> >> Ludovic, any reason to believe disabling DMA will prevent these
> >> stalls, or will they just appear under different circumstances?
> > 
> > Sorry I am currently on vacation. I outlined this discussion.
> 
> And I got buried in other stuff so I managed to ignore and then forget
> this for a couple of days. Sorry for the delay...
> 

No problem.

> > As you noticed, there are some hardware constraints when using DMA.
> > Switching from DMA to PIO to handle the end of the transfer is probably the
> > root cause of the delay you get.
> > 
> > I read you added traces, did you manage to get some information about
> > timings? Do we waste time waiting for the dma callback? for the RXRDY
> > interrupt?
> 
> I *think* the stalls I'm seeing are from the dma callback.
> 
> > If we spend time waiting for the dma callback for sure, disabling DMA
> > should prevent these stalls. If the stall is inbetween the two last
> > RXRDY interrupts, it seems it can appear under different circumstances.
> 
> Exactly my point. It is hard to tell for sure. If we don't do dma, there
> is simply no guarantee that the problem goes away. I fear that disabling
> dma will only make the problem less likely, and that it therefore is not
> a real fix. I can test this any number of times, and Murphy will make
> sure that it doesn't trigger. Until it's in the hands of the customer...
> 
> The smbus timeout is quite hard to handle when there is no way to
> guarantee that deadlines are met. The way I see it, the only safe option
> is to disable the smbus timeout. I prefer that over killing dma
> completely.
> 

Your approach is probably the good one as it seems that the i2c-at91
controller is not the only one that cannot handle the SMBus timeout
feature.

> See my patches that take that approach (sorry for not having you on the
> cc list)
> https://lkml.org/lkml/2017/10/13/184
> 

Thanks.

Regards

Ludovic

> >>
> >> I used this dirty "patch" to i2c-at91.c:at91_twi_configure_dma() for
> >> testing:
> >>
> >> -	dev->use_dma = true;
> >> +	//dev->use_dma = true;
> >>
> > 
> > You can simply remove dma bindings from the i2c node to force the i2c
> > controller to use the PIO mode.
> 
> Ok, that's less intrusive...
> 
> Cheers,
> Peter
