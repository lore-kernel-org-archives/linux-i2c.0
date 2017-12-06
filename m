From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH] eeprom: at24: Change nvmem stride to 1
Date: Wed, 6 Dec 2017 11:25:29 +0100
Message-ID: <CAMRc=MeRAV-Smz7kFCJB+aeUMac42qti-x+gh38F91_Dd0=Yqg@mail.gmail.com>
References: <1512352481-13613-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512352481-13613-1-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

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

Applied, thanks!

Bartosz
