From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: Sluggish AT91 I2C driver causes SMBus timeouts
Date: Tue, 17 Oct 2017 09:58:07 +0200
Message-ID: <20171017075807.tsh5walc3sla3pth@rfolt0960.corp.atmel.com>
References: <3d83fd8b-ade9-da10-3364-2afefa2e90af@axentia.se>
 <20171013142935.14ef302e@alans-desktop>
 <92675fc4-060b-0056-4fe8-3fe3368cb617@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <92675fc4-060b-0056-4fe8-3fe3368cb617@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Ludovic Desroches <ludovic.desroches@microchip.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On Fri, Oct 13, 2017 at 05:01:04PM +0200, Peter Rosin wrote:
> On 2017-10-13 15:29, Alan Cox wrote:
> > On Thu, 12 Oct 2017 13:35:17 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> > 
> >> Hi!
> >>
> >> I have encountered an "interesting" bug. It silently corrupts data
> >> and is generally nasty...
> >>
> >> On an I2C bus, driven by the at91 driver and DMA (an Atmel
> >> sama5d31 chip), I have an 256 byte eeprom (NXP SE97BTP). I'm using
> >> Linux v4.13.
> > 
> > If your force the transfer to PIO does it behave ? Does the controller in
> > fact need to siwtch to PIO for SMBUS ?
> 
> Like, what if I disable DMA?
> 
> I saw no way to do that, short of short-cutting a few things in the
> driver code. So, did that and I cannot tickle the bug. But I don't
> know if that makes me safe?
> 
> Ludovic, any reason to believe disabling DMA will prevent these
> stalls, or will they just appear under different circumstances?

Sorry I am currently on vacation. I outlined this discussion.

As you noticed, there are some hardware constraints when using DMA.
Switching from DMA to PIO to handle the end of the transfer is probably the
root cause of the delay you get.

I read you added traces, did you manage to get some information about
timings? Do we waste time waiting for the dma callback? for the RXRDY
interrupt?

If we spend time waiting for the dma callback for sure, disabling DMA
should prevent these stalls. If the stall is inbetween the two last
RXRDY interrupts, it seems it can appear under different circumstances.

> 
> I used this dirty "patch" to i2c-at91.c:at91_twi_configure_dma() for
> testing:
> 
> -	dev->use_dma = true;
> +	//dev->use_dma = true;
> 

You can simply remove dma bindings from the i2c node to force the i2c
controller to use the PIO mode.


Regards

Ludovic

> Cheers,
> Peter
