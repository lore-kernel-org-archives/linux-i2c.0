From: Tim Kryger <tim.kryger@gmail.com>
Subject: Re: [PATCH] i2c: bcm-kona: fix inconsistent indenting
Date: Mon, 15 Aug 2016 07:11:43 -0700
Message-ID: <CAD7vxxL3wdUpXnbupBJf7rFe8BD6Jh-SdL+=yuzG+vNzo-11VQ@mail.gmail.com>
References: <1471214842-25877-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35837 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbcHOOLo (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 15 Aug 2016 10:11:44 -0400
Received: by mail-oi0-f67.google.com with SMTP id e80so4495774oig.2
        for <linux-i2c@vger.kernel.org>; Mon, 15 Aug 2016 07:11:44 -0700 (PDT)
In-Reply-To: <1471214842-25877-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>

On Sun, Aug 14, 2016 at 3:47 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> smatch rightfully says:
> drivers/i2c/busses/i2c-bcm-kona.c:646 bcm_kona_i2c_xfer() warn: inconsistent indenting
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Tim Kryger <tim.kryger@gmail.com>

> ---
>  drivers/i2c/busses/i2c-bcm-kona.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
> index f98743277e3c74..258cb9a40ab349 100644
> --- a/drivers/i2c/busses/i2c-bcm-kona.c
> +++ b/drivers/i2c/busses/i2c-bcm-kona.c
> @@ -643,7 +643,7 @@ static int bcm_kona_i2c_xfer(struct i2c_adapter *adapter,
>                         if (rc < 0) {
>                                 dev_err(dev->device,
>                                         "restart cmd failed rc = %d\n", rc);
> -                                       goto xfer_send_stop;
> +                               goto xfer_send_stop;
>                         }
>                 }
>
> --
> 2.8.1
>
