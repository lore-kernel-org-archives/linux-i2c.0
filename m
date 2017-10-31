From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 08/15] drm/i2c: tda998x: Remove duplicate NULL check
Date: Tue, 31 Oct 2017 17:03:43 +0000
Message-ID: <20171031170343.GG9463@n2100.armlinux.org.uk>
References: <20171031142149.32512-1-andriy.shevchenko@linux.intel.com>
 <20171031142149.32512-8-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49384 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbdJaRDw (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 31 Oct 2017 13:03:52 -0400
Content-Disposition: inline
In-Reply-To: <20171031142149.32512-8-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org

On Tue, Oct 31, 2017 at 04:21:42PM +0200, Andy Shevchenko wrote:
> Since i2c_unregister_device() became NULL-aware we may remove duplicate
> NULL check.
> 
> Cc: Russell King <linux@armlinux.org.uk>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks.

> Cc: David Airlie <airlied@linux.ie>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpu/drm/i2c/tda998x_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
> index 4d1f45acf2cd..7a349e85f964 100644
> --- a/drivers/gpu/drm/i2c/tda998x_drv.c
> +++ b/drivers/gpu/drm/i2c/tda998x_drv.c
> @@ -1602,8 +1602,7 @@ static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
>  	/* if encoder_init fails, the encoder slave is never registered,
>  	 * so cleanup here:
>  	 */
> -	if (priv->cec)
> -		i2c_unregister_device(priv->cec);
> +	i2c_unregister_device(priv->cec);
>  	return -ENXIO;
>  }
>  
> -- 
> 2.14.2
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
