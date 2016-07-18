From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] i2c: Update the description of I2C_SMBUS
Date: Mon, 18 Jul 2016 17:36:15 +0200
Message-ID: <20160718153605.GR4663@mail.corp.redhat.com>
References: <20160718123943.255b6599@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33706 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbcGRPg1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 18 Jul 2016 11:36:27 -0400
Content-Disposition: inline
In-Reply-To: <20160718123943.255b6599@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

On Jul 18 2016 or thereabouts, Jean Delvare wrote:
> We support the SMBus Host Notify protocol now.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/i2c/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-4.7-rc7.orig/drivers/i2c/Kconfig	2016-07-04 08:01:00.000000000 +0200
> +++ linux-4.7-rc7/drivers/i2c/Kconfig	2016-07-18 12:34:11.058067963 +0200
> @@ -88,8 +88,8 @@ config I2C_SMBUS
>  	tristate "SMBus-specific protocols" if !I2C_HELPER_AUTO
>  	help
>  	  Say Y here if you want support for SMBus extensions to the I2C
> -	  specification. At the moment, the only supported extension is
> -	  the SMBus alert protocol.
> +	  specification. At the moment, two extensions are supported:
> +	  the SMBus Alert protocol and the SMBus Host Notify protocol.
>  
>  	  This support is also available as a module.  If so, the module
>  	  will be called i2c-smbus.
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
