From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 0/3] i2c-mv64xxx: Fixes and new feature for controlers
 embedded in Aramda XP
Date: Tue, 20 Aug 2013 18:21:47 +0200
Message-ID: <5213979B.4050306@free-electrons.com>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376039158-1896-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 09/08/2013 11:05, Gregory CLEMENT wrote:
> Hello,
> 
> This new version just brings the handle of the "marvell,mv78230-i2"
> string as a single compatible string. As there were no other remarks
> since about 2 months I hope that this version will be able to be
> merged in 3.12.
> 
> This patch set adds support for the I2C Transaction Generator which
> offloads CPU from managing I2C transfer step by step. This feature is
> currently only available on the I2C controller IP embedded in the
> Armada XP SoC.
> 
> This series also contains a real fix for the I2C controller of the
> Armada XP SoC.
> 
> The first two patches modify the driver itself and should go through
> i2c subsystem.
> 
> The last patch updates the device tree to be able to use this new
> feature. I kept this patch in the series for having a coherent series,
> but it have already been pulled in the mvebu subsystem.
> 

Wolfram,

Jason Cooper drooped the third patch as it conflicted with a patch from
Maxime Ripard which adds the AllWinner support. Olof also asked a formal
acked-by from a device tree maintainer even if we already answer to
Mark Rutland request.

Olof also requested that you take the binding update, so I am going to send
a new version of this patch set with the last patch split in two parts.

As explained earlier today, unless you really want I use be32_to_cpu in the
mv64xxx_i2c_offload_msg() I won't change anything else.

Regards,

> Thanks,
> 
> Changelog:
> 
> v4-v5:
> 
>  - handle of the "marvell,mv78230-i2" string as a single compatible
>    string. Even it is strongly discouraged to use "marvell,
>    mv78230-i2" alone, it is better to be able to handle it.
> 
> 
> v3->v4:
> 
>  - reverse the order of the compatible strings, with the most
>    specific first
> 
>  - rebased on 3.11-rc1
> 
> v2->v3:
> 
>  - Introduces a new compatible string mv78230-i2c which will be used
>    for the fix and for the offload feature which are only present on
>    the Armada XP SoCs
> 
>  - Removes the unneeded spin_lock_irqsave pointed by Russell King
> 
>  - The offload mechanism is now port of the fsm and handle the
>    multiple messages.
> 
>  - The flag bridge-enabled is renamed to offload_enabled, but the
>    register name stills contains the BRIDGE word to match the
>    datasheet.
> 
>  - Uses writel_relaxed on the place pointed by Russell King
> 
>  - Uses the bool type for the flag (pointed by Thomas Petazzoni)
> 
>  - Removes useless code (pointed by Thomas Petazzoni)
> 
>  - Updates the bindings documentation
> 
> v1->v2:
>  - Move the flag for the timing issue from global scope to per device
>    scope
>  - Assignment is no more done in if condition
> 
> Gregory CLEMENT (3):
>   i2c-mv64xxx: Add I2C Transaction Generator support
>   i2c-mv64xxx: Fix timing issue on Armada XP (errata FE-8471889)
>   ARM: dts: mvebu: Introduce a new compatible string for mv64xxx-i2c
> 
>  .../devicetree/bindings/i2c/i2c-mv64xxx.txt        |  13 +-
>  arch/arm/boot/dts/armada-370-xp.dtsi               |   2 -
>  arch/arm/boot/dts/armada-370.dtsi                  |   8 +
>  arch/arm/boot/dts/armada-xp.dtsi                   |  10 +
>  drivers/i2c/busses/i2c-mv64xxx.c                   | 217 ++++++++++++++++++++-
>  5 files changed, 237 insertions(+), 13 deletions(-)
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
