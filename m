From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] at24: Fall back to byte or word reads if needed
Date: Mon, 8 Mar 2010 16:15:07 +0100
Message-ID: <20100308161507.34913f7f@hyperion.delvare>
References: <20100308085008.366915c3@hyperion.delvare>
	<20100308132454.GC3375@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100308132454.GC3375-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Konstantin Lazarev <klazarev-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Mon, 8 Mar 2010 14:24:54 +0100, Wolfram Sang wrote:
> On Mon, Mar 08, 2010 at 08:50:08AM +0100, Jean Delvare wrote:
> > From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Subject: at24: Fall back to byte or word reads if needed
> > 
> > Increase the portability of the at24 driver by letting it read from
> > EEPROM chips connected to cheap SMBus controllers that support neither
> > raw I2C messages nor even I2C block reads. All SMBus controllers
> > should support either word reads or byte reads, so read support
> > becomes universal, much like with the legacy "eeprom" driver.
> > 
> > Obviously, this only works with EEPROM chips up to AT24C16, that use
> > 8-bit offset addressing. 16-bit offset addressing is almost impossible
> > to support on SMBus controllers.
> > 
> > I did not add universal support for writes, as I had no immediate need
> > for this, but it could be added later if needed (with the same
> > performance issue as byte and word reads have, of course.)
> > 
> > Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Cc: Konstantin Lazarev <klazarev-rphTv4pjVZMJGwgDXS7ZQA@public.gmane.org>
> 
> I wondered a bit if switch-case would make the code more readable instead of
> if-elseif-elseif-else. But definately no show-stopper.

Good point, I'll post an updated version soon.

> I don't have hardware to actually test the new functionality, other than that
> it appears good to me. Thanks!
> 
> Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Thanks for the review.

-- 
Jean Delvare
