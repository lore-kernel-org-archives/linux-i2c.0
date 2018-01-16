From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
Date: Tue, 16 Jan 2018 18:26:21 +0100
Message-ID: <CAMRc=McB5oD7+nAhTTL3CYHYMmuJrUV2mPYgxF3HxHUa0t14wA@mail.gmail.com>
References: <20180116160618.27859-1-peda@axentia.se> <20180116160618.27859-2-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38194 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbeAPR0W (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Jan 2018 12:26:22 -0500
Received: by mail-oi0-f68.google.com with SMTP id m65so11153604oig.5
        for <linux-i2c@vger.kernel.org>; Tue, 16 Jan 2018 09:26:21 -0800 (PST)
In-Reply-To: <20180116160618.27859-2-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@armlinux.org.uk>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

2018-01-16 17:06 GMT+01:00 Peter Rosin <peda@axentia.se>:
> Makes them easier to find.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 1812c848e369..abfae1beca2b 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -38,9 +38,9 @@ Required properties:
>
>                  "catalyst",
>                  "microchip",
> +                "nxp",
>                  "ramtron",
>                  "renesas",
> -                "nxp",
>                  "st",
>
>                  Some vendors use different model names for chips which are just
> --
> 2.11.0
>

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
