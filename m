From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-pca-platform: Change device name of
 request_irq
Date: Tue, 19 Oct 2010 11:55:05 +0200
Message-ID: <20101019115505.465f54e1@endymion.delvare>
References: <1287456331-20207-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
	<20101019025406.GD3485@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101019025406.GD3485-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 19 Oct 2010 04:54:06 +0200, Wolfram Sang wrote:
> Hi Nobuhiro (long time no see :))!
> 
> On Tue, Oct 19, 2010 at 11:45:31AM +0900, Nobuhiro Iwamatsu wrote:
> > i2c->adap.name shouldn't be used in request_irq.
> > Instead the driver name "i2c-pca-platform" should be used.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> 
> Looks good to me, thanks for fixing it (and to Jean for the guidance)
> 
> Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied, thanks.

-- 
Jean Delvare
