From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: i2c: i801: Drop needless bit-wise OR
Date: Wed, 8 Jun 2016 18:30:32 +0200
Message-ID: <20160608163032.GB24234@mail.corp.redhat.com>
References: <20160525093702.64d7309c@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41297 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757709AbcFHQah (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 8 Jun 2016 12:30:37 -0400
Content-Disposition: inline
In-Reply-To: <20160525093702.64d7309c@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Daniel Kurtz <djkurtz@chromium.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

On May 25 2016 or thereabouts, Jean Delvare wrote:
> The interrupt handling code makes it look like several status values
> may be merged together before being processed, while this will never
> happen. Change from bit-wise OR to simple assignment to make it more
> obvious and avoid misunderstanding.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> ---

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> Daniel, was there any reason for this bit-wise OR, which I may be
> missing?
> 
>  drivers/i2c/busses/i2c-i801.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-4.5.orig/drivers/i2c/busses/i2c-i801.c	2016-05-24 11:04:33.169026906 +0200
> +++ linux-4.5/drivers/i2c/busses/i2c-i801.c	2016-05-24 11:05:40.564642488 +0200
> @@ -548,7 +548,7 @@ static irqreturn_t i801_isr(int irq, voi
>  	status &= SMBHSTSTS_INTR | STATUS_ERROR_FLAGS;
>  	if (status) {
>  		outb_p(status, SMBHSTSTS(priv));
> -		priv->status |= status;
> +		priv->status = status;
>  		wake_up(&priv->waitq);
>  	}
>  
