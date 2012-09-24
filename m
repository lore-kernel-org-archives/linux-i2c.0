From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] ARM: dts: cfa10049: Add the i2c muxer buses to the
 CFA-10049
Date: Mon, 24 Sep 2012 15:52:29 +0400
Message-ID: <5060497D.9090104@mvista.com>
References: <1348474926-12763-1-git-send-email-maxime.ripard@free-electrons.com> <1348480425-13848-1-git-send-email-maxime.ripard@free-electrons.com> <1348480425-13848-3-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1348480425-13848-3-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, brian-ZKiFAVwZFM2FeswfMrDH8w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello.

On 24-09-2012 13:53, Maxime Ripard wrote:

> This will allow to add the 3 Nuvoton NAU7802 ADCs and the NXP PCA9555
> GPIO expander eventually.

> Signed-off-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>   arch/arm/boot/dts/imx28-cfa10049.dts |   33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)

> diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
> index a9288fb..9a55632 100644
> --- a/arch/arm/boot/dts/imx28-cfa10049.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10049.dts
> @@ -76,6 +76,39 @@
>   				status = "okay";
>   			};
>
> +			i2cmux {
> +				compatible = "i2c-mux-gpio";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
> +				i2c-parent = <&i2c1>;
> +
> +				i2c@0 {
> +					reg = <0>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;

    If you don't have any subnodes the above to props have no sense.

> +				};
> +

WBR, Sergei
