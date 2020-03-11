From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH] misc: eeprom: at24: fix regulator underflow
Date: Wed, 11 Mar 2020 09:26:54 +0100
Message-ID: <CAMpxmJXBN_qTwHpcD-anHVB-uhatuN-PZDUUe6boD0GoFiMVXw@mail.gmail.com>
References: <20200310205841.123084-1-michael.auchter@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33356 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCKI1H (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 11 Mar 2020 04:27:07 -0400
Received: by mail-qk1-f195.google.com with SMTP id p62so1290048qkb.0
        for <linux-i2c@vger.kernel.org>; Wed, 11 Mar 2020 01:27:06 -0700 (PDT)
In-Reply-To: <20200310205841.123084-1-michael.auchter@ni.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michael Auchter <michael.auchter@ni.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

wt., 10 mar 2020 o 21:59 Michael Auchter <michael.auchter@ni.com> napisa=C5=
=82(a):
>
> The at24 driver attempts to read a byte from the device to validate that
> it's actually present, and if not, disables the vcc regulator and
> returns -ENODEV. However, between the read and the error handling path,
> pm_runtime_idle() is called and invokes the driver's suspend callback,
> which also disables the vcc regulator. This leads to an underflow of the
> regulator enable count if the EEPROM is not present.
>
> Move the pm_runtime_suspend() call to be after the error handling path
> to resolve this.
>
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
>  drivers/misc/eeprom/at24.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 031eb64549af..282c9ef68ed2 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -712,13 +712,14 @@ static int at24_probe(struct i2c_client *client)
>          * chip is functional.
>          */
>         err =3D at24_read(at24, 0, &test_byte, 1);
> -       pm_runtime_idle(dev);
>         if (err) {
>                 pm_runtime_disable(dev);
>                 regulator_disable(at24->vcc_reg);
>                 return -ENODEV;
>         }
>
> +       pm_runtime_idle(dev);
> +
>         if (writable)
>                 dev_info(dev, "%u byte %s EEPROM, writable, %u bytes/writ=
e\n",
>                          byte_len, client->name, at24->write_max);
> --
> 2.24.1
>

Patch applied for fixes.

Bartosz
