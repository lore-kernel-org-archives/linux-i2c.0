From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
Date: Sat, 23 Jun 2012 20:19:34 +0200
Message-ID: <201206232019.34829.marex@denx.de>
References: <1339242351-8797-1-git-send-email-marex@denx.de> <201206111253.17314.marex@denx.de> <20120611144237.GI2552@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120611144237.GI2552-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Shawn Guo,

> On Mon, Jun 11, 2012 at 12:53:17PM +0200, Marek Vasut wrote:
> > Ok, then can you please try asking them how to exactly compute the values
> > in timing0-timing2 registers? So we don't have to hardcode them like
> > it's done now?
> 
> It's determined I2C clock waveform you want to get.  See i.MX28 RM
> "Figure 27-2. I2C Data and Clock Timing" and "Figure 27-3. I2C Data
> and Clock Timing Generation".
> 
> For example, if you run 12MHz APBX clock, and set HIGH_COUNT to 60,
> the I2C clock will have 60 cycle x (1/12MHz) = 5us time for its high
> period.

Ok, I think I see the equation. But what still doesn't make sense is how you got 
to the value of 48 (RCV_COUNT at 95kHz). And how you got 120 for HIGH_COUNT and 
128 for LOW_COUNT?

Were these values based on some measurements, making them the best possible 
values? Won't computation of slightly different values affect reliability of 
this driver?

Best regards,
Marek Vasut
