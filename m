From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
Date: Mon, 11 Jun 2012 22:42:40 +0800
Message-ID: <20120611144237.GI2552@S2101-09.ap.freescale.net>
References: <1339242351-8797-1-git-send-email-marex@denx.de>
 <201206101353.06018.marex@denx.de>
 <20120611073036.GG2552@S2101-09.ap.freescale.net>
 <201206111253.17314.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201206111253.17314.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 11, 2012 at 12:53:17PM +0200, Marek Vasut wrote:
> Ok, then can you please try asking them how to exactly compute the values in 
> timing0-timing2 registers? So we don't have to hardcode them like it's done now?
> 
It's determined I2C clock waveform you want to get.  See i.MX28 RM
"Figure 27-2. I2C Data and Clock Timing" and "Figure 27-3. I2C Data
and Clock Timing Generation".

For example, if you run 12MHz APBX clock, and set HIGH_COUNT to 60,
the I2C clock will have 60 cycle x (1/12MHz) = 5us time for its high
period.

-- 
Regards,
Shawn
