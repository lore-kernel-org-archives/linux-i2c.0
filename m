From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 2/2] i2c: pca9541: Export OF device ID table as module
 aliases
Date: Sat, 21 Jan 2017 16:56:21 +0100
Message-ID: <41c2e7eb-5250-d8c6-5803-cab447a2ebd4@axentia.se>
References: <1484574895-952-1-git-send-email-javier@osg.samsung.com>
 <1484574895-952-2-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-he1eur01on0139.outbound.protection.outlook.com ([104.47.0.139]:37408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750893AbdAUQNA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 21 Jan 2017 11:13:00 -0500
In-Reply-To: <1484574895-952-2-git-send-email-javier@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>

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
>  drivers/i2c/muxes/i2c-mux-pca9541.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
> index 4ea7e691afc7..77840f7845a1 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> @@ -90,6 +90,7 @@ static const struct of_device_id pca9541_of_match[] = {
>  	{ .compatible = "nxp,pca9541" },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, pca9541_of_match);
>  #endif
>  
>  /*
> 
