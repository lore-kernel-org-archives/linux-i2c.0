From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 8/9] spi: prepare runtime PM support for SPI devices
Date: Thu, 12 Sep 2013 15:20:19 +0300
Message-ID: <20130912122019.GR7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <20130912093145.GA29403@sirena.org.uk>
 <20130912094302.GM7393@intel.com>
 <14222641.vVF4lKBqCB@vostro.rjw.lan>
 <20130912110322.GB3367@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130912110322.GB3367@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 12, 2013 at 01:04:28PM +0200, Wolfram Sang wrote:
> On Thu, Sep 12, 2013 at 01:04:55PM +0200, Rafael J. Wysocki wrote:
> > On Thursday, September 12, 2013 12:43:02 PM Mika Westerberg wrote:
> > > On Thu, Sep 12, 2013 at 10:31:45AM +0100, Mark Brown wrote:
> > > > On Thu, Sep 12, 2013 at 12:27:43PM +0300, Mika Westerberg wrote:
> > > > > On Wed, Sep 11, 2013 at 04:51:20PM +0100, Mark Brown wrote:
> > > > 
> > > > > > I would be able to have this and the other patch in the SPI tree in case
> > > > > > it overlaps with other work - I'm not sure what the plan will be for
> > > > > > merging this stuff but if there were a branch which I could merge into
> > > > > > the SPI tree that'd be good.
> > > > 
> > > > > I think these two can go via your SPI tree as they shouldn't have
> > > > > dependencies to the I2C tree.
> > > > 
> > > > There's all the driver changes though - it seems best to push the whole
> > > > series through one branch so there's fewer bisection problems.
> > > 
> > > Ah, right. Then I suppose the right tree would be the I2C tree (as majority
> > > of the patches are I2C related)?
> > > 
> > > Wolfram, are you OK with this?
> > 
> > Alternatively, I can apply them too if everyone is OK with that.
> > 
> > They are PM+ACPI changes after all ...
> 
> I'd like to give at least an ACK. But I need to find some time for that.
> Is it urgent? Looks like 3.13 material to me...

It's not urgent. Please take your time.
