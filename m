From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 4/4] ARM: dts: mvebu: Update with the new compatible
 string for mv64xxx-i2c
Date: Mon, 02 Sep 2013 13:44:45 +0200
Message-ID: <52247A2D.9090400@free-electrons.com>
References: <1377181169-17483-1-git-send-email-gregory.clement@free-electrons.com> <1377181169-17483-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377181169-17483-2-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm@redhat.c>
List-Id: linux-i2c@vger.kernel.org

Hi Jason,

Unless I missed it I didn't see this patch in your last pull request.
Wolfram took the 3 others patches and Mark Rutland agreed with the binding
introduced in the patch 3. So I think we are fine to take this patch
in mvebu.

Thanks,

On 22/08/2013 16:19, Gregory CLEMENT wrote:
> The mv64xxx-i2c embedded in the Armada XP have a new feature to
> offload i2c transaction. This new version of the IP come also with
> some errata. This lead to the introduction to a another compatible
> string.
> 
> This commit split the i2c information into armada-370.dtsi and
> armada-xp.dtsi. Most of the data remains the same and stay in the
> common file Armada-370-xp.dtsi. With this new feature the size of the
> registers are bigger for Armada XP and the new compatible string is
> used.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi |  2 --
>  arch/arm/boot/dts/armada-370.dtsi    |  8 ++++++++
>  arch/arm/boot/dts/armada-xp.dtsi     | 10 ++++++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index 90b1176..d8b24c9 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -121,7 +121,6 @@
>  
>  			i2c0: i2c@11000 {
>  				compatible = "marvell,mv64xxx-i2c";
> -				reg = <0x11000 0x20>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				interrupts = <31>;
> @@ -132,7 +131,6 @@
>  
>  			i2c1: i2c@11100 {
>  				compatible = "marvell,mv64xxx-i2c";
> -				reg = <0x11100 0x20>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				interrupts = <32>;
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index fa3dfc6..0e2eefa 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -155,6 +155,14 @@
>  				};
>  			};
>  
> +			i2c0: i2c@11000 {
> +				reg = <0x11000 0x20>;
> +			};
> +
> +			i2c1: i2c@11100 {
> +				reg = <0x11100 0x20>;
> +			};
> +
>  			usb@50000 {
>  				clocks = <&coreclk 0>;
>  			};
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 416eb94..e1f2547 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -138,6 +138,16 @@
>  				};
>  			};
>  
> +			i2c0: i2c@11000 {
> +				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
> +				reg = <0x11000 0x100>;
> +			};
> +
> +			i2c1: i2c@11100 {
> +				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
> +				reg = <0x11100 0x100>;
> +			};
> +
>  			usb@50000 {
>  				clocks = <&gateclk 18>;
>  			};
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
