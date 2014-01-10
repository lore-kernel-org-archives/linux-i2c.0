From: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the OpenBlocks
 AX3-4 board
Date: Fri, 10 Jan 2014 14:06:34 -0700
Message-ID: <20140110210634.GL18269@obsidianresearch.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
 <20140110182240.GK19878@titan.lakedaemon.net>
 <20140110190521.GI18269@obsidianresearch.com>
 <20140110194550.GT19878@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140110194550.GT19878-u4khhh1J0LxI1Ri9qeTfzeTW4wlIGRCZ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 10, 2014 at 02:45:50PM -0500, Jason Cooper wrote:

> > IMHO the compatible string should represent a specific HW/SW ABI. So
> > you need a unique compatible string for every variation of that ABI.
> 
> My concern is that we tend to do things like "marvell,orion-sata" for
> the first version of the IP block we can work with.  orion5x, kirkwood,
> dove, and armada 370/xp all use that compatible string to refer to that
> IP block.

Right, absent guidance from the originators of the IP block that is
sort of all we are left with. But something like 'marvell,orion-sata'
is just a label to describe the ABI implemented by the HW on that
particular chip.

> Given that we look at it as 'and newer', '...-a0-i2c' would mean no
> offloading until we introduce '-b0-i2c'.  Or am I mis-understanding what
> you're saying?

I would stop thinking of this in terms of 'is newer' / 'is older'.

marvell,orion-sata means any HW that implements the same ABI as the
orion chip. 

When we get a different chip that has a compatible, but extended ABI
we introduce a new label:

 compatible = "marvell,foobar-sata", "marvell,orion-sata";

And if we get one that has a very similar, but incompatible ABI, we
still introduce a new label:

 compatible = "marvell,foobar2-sata";

And everything works properly.

> > We already have a compatible string defined for the ABI that B0
> > presents.
> 
> So 'mv78230-i2c' is newer than 'mv78230-a0-i2c', or are you referring to
> something else?

'mv78230-i2c' is the name that was picked to describe the ABI that
works as-documented in the manual
'mv78230-a0-i2c' is the name that was picked to describe the ABI that
works as-implemented in the A0 chip :)

There is no newer/older, they are just two different ABIs.

I guess it turns out that 'mv78230-a0-i2c' is a strict compatible
subset of 'mv78230-i2c' - but that doesn't really make a difference.

The 'mv78230-i2c' driver is guarenteed avaialble in all places where
the 'mv78230-a0-i2c' driver would be available.

Jason
