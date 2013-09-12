From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 8/9] spi: prepare runtime PM support for SPI devices
Date: Thu, 12 Sep 2013 12:43:02 +0300
Message-ID: <20130912094302.GM7393@intel.com>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1378913560-2752-9-git-send-email-mika.westerberg@linux.intel.com>
 <20130911155120.GW29403@sirena.org.uk>
 <20130912092743.GK7393@intel.com>
 <20130912093145.GA29403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130912093145.GA29403-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <m.chehab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 12, 2013 at 10:31:45AM +0100, Mark Brown wrote:
> On Thu, Sep 12, 2013 at 12:27:43PM +0300, Mika Westerberg wrote:
> > On Wed, Sep 11, 2013 at 04:51:20PM +0100, Mark Brown wrote:
> 
> > > I would be able to have this and the other patch in the SPI tree in case
> > > it overlaps with other work - I'm not sure what the plan will be for
> > > merging this stuff but if there were a branch which I could merge into
> > > the SPI tree that'd be good.
> 
> > I think these two can go via your SPI tree as they shouldn't have
> > dependencies to the I2C tree.
> 
> There's all the driver changes though - it seems best to push the whole
> series through one branch so there's fewer bisection problems.

Ah, right. Then I suppose the right tree would be the I2C tree (as majority
of the patches are I2C related)?

Wolfram, are you OK with this?
