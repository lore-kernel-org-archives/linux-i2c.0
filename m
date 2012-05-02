From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/11] ASoC: fsl: add sgtl5000 clock support for
 imx-sgtl5000
Date: Wed, 2 May 2012 20:12:24 +0800
Message-ID: <20120502121222.GZ2194@S2101-09.ap.freescale.net>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-4-git-send-email-richard.zhao@freescale.com>
 <20120501134446.GK2194@S2101-09.ap.freescale.net>
 <20120502105024.GC2982@b20223-02.ap.freescale.net>
 <20120502114121.GB5722@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120502114121.GB5722-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, Richard Zhao <richard.zhao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 02, 2012 at 12:41:22PM +0100, Mark Brown wrote:
> We generally try to keep the clock API out of CODEC drivers due to the
> issues with the clock API that the generic implementation is intended to
> help us solve.
> 
> The major problem here is that we can't rely on having the clock API
> present at all on most platforms so as soon as we start adding clock
> support into things we have to do a performance with HAVE_CLK which is
> at best annoying.
> 
Is this something that the series below tries to solve?

http://thread.gmane.org/gmane.linux.ports.arm.kernel/163652

Regards,
Shawn

> There's also the fact that even if the clock API is available we've no
> way to register a clock consistently and since the audio clock tree
> often needs management off-SoC for at least some components when the
> clock API is in use you end up having to handle clock trees that go into
> and out of the clock API.
> 
> The upshot of this is that while we really should be using the clock API
> for clocks the API as it stands is somewhat difficult to deploy in cross
> platform code.  What I'd suggest is connecting the clock to the CODEC in
> the device tree but actually doing the clk_get() in the machine driver.
