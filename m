From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: i2c: Add armada-38x i2c binding
Date: Fri, 22 Sep 2017 09:30:51 +0200
Message-ID: <87377fmbpw.fsf@free-electrons.com>
References: <20170922020429.20941-1-kalyan.kinthada@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170922020429.20941-1-kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
        (Kalyan Kinthada's message of "Fri, 22 Sep 2017 14:04:29 +1200")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalyan Kinthada <kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Kalyan,
 
 On ven., sept. 22 2017, Kalyan Kinthada <kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org> wrote:

> All armada-38x variants(380, 385, 388) SoCs have an issue
> in i2c controller which violates the i2c repeated start timing.


Did you had an issue with one of the SoC ?
If yes what was your setting ?
On my side I never managed to have this sort of issue on Armada 38x.

>
> This errata is fixed in the i2c-mv64xxx driver but enabled
> only for devices with compatible string "marvell,mv78230-i2c".

In this case why not just adding the "marvell,mv78230-i2c" as compatible
string in the appropriate device tree files ?

Gregory

>
> This patch introduces a new compatible string
> "marvell,armada-38x-i2c" for the i2c controller on armada-38x SoCs
> so that the workaound is enabled.


>
> Signed-off-by: Kalyan Kinthada <kalyan.kinthada-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index 5c30026921..fc100b6bdb 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -14,6 +14,7 @@ Required properties :
>                           very rare, initial version of the SoC which
>                           had broken offload support.  Linux
>                           auto-detects this and sets it appropriately.
> +                     - "marvell,armada-38x-i2c"
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
