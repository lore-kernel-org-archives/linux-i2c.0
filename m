From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCHv3 2.6.25] i2c: adds support for i2c bus on
	Freescale	CPM1/CPM2 controllers
Date: Mon, 28 Jan 2008 10:49:15 -0600
Message-ID: <20080128164915.GA3983@loki.buserror.net>
References: <479A185D.6010406@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <479A185D.6010406-NIgtFMG+Po8@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: linuxppc-dev list <linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org>, "Kernel,
	Linux" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Jan 25, 2008 at 06:11:57PM +0100, Jochen Friedrich wrote:
> diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
> index daf9433..80c08bf 100644
> --- a/arch/powerpc/boot/dts/mpc866ads.dts
> +++ b/arch/powerpc/boot/dts/mpc866ads.dts
> @@ -169,6 +169,16 @@
>  				fsl,cpm-command = <0000>;
>  				linux,network-index = <1>;
>  			};
> +
> +			i2c@860 {
> +				compatible = "fsl,mpc866-i2c",
> +					     "fsl,cpm1-i2c",
> +					     "fsl,cpm-i2c";
> +				reg = <860 20 3c80 30>;
> +				interrupts = <10 3>;
> +				interrupt-parent = <&Cpm_pic>;

The label is &CPM_PIC in the current mpc866ads.dts.

-Scott

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
