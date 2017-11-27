From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2] eeprom: at24: fix reading from 24MAC402/24MAC602
Date: Mon, 27 Nov 2017 20:59:20 +0100
Message-ID: <9f1ca504-9382-1fce-7750-433b6d5078bb@gmail.com>
References: <32cfbfe3-fdff-5165-2753-186cbe2055a4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:46788 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbdK0T70 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Nov 2017 14:59:26 -0500
Received: by mail-wm0-f49.google.com with SMTP id u83so36712178wmb.5
        for <linux-i2c@vger.kernel.org>; Mon, 27 Nov 2017 11:59:25 -0800 (PST)
In-Reply-To: <32cfbfe3-fdff-5165-2753-186cbe2055a4@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Am 27.11.2017 um 20:46 schrieb Heiner Kallweit:
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
>  	memset(msg, 0, sizeof(msg));
>  	msg[0].addr = client->addr;
>  	msg[0].buf = addrbuf;
> -	addrbuf[0] = 0x90 + offset;
> +	/* EUI-48 starts from 0x9a, EUI-64 from 0x98 */
> +	addrbuf[0] = 0xa0 - at24->chip.byte_len + offset;
>  	msg[0].len = 1;
>  	msg[1].addr = client->addr;
>  	msg[1].flags = I2C_M_RD;
> 
Are you going to apply this patch also before my other patch series?
Then I will consider this too when re-basing.
