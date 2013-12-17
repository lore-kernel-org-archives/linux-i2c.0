From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 4/5] arm: shmobile: genmai: adapt dts to use native i2c driver
Date: Tue, 17 Dec 2013 22:57:06 +0100
Message-ID: <3877089.dstf8Ijntd@avalon>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de> <1387316678-10174-5-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387316678-10174-5-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Tuesday 17 December 2013 22:44:37 Wolfram Sang wrote:
> From: Wolfram Sang <wsa-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> 
> Switch from the gpio-driver to the shiny new native driver. Tested by
> accessing the eeprom on the genmai board.
> 
> Signed-off-by: Wolfram Sang <wsa-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
> Acked-by: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> ---
>  arch/arm/boot/dts/r7s72100-genmai-reference.dts | 29 +++++++++-------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> b/arch/arm/boot/dts/r7s72100-genmai-reference.dts index ce5da0b..739448a
> 100644
> --- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> +++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> @@ -39,24 +39,6 @@
>  			gpios = <&port4 11 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> -
> -	i2c@0 {
> -		compatible = "i2c-gpio";
> -		gpios = <&port1 5 GPIO_ACTIVE_HIGH /* sda */
> -			 &port1 4 GPIO_ACTIVE_HIGH /* scl */
> -			>;
> -		i2c-gpio,sda-open-drain;
> -		i2c-gpio,scl-open-drain;
> -		i2c-gpio,delay-us = <5>;	/* ~100 kHz */
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		flash@50 {
> -			compatible = "renesas,24c128";
> -			reg = <0x50>;
> -			pagesize = <64>;
> -		};
> -	};
>  };
> 
>  &pfc {
> @@ -68,3 +50,14 @@
>  		renesas,function = "scif2";
>  	};
>  };
> +
> +&i2c2 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	eeprom: 24c128@50 {

That should be "24c128: eeprom@50". You can actually omit the "24c128:" alias 
until it gets needed.

> +		compatible = "renesas,24c128";
> +		reg = <0x50>;
> +		pagesize = <64>;
> +	};
> +};

-- 
Regards,

Laurent Pinchart
