From: Ben Dooks <ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c-bfin-twi: remove redundant retry
Date: Thu, 24 Dec 2009 01:25:37 +0000
Message-ID: <20091224012537.GA10442@fluff.org.uk>
References: <1261405713-7262-1-git-send-email-vapier@gentoo.org> <1261405713-7262-3-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1261405713-7262-3-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 21, 2009 at 09:28:32AM -0500, Mike Frysinger wrote:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Failed to apply, not had a look at why.
 
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-bfin-twi.c |   20 ++------------------
>  1 files changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
> index 3495019..d157105 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -357,15 +357,7 @@ static int bfin_twi_do_master_xfer(struct i2c_adapter *adap,
>  static int bfin_twi_master_xfer(struct i2c_adapter *adap,
>  				struct i2c_msg *msgs, int num)
>  {
> -	int i, ret = 0;
> -
> -	for (i = 0; i < adap->retries; i++) {
> -		ret = bfin_twi_do_master_xfer(adap, msgs, num);
> -		if (ret > 0)
> -			break;
> -	}
> -
> -	return ret;
> +	return bfin_twi_do_master_xfer(adap, msgs, num);
>  }
>  
>  /*
> @@ -573,16 +565,8 @@ int bfin_twi_smbus_xfer(struct i2c_adapter *adap, u16 addr,
>  			unsigned short flags, char read_write,
>  			u8 command, int size, union i2c_smbus_data *data)
>  {
> -	int i, ret = 0;
> -
> -	for (i = 0; i < adap->retries; i++) {
> -		ret = bfin_twi_do_smbus_xfer(adap, addr, flags,
> +	return bfin_twi_do_smbus_xfer(adap, addr, flags,
>  			read_write, command, size, data);
> -		if (ret == 0)
> -			break;
> -	}
> -
> -	return ret;
>  }
>  
>  /*
> -- 
> 1.6.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
