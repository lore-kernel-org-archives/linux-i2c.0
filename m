From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c: at91: fix unsed variable warning when building with
 !CONFIG_OF
Date: Sun, 10 Feb 2013 19:41:00 +0100
Message-ID: <20130210184100.GD12760@nekote.pengutronix.de>
References: <1360433640-30160-1-git-send-email-manabian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1360433640-30160-1-git-send-email-manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Feb 09, 2013 at 07:14:00PM +0100, Joachim Eastwood wrote:
> Commit 70d46a2 "i2c: at91: add dt support to i2c-at91"
> added DT only support for at91sam9x5. Building i2c-at91
> without CONFIG_OF now warns about at91sam9x5_config as
> being unused.
> 
>   drivers/i2c/busses/i2c-at91.c:556:30: warning: 'at91sam9x5_config' defined but not used [-Wunused-variable]
> 
> Move at91sam9x5_config under the defined(CONFIG_OF)
> guard as new AT91 SoCs will be DT only.
> 
> Signed-off-by: Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks.
