From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: 10-bit address support
Date: Wed, 16 Nov 2011 16:22:33 +0100
Message-ID: <20111116162233.11441573@endymion.delvare>
References: <20111110160739.540cda37@endymion.delvare>
	<20111111104335.GC2493@pengutronix.de>
	<20111116155610.6b02aab6@endymion.delvare>
	<20111116150449.GG2596@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20111116150449.GG2596-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Jeffrey (Sheng-Hui) Chu" <jeffchu-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 16 Nov 2011 16:04:49 +0100, Wolfram Sang wrote:
> Hi Jean,
> 
> > > Wouldn't the cleanest solution be
> > > 
> > > "%d-%02x" for 7 bit
> > > "%d-%04x" for 10 bit?
> > 
> > I'd rather use %03x for 10-bit then, for consistency.
> 
> Yup, I realized this a few hours later, too. This would leave the
> possibility to add true 16-bit addressing of the next to be i2c standard
> ;)

Given the fiasco 10-bit address support was, I doubt we'll see any
attempt to further extend the address space. The protocol penalty of
10-bit addressing is heavy and 7-bit addresses are often sufficient in
practice. Where they are not, designers have resorted to using muxes
and switches rather than 10-bit addresses.

> > internally), but unfortunately it would have had to be implemented in
> > the early days, not 8 years later.
> 
> Yes, and hopefully we can live with this drawback well enough.
> 
> > 0xa000 is not more intrusive than 0x1000, so if the majority - i.e.
> > you ;) - is in favor of this, that's fine with me. I'll send a patch
> > later today.
> 
> You can already add my:
> 
> Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Thanks,
-- 
Jean Delvare
