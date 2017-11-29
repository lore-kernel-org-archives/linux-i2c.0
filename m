From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2] eeprom: at24: fix reading from 24MAC402/24MAC602
Date: Wed, 29 Nov 2017 15:57:39 +0100
Message-ID: <CAMRc=MfSGQbVyL+JOtKR_FvtwLNDENFL2g=Yjjhf6JOFwoWbDQ@mail.gmail.com>
References: <32cfbfe3-fdff-5165-2753-186cbe2055a4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:38285 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdK2O5k (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 29 Nov 2017 09:57:40 -0500
Received: by mail-oi0-f44.google.com with SMTP id s9so2555801oie.5
        for <linux-i2c@vger.kernel.org>; Wed, 29 Nov 2017 06:57:40 -0800 (PST)
In-Reply-To: <32cfbfe3-fdff-5165-2753-186cbe2055a4@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

2017-11-27 20:46 GMT+01:00 Heiner Kallweit <hkallweit1@gmail.com>:
> Chip datasheet mentions that word addresses other than the actual
> start position of the MAC delivers undefined results. So fix this.
> Current implementation doesn't work due to this wrong offset.
>
> Fixes: 0b813658c115 "eeprom: at24: add support for at24mac series"
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - extended commit message
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

Applied to at24/fixes, thanks!
