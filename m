From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the
 OpenBlocks AX3-4 board
Date: Fri, 10 Jan 2014 16:14:17 -0500
Message-ID: <20140110211417.GX19878@titan.lakedaemon.net>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
 <20140110182240.GK19878@titan.lakedaemon.net>
 <20140110190521.GI18269@obsidianresearch.com>
 <20140110194550.GT19878@titan.lakedaemon.net>
 <20140110200813.GV19878@titan.lakedaemon.net>
 <52D05439.7040905@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52D05439.7040905-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 10, 2014 at 09:12:41PM +0100, Gregory CLEMENT wrote:
> Jason,
> On 10/01/2014 21:08, Jason Cooper wrote:
> > On Fri, Jan 10, 2014 at 02:45:50PM -0500, Jason Cooper wrote:
> >> On Fri, Jan 10, 2014 at 12:05:21PM -0700, Jason Gunthorpe wrote:
> >>> On Fri, Jan 10, 2014 at 01:22:40PM -0500, Jason Cooper wrote:
> >>>
> >>>> Do we create new compatible strings to indicate errata, or to indicate
> >>>> 'from this version forward there are new features'?  The former would
> >>>> indicate as Gregory has written '...-a0-i2c', the latter would warrant
> >>>> '...-b0-i2c' and disabling offloading if we don't see '...-b0-i2c'.
> >>
> >> s/-b0-i2c'./-b0-i2c' or newer./
> >>
> >>> IMHO the compatible string should represent a specific HW/SW ABI. So
> >>> you need a unique compatible string for every variation of that ABI.
> >>
> >> My concern is that we tend to do things like "marvell,orion-sata" for
> >> the first version of the IP block we can work with.  orion5x, kirkwood,
> >> dove, and armada 370/xp all use that compatible string to refer to that
> >> IP block.
> >>
> >> Given that we look at it as 'and newer', '...-a0-i2c' would mean no
> >> offloading until we introduce '-b0-i2c'.  Or am I mis-understanding what
> >> you're saying?
> >>
> >>> We already have a compatible string defined for the ABI that B0
> >>> presents.
> >>
> >> So 'mv78230-i2c' is newer than 'mv78230-a0-i2c', or are you referring to
> >> something else?
> > 
> > I think the crux of it is:  Is mv78230-i2c the first, or the default?
> 
> Here it's clearly the default

So we should default to no offloading when we see it?  Since it has been
deployed referring to -a0 revision i2c IP blocks?

thx,

Jason.
