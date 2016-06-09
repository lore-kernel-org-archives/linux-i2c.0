From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [v2,09/10] i2c-i801: Null isr data buffer when done with it
Date: Thu, 9 Jun 2016 16:14:51 +0200
Message-ID: <20160609141451.GK24234@mail.corp.redhat.com>
References: <1464570544-975-10-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59559 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbcFIOO4 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 10:14:56 -0400
Content-Disposition: inline
In-Reply-To: <1464570544-975-10-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Corey Minyard <cminyard@mvista.com>

On May 29 2016 or thereabouts, Corey Minyard wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Don't leave a pointer to some external buffer lying around.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---

Looks good to me.

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/i2c/busses/i2c-i801.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 70da60a..bb15356 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -598,6 +598,7 @@ static int i801_block_transaction_byte_by_byte(struct i801_priv *priv,
>  			dev_warn(&priv->pci_dev->dev,
>  				 "Timeout waiting for interrupt!\n");
>  		}
> +		priv->data = NULL;
>  		priv->status = 0;
>  		return status;
>  	}
