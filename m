From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-au1550: increase timeout waiting for transactions
	to finish
Date: Wed, 15 Jun 2011 22:40:09 +0100
Message-ID: <20110615214009.GJ15795@trinity.fluff.org>
References: <1307881887-12676-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1307881887-12676-1-git-send-email-manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Linux-I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sun, Jun 12, 2011 at 02:31:27PM +0200, Manuel Lauss wrote:
> Wait a bit longer for the I2C master transaction to finish.
> With this change the WM8731 codec on the DB1300 board is now
> reliably initialized.
> 
> Tested on Db1200 and Db1300.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

If no-one else can think of a better fix, then this can go into -rc.

Is there no register that could be read to find out if the system is
busy?

> ---
>  drivers/i2c/busses/i2c-au1550.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
> index 532828b..e4ece23 100644
> --- a/drivers/i2c/busses/i2c-au1550.c
> +++ b/drivers/i2c/busses/i2c-au1550.c
> @@ -106,7 +106,7 @@ wait_master_done(struct i2c_au1550_data *adap)
>  		au_sync();
>  		if ((stat & PSC_SMBEVNT_MD) != 0)
>  			return 0;
> -		udelay(1);
> +		udelay(2);
>  	}
>  
>  	return -ETIMEDOUT;
> -- 
> 1.7.5.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
