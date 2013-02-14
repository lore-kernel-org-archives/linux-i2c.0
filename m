From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: vt8500: Add support for Wondermedia I2C master-mode
Date: Thu, 14 Feb 2013 11:01:15 +0100
Message-ID: <20130214100115.GA12290@nekote.pengutronix.de>
References: <1358315546-2201-1-git-send-email-linux@prisktech.co.nz>
 <1358315546-2201-2-git-send-email-linux@prisktech.co.nz>
 <20130213201307.GA8795@nekote.pengutronix.de>
 <1360798864.18078.21.camel@gitbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360798864.18078.21.camel@gitbox>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Cc: Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Tony,

> 1) I am working on pinmux at the moment - will hold off on this driver
> until pinmux is completed.

Cool, great work!

> 2)
> > +	i2c_dev->clk = of_clk_get(np, 0);
> > 
> > There is also devm_clk_get.
> devm_clk_get requires a 'clock name'.
> Since vt8500 is DT-only, and clock-names is an optional property in the
> clocks binding I preferred not to *require* an optional property.

OK then. Just wanted to mention it.

Thanks,

   Wolfram
