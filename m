From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v5 0/4] Fix i2c bus hang on A0 version of the Armada XP SoCs
Date: Wed, 08 Jan 2014 16:13:24 +0100
Message-ID: <4109972.QJJQdqxEL1@wuerfel>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389193589-18485-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wednesday 08 January 2014 16:06:25 Gregory CLEMENT wrote:
> Hi,
> 
> Here come the 5th version of the series fixing the i2c bus hang on A0
> version of the Armada XP SoCs. It occurred on the early release of the
> OpenBlocks AX3-4 boards. Indeed the first variants of Armada XP SoCs
> (A0 stepping) have issues related to the i2c controller which prevent
> to use the offload mechanism and lead to a kernel hang during boot.
> 
> The main change are the use of marvell,mv78230-a0-i2c and that the
> function mvebu_get_soc_id() is now local to mach-mvebu.
> 
> The first patch add a mean to detect the SoCs version at run-time and
> the second one use this feature in the driver.
> 
> The 3 first patches should be applied on 3.13-rc and on stable kernel
> 3.12 as it fixes a regression introduce by the commit 930ab3d403ae
> "i2c: mv64xxx: Add I2C Transaction Generator support".
> 
> The first patch could be latter be extend to also be used with dove,
> kirkwood, orion5x and mv78x00 when there will be merged in mvebu and
> even expose the SoC ID and revision to userspace.
> 
> Jason, do you still agree to take the series once Wolfram have given
> his acked-by?

Whole series

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
