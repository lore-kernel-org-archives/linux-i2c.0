From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: at24: fix reading from 24MAC402/24MAC602
Date: Mon, 27 Nov 2017 14:51:48 +0100
Message-ID: <CAMRc=Md0V7cQkLRMkaWrfPz6gdP3+PbceSLhQcmNaErcTjv9tA@mail.gmail.com>
References: <4f62e18a-fc2d-f24f-f549-46b97f882cfc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-ot0-f172.google.com ([74.125.82.172]:44732 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbdK0Nvt (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 08:51:49 -0500
Received: by mail-ot0-f172.google.com with SMTP id d27so24189791ote.11
        for <linux-i2c@vger.kernel.org>; Mon, 27 Nov 2017 05:51:49 -0800 (PST)
In-Reply-To: <4f62e18a-fc2d-f24f-f549-46b97f882cfc@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-24 7:42 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Chip datasheet mentions that word addresses other than the actual
> start position of the MAC delivers undefined results. So fix this.
>

Could you also mention in the commit message, that the current
implementation doesn't work because the offset is simply wrong?

Thanks,
Bartosz

> Fixes: 0b813658c115 "eeprom: at24: add support for at24mac series"
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/misc/eeprom/at24.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index e0b4b36ef..00d602be7 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -425,7 +425,8 @@ static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
>         memset(msg, 0, sizeof(msg));
>         msg[0].addr = client->addr;
>         msg[0].buf = addrbuf;
> -       addrbuf[0] = 0x90 + offset;
> +       /* EUI-48 starts from 0x9a, EUI-64 from 0x98 */
> +       addrbuf[0] = 0xa0 - at24->chip.byte_len + offset;
>         msg[0].len = 1;
>         msg[1].addr = client->addr;
>         msg[1].flags = I2C_M_RD;
> --
> 2.15.0
>
