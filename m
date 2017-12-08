From: Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>
Subject: Re: [PATCH v7 2/2] dt-bindings: add eeprom "no-read-rollover" property
Date: Fri, 8 Dec 2017 18:22:17 +0100
Message-ID: <CAMRc=MddKwD0v1HCKPuO4qBp7W1KN6Wr-diC3kpyq+tPGD8=PA@mail.gmail.com>
References: <1512750511-24505-1-git-send-email-svendev@arcx.com> <1512750511-24505-3-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512750511-24505-3-git-send-email-svendev-fuHqz3Nb1YI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2017-12-08 17:28 GMT+01:00 Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>:
> Adds an optional property for at24 eeproms.
> This parameterless property indicates that the multi-address eeprom
> does not automatically roll over reads to the next slave address.
>
> Signed-off-by: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.txt b/Documentation/devicetree/bindings/eeprom/at24.txt
> index 27f2bc1..a0415b8 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.txt
> +++ b/Documentation/devicetree/bindings/eeprom/at24.txt
> @@ -38,6 +38,11 @@ Optional properties:
>
>    - size: total eeprom size in bytes
>
> +  - no-read-rollover:
> +                       This parameterless property indicates that the multi-address
> +                       eeprom does not automatically roll over reads to the next
> +                       slave address. Please consult the manual of your device.
> +
>  Example:
>
>  eeprom@52 {
> --
> 1.9.1
>

Applied, thanks!
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
