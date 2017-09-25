From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH] [trivial] dt-bindings: i2c: i2c-mux: Spelling s/required
 is/required if/
Date: Mon, 25 Sep 2017 17:13:35 +0200
Message-ID: <2e6b5d12-f3aa-7228-9335-e3910e790109@axentia.se>
References: <1505998349-10091-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1505998349-10091-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jiri Kosina <trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2017-09-21 14:52, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Yes, this is trivial, both the patch and my complaint, but can you please
add a "body of explanation" as suggested by submitting-patches in its topic
"The canonical patch format"?

Maintainers accepting empty patch descriptions are publicly shamed, and
I do not wish to be in that boat, sorry...

Cheers,
Peter

> ---
>  Documentation/devicetree/bindings/i2c/i2c-mux.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux.txt b/Documentation/devicetree/bindings/i2c/i2c-mux.txt
> index 212e6779dc5c0caf..b38f58a1c8784184 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux.txt
> @@ -6,10 +6,10 @@ multiplexer/switch will have one child node for each child bus.
>  
>  Optional properties:
>  - #address-cells = <1>;
> -   This property is required is the i2c-mux child node does not exist.
> +   This property is required if the i2c-mux child node does not exist.
>  
>  - #size-cells = <0>;
> -   This property is required is the i2c-mux child node does not exist.
> +   This property is required if the i2c-mux child node does not exist.
>  
>  - i2c-mux
>     For i2c multiplexers/switches that have child nodes that are a mixture
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
