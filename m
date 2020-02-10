From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH V1] eeprom: at24: add TPF0001 ACPI ID for 24c1024 device
Date: Mon, 10 Feb 2020 11:04:52 +0100
Message-ID: <CAMpxmJU1U15_HxZfjdzTUfpTjOyhgybD=vPPJ6fXVV8Jy1dEmA@mail.gmail.com>
References: <20200127103541.6975-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43387 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgBJKFD (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 10 Feb 2020 05:05:03 -0500
Received: by mail-qk1-f193.google.com with SMTP id p7so926822qkh.10
        for <linux-i2c@vger.kernel.org>; Mon, 10 Feb 2020 02:05:03 -0800 (PST)
In-Reply-To: <20200127103541.6975-1-o.rempel@pengutronix.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Markus Pietrek <mpie@msc-ge.com>, Sascha Hauer <kernel@pengutronix.de>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

pon., 27 sty 2020 o 11:35 Oleksij Rempel <o.rempel@pengutronix.de> napisa=
=C5=82(a):
>
> From: Markus Pietrek <mpie@msc-ge.com>
>
> This ID is used at leas on some variants of MSC C6B-SLH board.
>
> Signed-off-by: Markus Pietrek <mpie@msc-ge.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/misc/eeprom/at24.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 2cccd82a3106..1c8e2ff96d9d 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -228,6 +228,7 @@ MODULE_DEVICE_TABLE(of, at24_of_match);
>
>  static const struct acpi_device_id at24_acpi_ids[] =3D {
>         { "INT3499",    (kernel_ulong_t)&at24_data_INT3499 },
> +       { "TPF0001",    (kernel_ulong_t)&at24_data_24c1024 },
>         { /* END OF LIST */ }
>  };
>  MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
> --
> 2.25.0
>

Patch applied.

Bartosz
