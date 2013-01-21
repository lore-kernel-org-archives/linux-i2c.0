From: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: Fix misuse init_completion
Date: Mon, 21 Jan 2013 04:47:46 +0100
Message-ID: <201301210447.46939.marek.vasut@gmail.com>
References: <1353475146-28669-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1353475146-28669-1-git-send-email-marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi,

> The init_completion() call does reinit not only the variable carrying
> the flag that the completion finished, but also initialized the
> waitqueue associated with the completion. On the contrary, the
> INIT_COMPLETION() call only reinits the flag.
> 
> In case there was anything still stuck in the waitqueue, subsequent call
> to init_completion() would be able to create possible race condition. This
> patch uses the proper function and moves init_completion() into .probe()
> call of the driver, to be issued only once.
> 
> Note that such scenario is impossible, since two threads can never enter
> the mxs_i2c_xfer_msg(), since whole this section is protected by mutex in
> I2C core. This by no means allows this issue to exit though.
> 
> Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
> Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Why is this not applied / not in stable please?

Also, what about the other MXS I2C patches?

Thanks!

Best regards,
Marek Vasut
