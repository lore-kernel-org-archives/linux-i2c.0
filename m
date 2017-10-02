From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: i2c: Update documentation for "mv78230-a0-i2c"
Date: Mon, 02 Oct 2017 16:23:43 +0200
Message-ID: <87k20dmxw0.fsf@free-electrons.com>
References: <20170928213605.22874-1-kalyan.kinthada@alliedtelesis.co.nz>
        <20170928213605.22874-3-kalyan.kinthada@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170928213605.22874-3-kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
        (Kalyan Kinthada's message of "Fri, 29 Sep 2017 10:36:05 +1300")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: Kalyan Kinthada <kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,
 
 On ven., sept. 29 2017, Kalyan Kinthada <kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:

> This commit modifies the documentation for
> "marvell,mv78230-a0-i2c" compatible string.
>
> The "marvell,mv78230-a0-i2c" compatible string enables the workaround
> for an i2c repeated start timing violation, but unlike
> "marvell,mv78230-i2c" it disables the i2c offload support. This is
> applicable to a number of SoCs such as early revisions of the Armada XP
> and the Armada 38x.
>
> Signed-off-by: Kalyan Kinthada <kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>


I applied the dt fix on my mvebu/fixes branch. Do you want to apply this
one on your branch, or do you prefer I take it. In this case an acked-by
would be nice.

Thanks,

Gregory


> ---
>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index 5c30026921ae..c6cbab17ed0a 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -10,10 +10,12 @@ Required properties :
>                       - "marvell,mv64xxx-i2c"
>                       - "marvell,mv78230-i2c"
>                       - "marvell,mv78230-a0-i2c"
> -                       * Note: Only use "marvell,mv78230-a0-i2c" for a
> -                         very rare, initial version of the SoC which
> -                         had broken offload support.  Linux
> -                         auto-detects this and sets it appropriately.
> +                       * Note: Use "marvell,mv78230-a0-i2c" for
> +                         controller which do not support offload
> +                         but still have the i2c repeated start
> +                         timing violation issue, such as the
> +                         ones found in the Armada XP A0 and the
> +                         Armada 38x SoCs.
>   - interrupts      : The interrupt number
>  
>  Optional properties :
> -- 
> 2.14.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
