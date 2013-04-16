From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: use of_alias_get_id to order i2c devices
Date: Tue, 16 Apr 2013 11:25:49 +0200
Message-ID: <1366104349.4031.2.camel@pizza.hi.pengutronix.de>
References: <1365527379-17786-1-git-send-email-p.zabel@pengutronix.de>
	 <20130416091359.GB16978@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130416091359.GB16978-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Am Dienstag, den 16.04.2013, 11:17 +0200 schrieb Wolfram Sang:
> On Tue, Apr 09, 2013 at 07:09:39PM +0200, Philipp Zabel wrote:
> > This allows to order i2c character devices as they are numbered
> > in the reference manual, instead of ordering them by register
> > base address.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> ee5c27440cc24d62ec463cce4c000bb32c5692c7 in i2c/for-next does this on
> core level.

Excellent, thanks!

regards
Philipp
