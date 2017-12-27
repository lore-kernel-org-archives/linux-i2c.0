From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: at24: consistently document the
 compatible property
Date: Wed, 27 Dec 2017 11:24:01 -0600
Message-ID: <CAL_JsqJwt1FfdiOCRnMSKWmAW668XqGvKsuZqKrXfkNnt3MPRQ@mail.gmail.com>
References: <20171227135054.29690-1-brgl@bgdev.pl> <20171227135054.29690-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751043AbdL0RYX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 27 Dec 2017 12:24:23 -0500
In-Reply-To: <20171227135054.29690-2-brgl@bgdev.pl>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>, Peter Rosin <peda@axentia.se>, Linux I2C <linux-i2c@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 27, 2017 at 7:50 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> Current description of the compatible property for at24 is quite vague.
>
> State explicitly that any "<manufacturer>,<model>" pair is accepted as
> long as one of the listed strings is used as fallback.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 37 +++++++++--------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index cbc80e194ac6..b5ce5a247554 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -2,28 +2,21 @@ EEPROMs (I2C)
>
>  Required properties:
>
> -  - compatible : should be "<manufacturer>,<type>", like these:
> -
> -       "atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
> -       "atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
> -       "atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"
> -
> -       "catalyst,24c32"
> -
> -       "microchip,24c128"
> -
> -       "ramtron,24c64"
> -
> -       "renesas,r1ex24002"
> -
> -       The following manufacturers values have been deprecated:
> -       "at", "at24"
> -
> -        If there is no specific driver for <manufacturer>, a generic
> -        device with <type> and manufacturer "atmel" should be used.
> -        Possible types are:
> -        "24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
> -        "24c128", "24c256", "24c512", "24c1024", "spd"
> +  - compatible: must be a "<manufacturer>,<model>" pair with one of the

Also, why do you add "must" here and then fix it with "Must" in patch
3? Just get it right here.

Rob
