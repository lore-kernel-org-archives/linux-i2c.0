From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] i2c: i801: Drop needless bit-wise OR
Date: Mon, 30 May 2016 22:07:55 +0800
Message-ID: <CAGS+omBnhpUYTXzooaZZgMChyepiAkSzt0-MxRe530=-bTyCsw@mail.gmail.com>
References: <20160525093702.64d7309c@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:33807 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbcE3OIP (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 30 May 2016 10:08:15 -0400
Received: by mail-it0-f47.google.com with SMTP id g126so6061955ite.1
        for <linux-i2c@vger.kernel.org>; Mon, 30 May 2016 07:08:15 -0700 (PDT)
In-Reply-To: <20160525093702.64d7309c@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>

Hi Jean,

On Wed, May 25, 2016 at 3:37 PM, Jean Delvare <jdelvare@suse.de> wrote:
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
> ---
> Daniel, was there any reason for this bit-wise OR, which I may be
> missing?

The only thing I can think of is that I didn't want to assume that we
would always clear priv->status before another interrupt arrived.

>
>  drivers/i2c/busses/i2c-i801.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux-4.5.orig/drivers/i2c/busses/i2c-i801.c        2016-05-24 11:04:33.169026906 +0200
> +++ linux-4.5/drivers/i2c/busses/i2c-i801.c     2016-05-24 11:05:40.564642488 +0200
> @@ -548,7 +548,7 @@ static irqreturn_t i801_isr(int irq, voi
>         status &= SMBHSTSTS_INTR | STATUS_ERROR_FLAGS;
>         if (status) {
>                 outb_p(status, SMBHSTSTS(priv));
> -               priv->status |= status;
> +               priv->status = status;
>                 wake_up(&priv->waitq);
>         }
>
>
>
> --
> Jean Delvare
> SUSE L3 Support
