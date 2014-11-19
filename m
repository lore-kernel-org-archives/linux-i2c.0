From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] i2c: designware: prevent early stop on TX FIFO empty
Date: Wed, 19 Nov 2014 16:18:34 +0200
Message-ID: <20141119141834.GJ1309@lahna.fi.intel.com>
References: <545CB6C4.8010201@arm.com>
 <20141119092122.GC1439@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141119092122.GC1439@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, "Du, Wenkai" <wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, Romain Baeriswyl <Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 19, 2014 at 10:21:22AM +0100, Wolfram Sang wrote:
> On Fri, Nov 07, 2014 at 12:10:44PM +0000, Andrew Jackson wrote:
> > If the Designware core is configured with IC_EMPTYFIFO_HOLD_MASTER_EN
> > set to zero, allowing the TX FIFO to become empty causes a STOP
> > condition to be generated on the I2C bus. If the transmit FIFO
> > threshold is set too high, an erroneous STOP condition can be
> > generated on long transfers - particularly where the interrupt
> > latency is extended.

Makes sense to give some slack so that the interrupt handler is still
able to fill the FIFO.

> > 
> > Signed-off-by: Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
> 
> So, what do other designware users think of this change (nice CC list
> BTW, Andrew). Adding Mika, too.

I quickly tested this on Haswell machine with touch screen connected to
the I2C bus and it still works fine, so

Tested-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
