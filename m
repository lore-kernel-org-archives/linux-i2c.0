From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: boardinfo: Fix typo in comment
Date: Sat, 12 Feb 2011 19:01:55 +0100
Message-ID: <20110212190155.2736c789@endymion.delvare>
References: <1297531065-5821-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297531065-5821-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 12 Feb 2011 18:17:45 +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> ---
> 
> Happened to stumble over this today, didn't find any other typos here.
> 
>  drivers/i2c/i2c-boardinfo.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-boardinfo.c b/drivers/i2c/i2c-boardinfo.c
> index 7e6a63b..3ca2e01 100644
> --- a/drivers/i2c/i2c-boardinfo.c
> +++ b/drivers/i2c/i2c-boardinfo.c
> @@ -1,5 +1,5 @@
>  /*
> - * i2c-boardinfo.h - collect pre-declarations of I2C devices
> + * i2c-boardinfo.c - collect pre-declarations of I2C devices
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by

Applied, thanks!

-- 
Jean Delvare
