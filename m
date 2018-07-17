From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for a bus clock
Date: Tue, 17 Jul 2018 15:23:35 +0300
Message-ID: <c6b21734b729cb5f92a5686ae3fa8469692a1302.camel@linux.intel.com>
References: <1531731553-22979-1-git-send-email-phil.edworthy@renesas.com>
         <1531731553-22979-3-git-send-email-phil.edworthy@renesas.com>
         <20180717120737.bipotpki3yhn6klf@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717120737.bipotpki3yhn6klf@verge.net.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Phil Edworthy <phil.edworthy@renesas.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-07-17 at 14:07 +0200, Simon Horman wrote:
> On Mon, Jul 16, 2018 at 09:59:13AM +0100, Phil Edworthy wrote:
> > The Synopsys I2C Controller has a bus clock, but typically SoCs hide
> > this away.
> > However, on some SoCs you need to explicity enable the bus clock in
> > order to
> > access the registers.
> > Therefore, enable an optional bus clock specified by DT.

> > +		/* Optional bus clock */
> > +		if (!IS_ERR(dev->busclk)) {
> 
> I suspect that error values stored in dev->busclk,  other than
> -ENOENT,
> should be treated as errors.

While your point sounds valid (don't remember how clk_get() is
implemented), NULL is also OK to have.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
