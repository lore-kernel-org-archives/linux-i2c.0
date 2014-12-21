From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH 3/4] ARM: shmobile: koelsch: Add DA9063 PMIC device node
 for system restart
Date: Sun, 21 Dec 2014 19:52:20 +0900
Message-ID: <20141221105133.GA30697@verge.net.au>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
 <1418124169-7123-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418124169-7123-4-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Dec 09, 2014 at 12:22:48PM +0100, Geert Uytterhoeven wrote:
> Add a minimal device node for the DA9063 PMIC, which is connected to i2c6.
> This allows the system to be restarted when the watchdog timer times
> out, or when a system restart is requested.
> 
> Regulator support is not yet included, as no DT support code nor DT
> binding documentation exists for the regulator functionality.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

I had this queued up for v3.20, however, when rebasing on top
of v3.19-rca (previous base was v3.18) I noticed that this patch
appears to cause booting koelsch with shmobile_defconfig to
stop at:

rcar_sound ec500000.rcar_sound: can't get dma channel
rcar_sound ec500000.rcar_sound: src[3] (Gen2) failed
rcar_sound ec500000.rcar_sound: ssi[1] fallback to PIO mode
rcar_sound ec500000.rcar_sound: probed
TCP: cubic registered
NET: Registered protocol family 10
da9063 6-0058: Failed to read IRQ status: -6
sit: IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
Key type dns_resolver registered
random: nonblocking pool is initialized

I have (hopefully temporarily) dropped this patch accordingly.

> ---
> Restart by watchdog timeout is working now.
> Manual system restart depends on "[PATCH 1/4] watchdog: da9063: Add restart
> handler support".
> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 6938377d3798644b..a400c27a813f1a8b 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -524,6 +524,13 @@
>  		regulator-boot-on;
>  		regulator-always-on;
>  	};
> +
> +	pmic@58 {
> +		compatible = "dlg,da9063";
> +		reg = <0x58>;
> +		interrupt-parent = <&irqc0>;
> +		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> +	};
>  };
>  
>  &pci0 {
> -- 
> 1.9.1
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
