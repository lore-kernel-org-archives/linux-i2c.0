From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 3/4] imxmmc: add MX1 support
Date: Wed, 25 Mar 2009 13:38:20 +0000
Message-ID: <20090325133820.GF19758@fluff.org.uk>
References: <5d5443650903240531l1158d323t4c10575e9b350d43@mail.gmail.com> <20090324134655.GL25436@pengutronix.de> <49C8EFB3.803@teltonika.lt> <20090324155908.GO25436@pengutronix.de> <49C90DFD.1040107@teltonika.lt> <20090324170134.GP25436@pengutronix.de> <20090325085223.GG4697@n2100.arm.linux.org.uk> <gqcv9q$q04$1@ger.gmane.org> <20090325113108.GC31464@n2100.arm.linux.org.uk> <20090325115929.GD3029@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090325115929.GD3029-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Mar 25, 2009 at 12:59:29PM +0100, Wolfram Sang wrote:
> 
> Regarding the I2C-driver, I will try to clean up things as I see them.
> 
> > Is there some reason why Jean or the I2C mailing list couldn't have been
> > sent this driver instead of just Ben (or was it, and they didn't respond)?
> 
> It was sent to the I2C list a couple of times (although sometimes Darius
> made two posts, one to alkml and one to linux-i2c; probably a forgotten
> CC, but it makes things a bit hard to track). It got quite some comments
> there and the latest version, from what I can see, is here:
> 
> http://article.gmane.org/gmane.linux.drivers.i2c/2962
> 
> (which is _not_ the version Darius was posting in the last two days).
> 
> As you can see, it was already reviewed and tested here at Pengutronix,
> and it works for us with MX1/2/3. IMHO, it just needs one to pick it up,
> preferably via an I2C-tree. Now, as Ben volunteered to be the
> I2C-embedded-maintainer, we were all waiting for him to put it into his
> tree (for 6 weeks now; we were nagging). As he really seems to have
> disappeared I wonder if Jean can pick it up this time?

If that is really the patch you want, i'll add it to my tree and push
it.
 
> Regards,
> 
>    Wolfram
> 
> -- 
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |



-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
