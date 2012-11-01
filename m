From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: remove broken PIOQUEUE support
Date: Thu, 1 Nov 2012 15:28:17 +0100
Message-ID: <201211011528.17596.marex@denx.de>
References: <1351771003-6071-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1351771003-6071-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Wolfram Sang,

> This I2C master can do DMA and PIOQUEUE (PIO with FIFO). Originally,
> only PIOQEUE

PIOQUEUE ;-)

> was supported, then DMA support was added. The original
> intention was to keep PIOQUEUE since it has less overhead what is nice
> for small transfers. However, runtime switching between PIOQEUE and DMA
> depending on the transfer size never worked despite a lot of trying.
> Since PIOQUEUE mode itself was flaky (polling at places where interrupts
> failed to work) and the implementation also imposed a size limit for
> transfers, it is best to remove the support altogether which makes the
> driver a lot cleaner and more robust. If somebody really wants less
> overhead, plain PIO mode could still be implemented with the addidtional
> advantage that this mode is also available on MX23, too.

Yes, looks to be the way to go.

Reviewed-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>

Thanks

[...]

Best regards,
Marek Vasut
