From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH] i2c: robotfuzz-osif: Constify osif_table
Date: Thu, 2 Jun 2016 13:59:57 +0200
Message-ID: <20160602115957.GE17343@lunn.ch>
References: <1464845328.6532.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:57486 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932294AbcFBMAA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 2 Jun 2016 08:00:00 -0400
Content-Disposition: inline
In-Reply-To: <1464845328.6532.1.camel@ingics.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org

On Thu, Jun 02, 2016 at 01:28:48PM +0800, Axel Lin wrote:
> osif_table is never modified, so declare it as const.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Andrew Lunn <andrew@lunn.ch>

Thanks
	Andrew

> ---
>  drivers/i2c/busses/i2c-robotfuzz-osif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-robotfuzz-osif.c b/drivers/i2c/busses/i2c-robotfuzz-osif.c
> index ced9c6a..89d8b41 100644
> --- a/drivers/i2c/busses/i2c-robotfuzz-osif.c
> +++ b/drivers/i2c/busses/i2c-robotfuzz-osif.c
> @@ -125,7 +125,7 @@ static struct i2c_algorithm osif_algorithm = {
>  #define USB_OSIF_VENDOR_ID	0x1964
>  #define USB_OSIF_PRODUCT_ID	0x0001
>  
> -static struct usb_device_id osif_table[] = {
> +static const struct usb_device_id osif_table[] = {
>  	{ USB_DEVICE(USB_OSIF_VENDOR_ID, USB_OSIF_PRODUCT_ID) },
>  	{ }
>  };
> -- 
> 2.5.0
> 
