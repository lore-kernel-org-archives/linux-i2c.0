From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: mxs: Slow down the I2C clock speed
Date: Tue, 2 Apr 2013 19:28:52 +0800
Message-ID: <20130402112850.GD24039@S2101-09.ap.freescale.net>
References: <1364858969-17745-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1364858969-17745-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Marek,

On Tue, Apr 02, 2013 at 01:29:29AM +0200, Marek Vasut wrote:
> Slow down the I2C clock speed on M28 and SPS1 as it turns out the
> I2C block in i.MX28 can not operate stable enough with the bus
> running at 400kHz. Note that the driver used by Freescale runs
> the bus at 250kHz when 400kHz speed is selected, but the mainline
> Linux kernel runs the bus at actual 400kHz and that's where it is
> occasionally unstable. Play safe and run the bus at 100kHz.
> 
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

You consider it a fix for 3.9 or just material for 3.10?

Shawn
