From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH]  i2c: i2c-smbus: drop useless stubs
Date: Tue, 19 Jul 2016 13:24:45 +0200
Message-ID: <20160719112445.GV4663@mail.corp.redhat.com>
References: <20160719131549.3eb23323@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40660 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbcGSLYt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 19 Jul 2016 07:24:49 -0400
Content-Disposition: inline
In-Reply-To: <20160719131549.3eb23323@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

On Jul 19 2016 or thereabouts, Jean Delvare wrote:
> Drivers which use the SMBus extensions select I2C_SMBUS, so the
> stubs are not needed.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> ---

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  include/linux/i2c-smbus.h |   15 ---------------
>  1 file changed, 15 deletions(-)
> 
> --- linux-4.7-rc7.orig/include/linux/i2c-smbus.h	2016-07-19 13:06:08.873469372 +0200
> +++ linux-4.7-rc7/include/linux/i2c-smbus.h	2016-07-19 13:11:46.265359168 +0200
> @@ -73,23 +73,8 @@ struct smbus_host_notify {
>  	u8			addr;
>  };
>  
> -#if IS_ENABLED(CONFIG_I2C_SMBUS)
>  struct smbus_host_notify *i2c_setup_smbus_host_notify(struct i2c_adapter *adap);
>  int i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
>  				 unsigned short addr, unsigned int data);
> -#else
> -static inline struct smbus_host_notify *
> -i2c_setup_smbus_host_notify(struct i2c_adapter *adap)
> -{
> -	return NULL;
> -}
> -
> -static inline int
> -i2c_handle_smbus_host_notify(struct smbus_host_notify *host_notify,
> -			     unsigned short addr, unsigned int data)
> -{
> -	return 0;
> -}
> -#endif /* I2C_SMBUS */
>  
>  #endif /* _LINUX_I2C_SMBUS_H */
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
