From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] arm64: dts: fsl: ls1046a: Add the guts node in dts
Date: Mon, 6 May 2019 09:41:07 +0200
Message-ID: <20190506074106.eqa7xhktn2vlmtio@pengutronix.de>
References: <20190430044719.30720-1-chuanhua.han@nxp.com>
 <20190430044719.30720-2-chuanhua.han@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190430044719.30720-2-chuanhua.han@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chuanhua Han <chuanhua.han@nxp.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, sumit.batra@nxp.com, eha@deif.com, festevam@gmail.com, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, wsa+renesas@sang-engineering.com, robh+dt@kernel.org, l.stach@pengutronix.de, linux-i2c@vger.kernel.org, u.kleine-koenig@pengutronix.de, linux@rempel-privat.de, shawnguo@kernel.org, peda@axentia.se, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 30, 2019 at 12:47:19PM +0800, Chuanhua Han wrote:
> For NXP ls1046a SoC, the i2c clock needs to be configured with the
> appropriate bit of RCW, so we add the guts node (GUTS/DCFG global
> utilities block) for the driver to read.
> 
> Signed-off-by: Sumit Batra <sumit.batra@nxp.com>
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 373310e4c0ea..f88599df18bb 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -205,6 +205,11 @@
>  			status = "disabled";
>  		};
>  
> +		guts: global-utilities@1ee0000 {
> +			compatible = "fsl,qoriq-device-config";
> +			reg = <0x0 0x1ee0000 0x0 0x1000>;
> +		};

According to Documentation/devicetree/bindings/soc/fsl/guts.txt we have
the following compatibles:

        "fsl,qoriq-device-config-1.0"
        "fsl,qoriq-device-config-2.0"
        "fsl,<chip>-device-config"
        "fsl,<chip>-guts"

"fsl,qoriq-device-config" is none of them and I don't think you should
give this SoC specific thing a generic compatible.
"fsl,ls1046a-device-config" would be better.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
