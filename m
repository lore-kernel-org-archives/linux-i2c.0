From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v10] i2c-designware: make SDA hold time configurable
Date: Wed, 3 Jul 2013 16:44:09 +0200
Message-ID: <201307031644.09669.arnd@arndb.de>
References: <20130625163902.GA2973@katana> <20130703143835.GD3929@ab42.lan> <201307031642.30380.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201307031642.30380.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: vincent.stehle-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 03 July 2013, Christian Ruppert wrote:
> On Wed, Jul 03, 2013 at 04:20:03PM +0200, Arnd Bergmann wrote:
> > On Wednesday 03 July 2013, Christian Ruppert wrote:
> > > On Wed, Jul 03, 2013 at 01:43:11PM +0200, Arnd Bergmann wrote:
> > > > On Wednesday 26 June 2013, Wolfram Sang wrote:
> > > > >   On Wed, Jun 26, 2013 at 10:55:06AM +0200, Christian Ruppert wrote:
> > > > > > This patch makes the SDA hold time configurable through device tree.
> > > > > > 
> > > > > > Signed-off-by: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > > > > > Signed-off-by: Pierrick Hascoet <pierrick.hascoet-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
> > > > > 
> > > > > Applied to for-next, thanks for keeping at it and providing lots of
> > > > > useful information. Much appreciated!
> > > > 
> > > > Sorry, but I got a regression that I didn't find reported elsewhere
> > > > so far, even though it breaks a lot of the ARM defconfig builds:
> > > > 
> > > > drivers/built-in.o: In function `dw_i2c_probe':
> > > > /git/arm-soc/drivers/i2c/busses/i2c-designware-platdrv.c:125: undefined reference to `__udivdi3'
> > > > 
> > > > I suspect you want something like the change below.
> > > 
> > > This looks similar to a patch Vincent Stehle submitted yesterday, see
> > > https://lkml.org/lkml/2013/7/2/145
> > 
> > Thanks for the link. Actually his patch looks wrong to me, because
> > 
> >  dev->sda_hold_time = div_u64((u64)ic_clk * ht + 500000, 1000000); 
> > 
> > assigns the division remainder to sda_hold_time, not the quotient.
> 
> Hrmmm... At least when I tested it this morning on an ARC architecture
> it worked as intended and returned the quotient. Does that mean we have
> an issue with this function on ARC? Can anyone who knows these functions
> better than I comment?

ARC just uses the generic version of div_u64, which is defined in lib/div64.c.

I suspect that the division remainder just happens to work well enough for
you to not cause any run-time error. You could try adding a printk
in that function to show the values you get on ARC.

	Arnd
 
