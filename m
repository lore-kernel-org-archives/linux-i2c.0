From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: sh_mobile: Document r8a7743/5
 support
Date: Wed, 9 Aug 2017 10:53:14 +0200
Message-ID: <20170809085314.GK2705@verge.net.au>
References: <1502196349-29245-1-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502196349-29245-1-git-send-email-biju.das@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Biju Das <biju.das@bp.renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@armlinux.org.uk>, Chris Paterson <chris.paterson2@renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 08, 2017 at 01:45:49PM +0100, Biju Das wrote:
> Document i2c Device Tree support for RZ/G1[ME]
> (also known as r8a774[35]) SoCs. They are compatible with
> R-Car Gen2 SoC family. No driver change is required as the
> initialisation sequence is currently the same as for the
> R-Car Gen2 fallback binding.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
> index ae9c2a7..2243909 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
> @@ -4,6 +4,8 @@ Required properties:
>  - compatible      :
>  			- "renesas,iic-r8a73a4" (R-Mobile APE6)
>  			- "renesas,iic-r8a7740" (R-Mobile A1)
> +			- "renesas,iic-r8a7743" (RZ/G1M)
> +			- "renesas,iic-r8a7745" (RZ/G1E)
>  			- "renesas,iic-r8a7790" (R-Car H2)
>  			- "renesas,iic-r8a7791" (R-Car M2-W)
>  			- "renesas,iic-r8a7792" (R-Car V2H)
> @@ -12,7 +14,8 @@ Required properties:
>  			- "renesas,iic-r8a7795" (R-Car H3)
>  			- "renesas,iic-r8a7796" (R-Car M3-W)
>  			- "renesas,iic-sh73a0" (SH-Mobile AG5)
> -			- "renesas,rcar-gen2-iic" (generic R-Car Gen2 compatible device)
> +			- "renesas,rcar-gen2-iic" (generic R-Car Gen2 or RZ/G1
> +							compatible device)
>  			- "renesas,rcar-gen3-iic" (generic R-Car Gen3 compatible device)
>  			- "renesas,rmobile-iic" (generic device)
>  
> -- 
> 1.9.1
> 
