From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v3 1/5] dt-bindings: at24: consistently document the
 compatible property
Date: Wed, 27 Dec 2017 23:02:58 +0100
Message-ID: <6dcb51bb-c5a1-06e4-68a2-16aa0d8b000d@axentia.se>
References: <20171227135054.29690-1-brgl@bgdev.pl>
 <20171227135054.29690-2-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr20122.outbound.protection.outlook.com ([40.107.2.122]:49386
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751871AbdL0WDH (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 27 Dec 2017 17:03:07 -0500
In-Reply-To: <20171227135054.29690-2-brgl@bgdev.pl>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Javier Martinez Canillas <javier@dowhile0.org>, David Lechner <david@lechnology.com>, Divagar Mohandass <divagar.mohandass@intel.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

On 2017-12-27 14:50, Bartosz Golaszewski wrote:
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
> -	"atmel,24c00", "atmel,24c01", "atmel,24c02", "atmel,24c04",
> -	"atmel,24c08", "atmel,24c16", "atmel,24c32", "atmel,24c64",
> -	"atmel,24c128", "atmel,24c256", "atmel,24c512", "atmel,24c1024"
> -
> -	"catalyst,24c32"
> -
> -	"microchip,24c128"
> -
> -	"ramtron,24c64"
> -
> -	"renesas,r1ex24002"
> -
> -	The following manufacturers values have been deprecated:
> -	"at", "at24"
> -
> -	 If there is no specific driver for <manufacturer>, a generic
> -	 device with <type> and manufacturer "atmel" should be used.
> -	 Possible types are:
> -	 "24c00", "24c01", "24c02", "24c04", "24c08", "24c16", "24c32", "24c64",
> -	 "24c128", "24c256", "24c512", "24c1024", "spd"
> +  - compatible: must be a "<manufacturer>,<model>" pair with one of the
> +                following values as fallback:
> +
> +                "atmel,24c00",
> +                "atmel,24c01",

I read the above as if it is no longer allowed to have a plain old atmel
chip, since the atmel compatibles are now valid as fallbacks /only/. I don't
think that's what you intended?

Cheers,
Peter

> +                "atmel,24c02",
> +                "atmel,24c04",
> +                "atmel,24c08",
> +                "atmel,24c16",
> +                "atmel,24c32",
> +                "atmel,24c64",
> +                "atmel,24c128",
> +                "atmel,24c256",
> +                "atmel,24c512",
> +                "atmel,24c1024"
>  
>    - reg : the I2C address of the EEPROM
>  
> 
