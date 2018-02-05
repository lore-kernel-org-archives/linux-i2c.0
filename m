From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/5] dt-bindings: at24: add bindings for Rohm BR24T01
Date: Mon, 5 Feb 2018 00:07:32 -0600
Message-ID: <20180205060732.ufy2w37uc4okclew@rob-hp-laptop>
References: <1517240748-14780-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1517240748-14780-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37034 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752675AbeBEGHe (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 5 Feb 2018 01:07:34 -0500
Content-Disposition: inline
In-Reply-To: <1517240748-14780-6-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, horms@verge.net.au, geert@linux-m68k.org, kieran.bingham@ideasonboard.com, wsa@the-dreams.de, magnus.damm@gmail.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Jan 29, 2018 at 04:45:48PM +0100, Ulrich Hecht wrote:
> Both manufacturer and name variant.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 1812c84..dd29937 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -40,6 +40,7 @@ Required properties:
>                  "microchip",
>                  "ramtron",
>                  "renesas",
> +                "rohm",

This is going to comflict with a patch sorting these IIRC. So they 
should go thru the same tree.

>                  "nxp",
>                  "st",
>  
> @@ -47,6 +48,7 @@ Required properties:
>                  variants of the above. Known such exceptions are listed below:
>  
>                  "renesas,r1ex24002" - the fallback is "atmel,24c02"
> +                "rohm,br24t01" - the fallback is "atmel,24c01"
>  
>    - reg: The I2C address of the EEPROM.
>  
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
