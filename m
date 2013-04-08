From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 1/3] i2c: mxs: always end a transfer with a proper STOP
Date: Mon, 8 Apr 2013 19:21:47 +0200
Message-ID: <20130408172147.GB6865@the-dreams.de>
References: <1363261750-26645-1-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1363261750-26645-1-git-send-email-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 14, 2013 at 12:49:08PM +0100, Lucas Stach wrote:
> Our transfers always start with the device address, so there is never a
> situation where we just do a restart transfer. Full blown transfers should
> always end with a STOP as per i2c spec.

? I don't get the description. Does "restart transfer" mean repeated
start? What has the device address to do with it?
