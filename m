From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH v2 4/5] i2c: rcar: document R8A77995 bindings
Date: Tue, 30 Jan 2018 10:18:48 +0100
Message-ID: <20180130091848.quk2refdntpxohsx@verge.net.au>
References: <1517240748-14780-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1517240748-14780-5-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1517240748-14780-5-git-send-email-ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, kieran.bingham-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 29, 2018 at 04:45:47PM +0100, Ulrich Hecht wrote:
> R-Car D3 (R8A77995) SoC has a R-Car Gen3-compatible I2C controller.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Reviewed-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

> ---
>  Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> index a777477..e91dbaf 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> @@ -14,6 +14,7 @@ Required properties:
>  	"renesas,i2c-r8a7795" if the device is a part of a R8A7795 SoC.
>  	"renesas,i2c-r8a7796" if the device is a part of a R8A7796 SoC.
>  	"renesas,i2c-r8a77970" if the device is a part of a R8A77970 SoC.
> +	"renesas,i2c-r8a77995" if the device is a part of a R8A77995 SoC.
>  	"renesas,rcar-gen1-i2c" for a generic R-Car Gen1 compatible device.
>  	"renesas,rcar-gen2-i2c" for a generic R-Car Gen2 or RZ/G1 compatible
>  				device.
> -- 
> 2.7.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
