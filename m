From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] dts: keystone: Change "ti,davinci-i2c" compatible to
 "ti,keystone-i2c"
Date: Fri, 21 Aug 2015 19:25:16 +0100
Message-ID: <20150821182500.GA2000@svinekod>
References: <55D6F39A.2030402@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55D6F39A.2030402-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 21, 2015 at 10:47:06AM +0100, Alexander Sverdlin wrote:
> Now as "i2c-davinci" driver has special handling for Keystone it's time to switch
> the device tree to use new "compatible" property.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/boot/dts/keystone.dtsi |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index 72816d6..a846597 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -106,7 +106,7 @@
>  		};
>  
>  		i2c0: i2c@2530000 {
> -			compatible = "ti,davinci-i2c";
> +			compatible = "ti,keystone-i2c";

>From what I understand of the previous patch, this is effectively an
optimisation, and things worked to some extent with the "ti,davinci-i2c"
string.

So could you leave that as a fallback, i.e. have:

	compatible = "ti,keystone-i2c", "ti,davinci-i2c";

That way an old kernel still functions with this DT, which among other things
makes debugging and bisecting far easier.

Or are things actually broken with the "ti,davinci-i2c" string?

Thanks,
Mark
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
