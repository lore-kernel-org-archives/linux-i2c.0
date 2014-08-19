From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] I2C/ACPI: Fix possible ZERO_SIZE_PTR pointer
 dereferencing error.
Date: Tue, 19 Aug 2014 18:48:18 +0300
Message-ID: <20140819154555.GW1660@lahna.fi.intel.com>
References: <1407810818-33672-1-git-send-email-Li.Xiubo@freescale.com>
 <20140819150355.GD15371@katana>
 <20140819151604.GU1660@lahna.fi.intel.com>
 <20140819153808.GE15371@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140819153808.GE15371@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 19, 2014 at 10:38:08AM -0500, Wolfram Sang wrote:
> On Tue, Aug 19, 2014 at 06:16:49PM +0300, Mika Westerberg wrote:
> > On Tue, Aug 19, 2014 at 10:03:55AM -0500, Wolfram Sang wrote:
> > > On Tue, Aug 12, 2014 at 10:33:38AM +0800, Xiubo Li wrote:
> > > > Since we cannot make sure the 'data_len' will always be none zero here,
> > > > and then if 'data_len' equals to zero, the kzalloc() will return ZERO_SIZE_PTR,
> > > > which equals to ((void *)16).
> > > 
> > > I assume the read request with length == 0 comes from a broken BIOS?
> > 
> > I'm also interested. Does this trigger in a real system?
> 
> Even if not now, we should consider potentially broken BIOSes, or? Which
> extends the question to: Do we need even more sanity checks when taking
> broken BIOSes into account?

Typically ACPICA has done this work for us (e.g it fixes things upfront
so that we get sane data). I'm not sure if it does that for I2C
Operation Regions, though (that's why I'm asking if it happens in a real
system or is this more like a theoretical possibility).

Tianyu, any comments?
