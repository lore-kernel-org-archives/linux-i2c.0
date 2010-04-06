From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] drivers: i2c-gpio: move initialization code
 subsys_initcall()
Date: Tue, 06 Apr 2010 08:49:36 +0200
Message-ID: <000001cad555$556c2e50$00448af0$%szyprowski@samsung.com>
References: <1270129399-30365-1-git-send-email-m.szyprowski@samsung.com>
 <20100401134917.GF24265@pengutronix.de>
 <20100401163018.5494f19b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20100401163018.5494f19b-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-language: pl
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Jean Delvare' <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: 'Wolfram Sang' <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Ben Dooks' <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, 'Mark Brown' <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hello,

On Thursday, April 01, 2010 4:30 PM Jean Delvare wrote:

> On Thu, 1 Apr 2010 15:49:18 +0200, Wolfram Sang wrote:
> > On Thu, Apr 01, 2010 at 03:43:19PM +0200, Marek Szyprowski wrote:
> > > GPIO driven I2C bus can be used for controlling the PMIC chip. The example
> > > of such configuration is Samsung Aquila board.
> > >
> > > This patch moves initialization code subsys_initcall() to ensure that the i2c
> > > bus is available early so the regulators can be quicly probed and available for
> >
> > Minor: quickly
> >
> > > other devices on their probe() call.
> > >
> > > Such solution has been proposed by Mark Brown to fix the problem of the
> > > regulators not beeing available on the peripheral device probe():
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011971.html
> > >
> > > CC: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> > > Reviewed-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >
> > Yup, a number of drivers do this:
> >
> > Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> Applied, thanks. Is it desirable to have this patch in 2.6.34, or is
> 2.6.35 enough?

2.6.35 would be enough. Thanks :)

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
