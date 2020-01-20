From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH 01/12] i2c: pxa: use official address byte helper
Date: Mon, 20 Jan 2020 19:13:11 +0000
Message-ID: <20200120191311.GE25745@shell.armlinux.org.uk>
References: <20191215160444.GB25745@shell.armlinux.org.uk>
 <E1igWOT-0005Dp-Sb@rmk-PC.armlinux.org.uk>
 <c3d57cc4-5ec4-492f-e233-580ac1aba2cd@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39256 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgATTNS (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 20 Jan 2020 14:13:18 -0500
Content-Disposition: inline
In-Reply-To: <c3d57cc4-5ec4-492f-e233-580ac1aba2cd@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Mon, Jan 20, 2020 at 05:03:26PM +0000, Peter Rosin wrote:
> On 2019-12-15 17:05, Russell King wrote:
> > i2c-pxa was created before i2c_8bit_addr_from_msg() was implemented,
> > and used its own i2c_pxa_addr_byte() which is functionally the same.
> > Sadly, it was never updated to use this new helper. Switch it over.
> > 
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/i2c/busses/i2c-pxa.c | 21 +++++++--------------
> >  1 file changed, 7 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> > index 2c3c3d6935c0..966000923e8e 100644
> > --- a/drivers/i2c/busses/i2c-pxa.c
> > +++ b/drivers/i2c/busses/i2c-pxa.c
> > @@ -675,25 +675,18 @@ static void i2c_pxa_slave_stop(struct pxa_i2c *i2c)
> >   * PXA I2C Master mode
> >   */
> >  
> > -static inline unsigned int i2c_pxa_addr_byte(struct i2c_msg *msg)
> > -{
> > -	unsigned int addr = (msg->addr & 0x7f) << 1;
> > -
> > -	if (msg->flags & I2C_M_RD)
> > -		addr |= 1;
> > -
> > -	return addr;
> > -}
> > -
> >  static inline void i2c_pxa_start_message(struct pxa_i2c *i2c)
> >  {
> >  	u32 icr;
> > +	u8 addr;
> > +
> > +	addr = i2c_8bit_addr_from_msg(i2c->msg);
> >  
> >  	/*
> >  	 * Step 1: target slave address into IDBR
> >  	 */
> > -	writel(i2c_pxa_addr_byte(i2c->msg), _IDBR(i2c));
> > -	i2c->req_slave_addr = i2c_pxa_addr_byte(i2c->msg);
> > +	writel(addr, _IDBR(i2c));
> > +	i2c->req_slave_addr = addr;
> 
> You are introducing a temporary variable (addr) here...
> 
> >  
> >  	/*
> >  	 * Step 2: initiate the write.
> > @@ -1006,8 +999,8 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c *i2c, u32 isr)
> >  		/*
> >  		 * Write the next address.
> >  		 */
> > -		writel(i2c_pxa_addr_byte(i2c->msg), _IDBR(i2c));
> > -		i2c->req_slave_addr = i2c_pxa_addr_byte(i2c->msg);
> > +		writel(i2c_8bit_addr_from_msg(i2c->msg), _IDBR(i2c));
> > +		i2c->req_slave_addr = i2c_8bit_addr_from_msg(i2c->msg);
> 
> ...but not here. But it seems like the same pattern. Any particular reason for
> that difference?

No real reason.  If I assign i2c->req_slave_addr first, I don't need
a separate variable...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
