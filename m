From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-smbus: Use module_i2c_driver()
Date: Tue, 3 Jul 2012 16:49:09 +0200
Message-ID: <20120703164909.3308fa34@endymion.delvare>
References: <1341243196-25656-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341243196-25656-1-git-send-email-fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2 Jul 2012 12:33:16 -0300, Fabio Estevam wrote:
> Using module_i2c_driver() makes the code smaller and cleaner.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/i2c/i2c-smbus.c |   13 +------------
>  1 files changed, 1 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> index 9836d08..df3e0bf 100644
> --- a/drivers/i2c/i2c-smbus.c
> +++ b/drivers/i2c/i2c-smbus.c
> @@ -245,18 +245,7 @@ int i2c_handle_smbus_alert(struct i2c_client *ara)
>  }
>  EXPORT_SYMBOL_GPL(i2c_handle_smbus_alert);
>  
> -static int __init i2c_smbus_init(void)
> -{
> -	return i2c_add_driver(&smbalert_driver);
> -}
> -
> -static void __exit i2c_smbus_exit(void)
> -{
> -	i2c_del_driver(&smbalert_driver);
> -}
> -
> -module_init(i2c_smbus_init);
> -module_exit(i2c_smbus_exit);
> +module_i2c_driver(smbalert_driver);
>  
>  MODULE_AUTHOR("Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>");
>  MODULE_DESCRIPTION("SMBus protocol extensions support");

Applied, thanks.

-- 
Jean Delvare
