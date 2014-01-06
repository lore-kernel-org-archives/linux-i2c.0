From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
Date: Mon, 6 Jan 2014 17:24:42 +0100
Message-ID: <20140106162442.GB13111@lunn.ch>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <201401052017.10982.arnd@arndb.de>
 <20140105235155.GB4093@lunn.ch>
 <201401061637.28194.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201401061637.28194.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> Are you saying that FreeBSD has a different set of bindings for the
> same hardware?

Yes. I was not even aware FreeBSD was using DT until somebody
mentioned it in Edinburgh. 

As an example:

http://fxr.watson.org/fxr/source/boot/fdt/dts/sheevaplug.dts

compared with

http://lxr.linux.no/linux+v3.12.6/arch/arm/boot/dts/kirkwood-sheevaplug.dts
http://lxr.linux.no/linux+v3.12.6/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
http://lxr.linux.no/linux+v3.12.6/arch/arm/boot/dts/kirkwood-6281.dtsi
http://lxr.linux.no/linux+v3.12.6/arch/arm/boot/dts/kirkwood.dtsi

> That would be rather unfortunate and we should probably
> try to merge the bindings eventually and make sure that either OS can
> boot with any conforming DTB

It probably requires one of the DT maintainers to talk to FreeBSD
equivalents to get some coordination going. We have a lot of generic
stuff, like gpio keys, gpio leds, cpu nodes, mtd partitions, etc,
which could be done at a high level, and then SoC specific nodes
sorted out between individual developers.
 
> On the example of missing clocks, it should work as long as all relevant
> clocks are enabled by the boot loader and the clock properties are
> optional the binding.

However, not all clocks are optional. We need the clock in order to
know how fast it ticks. So at least the serial ports and i2c will not
work, and maybe other devices, i would have to check.

	Andrew
