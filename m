From: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
Date: Sun, 5 Jan 2014 16:40:09 -0700
Message-ID: <20140105234009.GC11280@obsidianresearch.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de>
 <20140105154023.GA2048@lunn.ch>
 <20140105172756.GA11280@obsidianresearch.com>
 <52C99851.70806@gmail.com>
 <20140105230746.GB11280@obsidianresearch.com>
 <52C9E6D0.3000406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52C9E6D0.3000406-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 06, 2014 at 12:12:16AM +0100, Sebastian Hesselbarth wrote:
> On 01/06/2014 12:07 AM, Jason Gunthorpe wrote:
> >On Sun, Jan 05, 2014 at 06:37:21PM +0100, Sebastian Hesselbarth wrote:
> >
> >>If you mean clock-gated with "powered down", the code is safe. It
> >>enables the clock gate prior reading from the controller. Or is there
> >>another way to power down the controller, so you cannot read from the
> >>controller registers?
> >
> >There is a clock gate and a power down on kirkwood at least, Linux has
> >no code for controlling the powerdown
> 
> Does that power down really disable reading from PCIe controller
> registers or is it just PHY power down?

I haven't experimented with it, but every block that has a clock gate
has a power down, so I doubt it is just a phy power down.

> >In any event, I think processing a disabled DT node is not great..
> 
> Yeah, but you see another way to get the PCIe controller registers
> instead? Or any other common id register to read? IMHO PCIe ids are
> the best we can find here and Gregory found the first IP that really
> depends on the SoC revision..

I don't know of another option off hand, unless something is encoded
in the CPU ID register set.

Encoding the IP block version in the I2C DT compatible string is the
next best choice, but it obviously isn't automatic..

Jason
