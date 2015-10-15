From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH V3 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Wed, 14 Oct 2015 22:56:47 -0500
Message-ID: <1444881407.5185.232.camel@freescale.com>
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
	 <1444822498-16477-5-git-send-email-B48286@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444822498-16477-5-git-send-email-B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhiqiang Hou <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org, bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org, leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2015-10-14 at 19:34 +0800, Zhiqiang Hou wrote:
> From: Mingkai Hu <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> 
> LS1043a is an SoC with 4 ARMv8 A53 cores and most other IP blocks
> similar to LS1021a which complies to Chassis 2.1 spec.
> 
> Following levels of DTSI/DTS files have been created for the
> LS1043A SoC family:
> 
> - fsl-ls1043a.dtsi:
>   DTS-Include file for FSL LS1043A SoC.
> 
> Signed-off-by: Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Mingkai Hu <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Wenbin Song <Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> V3:
>  - Add device tree node for SATA.
>  - Remove properity enable-method for all cpu node.
>    Remove reserved memory region for spin-table.
> 
> V2:
>  - Add secondary core boot method.
>  - Move out the sysclk node from the clockgen node.
>  - Correct the reg size of GICC.
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 513 
> +++++++++++++++++++++++++
>  1 file changed, 513 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi

On the ls208x device tree we were asked to put devices under a bus node, such 
as an soc node with a simple-bus compatible.

-Scott

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
