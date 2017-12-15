From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH v5] i2c: Add support for NXP PCA984x family.
Date: Fri, 15 Dec 2017 11:40:52 +0100
Message-ID: <034bb221-d96d-a380-6389-00ad283dbb23@axentia.se>
References: <990e4a1f-a9ac-c899-0075-ae3211ff9475@axentia.se>
 <20171214112003.13701-1-adrian.fiergolski@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171214112003.13701-1-adrian.fiergolski-vJEk5272eHo@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

[It occurred to me that the DT people might skip the v4 discussion now
that there is a v5. So, in order to spare someone the effort of digging
that up, I'm re-sending the comments]

On 2017-12-14 12:20, Adrian Fiergolski wrote:
> This patch extends the current i2c-mux-pca954x driver and adds support for
> a newer PCA984x family of the I2C switches and multiplexers from NXP.
> 
> Signed-off-by: Adrian Fiergolski <adrian.fiergolski-vJEk5272eHo@public.gmane.org>
> ---
> I have applied recent Peter's comments.
> I am waiting for comments from device-tree folks regarding compatibles.
> 
> .../devicetree/bindings/i2c/i2c-mux-pca954x.txt    |  5 ++-
>  drivers/i2c/muxes/Kconfig                          |  6 ++--
>  drivers/i2c/muxes/i2c-mux-pca954x.c                | 36 +++++++++++++++++++---
>  3 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> index aa097045a10e..b428bc0d81b1 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.txt
> @@ -1,10 +1,13 @@
>  * NXP PCA954x I2C bus switch
>  
> +The driver supports NXP PCA954x and PCA984x I2C mux/switch devices.
> +
>  Required Properties:
>  
>    - compatible: Must contain one of the following.
>      "nxp,pca9540", "nxp,pca9542", "nxp,pca9543", "nxp,pca9544",
> -    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548"
> +    "nxp,pca9545", "nxp,pca9546", "nxp,pca9547", "nxp,pca9548",
> +    "nxp,pca9846", "nxp,pca9847", "nxp,pca9848", "nxp,pca9849"

I think that perhaps the new chips should have compatibles like:

	compatible = "nxp,pca9846", "nxp,pca9546";
	compatible = "nxp,pca9847", "nxp,pca9547";
	compatible = "nxp,pca9848", "nxp,pca9548";

since they are extremely similar to the older chips (the only
difference is the device id support and other esoteric stuff that
you don't need to use). That way the device-tree will work even
with an older OS that only supports pca954x chips. And when you
add the device id check for the pca984x family, you are set up
to differentiate.

(pca9849 isn't really compatible with any of the pca954x chips since
it lacks interrupt handling)

So, what is best practice in this situation?

Come to think of it, this is closely related to
	https://lkml.org/lkml/2017/8/3/226
which did not get a satisfactory answer IMHO.

>    - reg: The I2C address of the device.
>  

*snip*

Cheers,
Peter
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
