From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
Date: Mon, 6 Jan 2014 00:51:55 +0100
Message-ID: <20140105235155.GB4093@lunn.ch>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de>
 <20140105154023.GA2048@lunn.ch>
 <201401052017.10982.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201401052017.10982.arnd-r2nGTMty4D4@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Jan 05, 2014 at 08:17:10PM +0100, Arnd Bergmann wrote:
> On Sunday 05 January 2014, Andrew Lunn wrote:
> > That would be rather odd. These nodes are in the top level SoC dtsi
> > file. When they are not used, they have status = "disabled" and are in
> > the dtb blob with this state.
> > 
> > The only reason i can think of them not being present at all is if
> > somebody adds an optimizer to dtc which removed disabled nodes. What
> > does the device tree spec say about that? Are we relying on undefined
> > dtc behavior?
> 
> There is no requirement to use the include files. If someone decides
> to ship a default dtb file in their boot loader, it wouldn't be
> a bug to leave the nodes out entirely.

Hum, yes, interesting.

This raises the question, should mainline try to support any random
dtb blob, or only those that have ever shipped with mainline?

There are some older mainline DT blobs which won't have PCIe in them,
since PCIe support was not there day 1. So returning -ENODEV, and the
i2c controller assuming an A0 would make sense.

But what should we do if somebody was to boot linux with a FreeBSD DT
blob? It is a valid blob, it describes the hardware, but the FreeBSD
nodes have different compatibility strings, don't have clocks, etc.
Now that is at the extreme of the range, but where do we put the
marker for compatibility in this range from current mainline blobs to
FreeBSD blobs?

Andrew
