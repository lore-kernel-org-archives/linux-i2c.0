From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: add eeprom "no-read-rollover" property
Date: Thu, 7 Dec 2017 17:51:41 -0600
Message-ID: <CAL_JsqLUoS2zCbG-L9raKLFBMdqbyHkGU5oyjT3UTq+Rx0gY9Q@mail.gmail.com>
References: <1512674779-10349-1-git-send-email-svendev@arcx.com> <1512674779-10349-3-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512674779-10349-3-git-send-email-svendev-fuHqz3Nb1YI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, Divagar Mohandass <divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 7, 2017 at 1:26 PM, Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org> wrote:
> Adds an optional property for at24 eeproms.
> This parameterless property indicates that the multi-address eeprom
> does not automatically roll over reads to the next slave address.
>
> Signed-off-by: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/eeprom/eeprom.txt | 5 +++++
>  1 file changed, 5 insertions(+)

I acked v5. Please add acks/reviewed-bys when posting new versions.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
