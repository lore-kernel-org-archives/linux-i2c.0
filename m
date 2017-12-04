From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: at24: Change nvmem stride to 1
Date: Mon, 4 Dec 2017 18:44:36 +0100
Message-ID: <CAMRc=McoGNhQZwdNNwXwKYhjZvLPwUQbbVM4YjgnSnth7fOZTw@mail.gmail.com>
References: <1512352481-13613-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:35616 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdLDRoh (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 4 Dec 2017 12:44:37 -0500
Received: by mail-oi0-f46.google.com with SMTP id 184so12297534oii.2
        for <linux-i2c@vger.kernel.org>; Mon, 04 Dec 2017 09:44:37 -0800 (PST)
In-Reply-To: <1512352481-13613-1-git-send-email-david@lechnology.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Lechner <david@lechnology.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org

2017-12-04 2:54 GMT+01:00 David Lechner <david@lechnology.com>:
> This changes the nvmem stride to 1.
>
> I am trying to use the nvram consumer apis to read a MAC address from an
> eeprom that has an offset that is not a multiple of 4, which causes an
> error currently.
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/misc/eeprom/at24.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 305a7a4..f70d14c 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -880,7 +880,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
>         at24->nvmem_config.reg_read = at24_read;
>         at24->nvmem_config.reg_write = at24_write;
>         at24->nvmem_config.priv = at24;
> -       at24->nvmem_config.stride = 4;
> +       at24->nvmem_config.stride = 1;
>         at24->nvmem_config.word_size = 1;
>         at24->nvmem_config.size = chip.byte_len;
>
> --
> 2.7.4
>

I can't find any documentation on what the stride config option does
in nvmem, but looking at the code it's only used for alignment checks
in nvmem core, so this patch should be ok. Still: I'm wondering if it
shouldn't depend on the size of the eeprom or if we shouldn't make the
chip you're using a special case.

@David: what is the chip you're using? Is it an at24mac402 by any
chance? Were you affected by the read problem we fixed recently[1][2]
in at24?

@Srinivas: any comments on that?

Thanks,
Bartosz

[1] http://patchwork.ozlabs.org/patch/841852/
[2] http://patchwork.ozlabs.org/patch/841876/
