From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 2/3] i2c: mxs: remove races in PIO code
Date: Tue, 2 Apr 2013 00:58:41 +0200
Message-ID: <201304020058.41519.marex@denx.de>
References: <1363261750-26645-1-git-send-email-l.stach@pengutronix.de> <1363261750-26645-2-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1363261750-26645-2-git-send-email-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Lucas Stach,

sorry for the delay, I'm totalled ... well, trying to make it through the queue 
now.

CC Fabio on MXS patches please.

[...]

> -static int mxs_i2c_pio_wait_cplt(struct mxs_i2c_dev *i2c)
> +static int mxs_i2c_pio_wait_cplt(struct mxs_i2c_dev *i2c, int last)

You can use bool instead of int here and then use "true"/"false" below.

Best regards,
Marek Vasut
