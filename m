From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: mv64xxx: Fix bus hang on A0 version of the Armada XP SoCs
Date: Tue, 7 Jan 2014 10:03:30 +0100
Message-ID: <201401071003.31309.arnd@arndb.de>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com> <201401051533.58931.arnd@arndb.de> <52CA72BF.10604@free-electrons.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52CA72BF.10604-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Monday 06 January 2014, Gregory CLEMENT wrote:
> > Relying on the soc id patch for a "stable" bug fix seems a little
> > far-reaching to me. I would be happier to first try to do a local
> > detection based on the i2c bus device node itself. Do you know how
> 
> It was my first proposal in case adding the soc id detection was
> a too big things. But it turned out that the amount of code is very
> low so I really think it worth adding it along the fix. Device tree
> is supposed to be stable so as soon as we add something in it we are
> supposed support it forever. Moreover using device tree for something
> we can probe is counter productive.

I would still be happier if we did both and only need to check the
SoC version if the device is in the "possibly broken" category
but default to the existing behavior.

My main concern is that this patch is adding platform code that we'd
otherwise have to carry in the kernel indefinitely. I agree that
it's best if we can probe stuff automatically, but that doesn't normally
mean looking at an unrelated piece of information. If the i2c controller
registers themselves tell us whether this device is broken or not,
we should use that information. Looking at a global SoC version register
however is more like checking a board ID in the pre-DT days where the
board number is the only information we have and everything is
derived from that.

> > common the A0 revision is? You mention "early release of the
> > OpenBlocks AX3-4 boards". Any others that you suspect? If not,
> 
> No, from the info I gathered I expected that only OpenBlocks AX3-4
> would be the only product shipped with an A0 version and as I said
> it should be only a limit amount of them.

Ok, good. So we really only need to worry about this one board for
now and can make all the others default to normal operation without
checking the SoC version.

Another idea: Could we have a quirk in the mvebu platform code for
the AX3-4 to check the SoC version and then change the property for
the i2c controller based on whether we expect it to work or not?
This way, we wouldn't even need an interface between the platform
code and the driver code.

	Arnd
