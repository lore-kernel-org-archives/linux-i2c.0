From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: PCA9564: "bus is not idle" issue
Date: Sat, 3 Apr 2010 20:23:29 +0200
Message-ID: <20100403202329.3bdb407c@hyperion.delvare>
References: <f69abfc31003170559y3c0a5a6fi91c1ae7692700c66@mail.gmail.com>
	<20100403162939.GA2190@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100403162939.GA2190-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 3 Apr 2010 18:29:39 +0200, Wolfram Sang wrote:
> On Wed, Mar 17, 2010 at 01:59:03PM +0100, Yegor Yefremov wrote:
> > Hi,
> > 
> > I'm using PCA9564 attached to a ks8695 SoC. During my efforts to get
> > 2.6.33/34 running on my system I noticed sporadic problems with RTC:
> 
> [...]
> 
> > static struct i2c_pca9564_pf_platform_data  __initdata pca_data ={
> > 	    .gpio = -1,
> > 	    .i2c_clock_speed = 59000,
> > 	    .timeout = 1,
> > };
> 
> Commit 8e99ada8deaa9033600cd2c7d0a9366b0e99ab68 changed the timeout settings to
> jiffies. So, one jiffy as timeout will not work. Try 'HZ' here.
> 
> > before. Diffing i2c-algo-pca.c between 2.6.26 and 2.6.33 showed that
> > there were some minor changes regarding waiting policy in pca_xfer().
> > Could this be the reason for such behavior? Any idea?
> 
> You were almost there, just use 'git log' next time.

So this means the bug isn't in the mainline kernel tree and I can
ignore it?

As a side note, arch/blackfin/mach-bf561/boards/acvilon.c sets timeout
to 10000, so the actual timeout depends on the value of HZ, which is
probably not desirable. Not to mention that a timeout of over one
minute (worst case) doesn't seem too smart ;)

-- 
Jean Delvare
