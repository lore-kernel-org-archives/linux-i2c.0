From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 2/4] dt-bindings: at24: add compatible for nxp,se97b
Date: Tue, 16 Jan 2018 18:26:56 +0100
Message-ID: <CAMRc=MeSD3Zi=APcntepjmk3M85WxreAxG5OmzveawyZ_touzQ@mail.gmail.com>
References: <20180116160618.27859-1-peda@axentia.se> <20180116160618.27859-3-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38263 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeAPR05 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 16 Jan 2018 12:26:57 -0500
Received: by mail-oi0-f65.google.com with SMTP id m65so11155067oig.5
        for <linux-i2c@vger.kernel.org>; Tue, 16 Jan 2018 09:26:57 -0800 (PST)
In-Reply-To: <20180116160618.27859-3-peda@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Russell King <linux@armlinux.org.uk>, linux-i2c <linux-i2c@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

2018-01-16 17:06 GMT+01:00 Peter Rosin <peda@axentia.se>:
> The datasheet talks about the chip being an spd, but the chip is writable
> so atmel,24c02 is more appropriate as fallback.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index abfae1beca2b..edf9247613f6 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -46,6 +46,7 @@ Required properties:
>                  Some vendors use different model names for chips which are just
>                  variants of the above. Known such exceptions are listed below:
>
> +                "nxp,se97b" - the fallback is "atmel,24c02",
>                  "renesas,r1ex24002" - the fallback is "atmel,24c02"
>
>    - reg: The I2C address of the EEPROM.
> --
> 2.11.0
>

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
