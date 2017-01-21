From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 1/2] i2c: mux: pca954x: Export OF device ID table as
 module aliases
Date: Sat, 21 Jan 2017 16:56:42 +0100
Message-ID: <fb601d79-515b-ccd1-1c07-c68adcb4ed70@axentia.se>
References: <1484574895-952-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0096.outbound.protection.outlook.com ([104.47.2.96]:18653
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750876AbdAUP5e (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 21 Jan 2017 10:57:34 -0500
In-Reply-To: <1484574895-952-1-git-send-email-javier@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On 2017-01-16 14:54, Javier Martinez Canillas wrote:
> The I2C core always reports a MODALIAS of the form i2c:<foo> even if the
> device was registered via OF, this means that exporting the OF device ID
> table device aliases in the module is not needed. But in order to change
> how the core reports modaliases to user-space, it's better to export it.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Acked-by: Peter Rosin <peda@axentia.se>

> ---
> 
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index dd18b9ccb1f4..a0232e079545 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -148,6 +148,7 @@ static const struct of_device_id pca954x_of_match[] = {
>  	{ .compatible = "nxp,pca9548", .data = &chips[pca_9548] },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, pca954x_of_match);
>  #endif
>  
>  /* Write to mux register. Don't use i2c_transfer()/i2c_smbus_xfer()
> 
