From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH RFC 3/4] i2c: at91: added slave mode support
Date: Thu, 2 Nov 2017 15:53:44 +0100
Message-ID: <20171102145344.xivuz3nnrkdfdeoh@rfolt0960.corp.atmel.com>
References: <cover.1509112910.git.me@jue.yt>
 <b81e56548dbe4fa6c37fec4c80b38622f1f1fcdf.1509112910.git.me@jue.yt>
 <20171101130417.GA17787@jfi-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:60641 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933448AbdKBOxt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 2 Nov 2017 10:53:49 -0400
Content-Disposition: inline
In-Reply-To: <20171101130417.GA17787@jfi-dev>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Juergen Fitschen <me@jue.yt>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 01, 2017 at 02:04:18PM +0100, Juergen Fitschen wrote:
> Helle Ludovic,
> 
> while going through this patch a question related to the Atmel / Microchip HW
> came into mind:
> 
> On Fri, Oct 27, 2017 at 05:12:00PM +0200, Juergen Fitschen wrote:
> > diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
> > (...)
> >  #define	AT91_TWI_INT_MASK \
> > -	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK)
> > +	(AT91_TWI_TXCOMP | AT91_TWI_RXRDY | AT91_TWI_TXRDY | AT91_TWI_NACK \
> > +	| AT91_TWI_SVACC | AT91_TWI_EOSACC)
> 
> The AT91_TWI_INT_MASK is used to disable all interrputs in the
> at91_disable_twi_interrupts function by writing the mask to the interrupt
> disable register (IDR). I wonder what happens on MPUs that don't have
> AT91_TWI_SVACC and AT91_TWI_EOSACC implemented, like the AT91RM9200? Do you
> think we should revise this and write specific masks depending on the current
> moude the I2C HW is in?
> 
> Something like this:
> 
> void at91_disable_twi_interrupts(struct at91_twi_dev *dev)
> {
>         if (dev->slave_detected)
>                 at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_INT_MASK_SLAVE);
>         else
>                 at91_twi_write(dev, AT91_TWI_IDR, AT91_TWI_INT_MASK_MASTER);
> }
> 

I don't think it's necessary. Usually, writing a bit which is unused don't
cause weird behaviors.

Regards

Ludovic
