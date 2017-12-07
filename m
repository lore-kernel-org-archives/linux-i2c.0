From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND 1/2] dt-bindings: eeprom: rename to at24.txt
Date: Thu, 7 Dec 2017 09:41:18 -0600
Message-ID: <CAL_JsqL_Qd5XYX0OthiqGYaQm=h0YCjV3=zqocQjzNYEoQn6PA@mail.gmail.com>
References: <20171207103829.3342-1-wsa@the-dreams.de> <20171207103829.3342-2-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171207103829.3342-2-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bartosz Golaszewski <brgl-ARrdPY/1zhM@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 7, 2017 at 4:38 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> This binding documentation is for the at24 driver, so the filename
> should reflect it. This avoids confusion because we also have an
> "eeprom" driver in Linux but it doesn't support DT even.
>
> Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/eeprom/{eeprom.txt => at24.txt} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/eeprom/{eeprom.txt => at24.txt} (100%)

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
