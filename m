From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [RFC PATCH 0/3]  Fix i2c bus hang on A0 version of the Armada XP
 SoCs
Date: Wed, 1 Jan 2014 20:28:16 +0100
Message-ID: <20140101192816.GP32537@lunn.ch>
References: <1388508293-9141-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388508293-9141-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 31, 2013 at 05:44:50PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> This series is an RFC to fix the i2c bus hang on A0 version of the
> Armada XP SoCs. It occured on the the eraly release of the OpenBlocks
> AX3-4 bords. Indeed the first variants of Armada XP SoCs (A0 stepping)
> have issues related to the i2c controller which prevent to use the
> offload mechanism and lead to a kernel hang during boot.
> 
> The best solution will be to detect the SoCs version at runtime and
> use it in the driver, but I chosed to submit this version in case CPU
> version detection feature takes more time than expected (and we
> already reached the rc6 kernel).
> 
> Thanks,
> 
> Gregory

Hi Gregory

Thanks for these RFC patches. I can confirm they work on my Openblocks
device with an A0 stepping SoC. I can now access the RTC.

You missed adding the new DTS file to the Makefile. Depending on how
the discussion goes about auto detecting stepping or not, i would of
used different filenames, probably:

armada-xp-openblocks-ax3-4.dts
armada-xp-openblocks-ax3-4-a0.dts
armada-xp-openblocks-ax3-4-common.dts

Keeps all the files together when listed alphabetically

Thanks
	Andrew
