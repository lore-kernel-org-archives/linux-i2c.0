From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH 1/3] dt-bindings: i2c: at91: cosmetic formatting of
 compatible list
Date: Tue, 3 Dec 2019 07:57:51 +0100
Message-ID: <20191203065751.fgwwko3e63antodb@M43218.corp.atmel.com>
References: <1575276957-5615-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1575276957-5615-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>
Cc: "robh+dt@kernel.org" <robh+dt@kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peda@axentia.se" <peda@axentia.se>, Codrin Ciubotariu - M19940 <Codrin.Ciubotariu@microchip.com>, Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>
List-Id: linux-i2c@vger.kernel.org

On Mon, Dec 02, 2019 at 09:56:35AM +0100, Eugen Hristev - M18282 wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> Format the list of compatibles with one compatible per line.
> 
> Suggested-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Thanks

> ---
>  Documentation/devicetree/bindings/i2c/i2c-at91.txt | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> index 2210f43..d35cd63 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
> @@ -1,10 +1,16 @@
>  I2C for Atmel platforms
>  
>  Required properties :
> -- compatible : Must be "atmel,at91rm9200-i2c", "atmel,at91sam9261-i2c",
> -     "atmel,at91sam9260-i2c", "atmel,at91sam9g20-i2c", "atmel,at91sam9g10-i2c",
> -     "atmel,at91sam9x5-i2c", "atmel,sama5d4-i2c", "atmel,sama5d2-i2c" or
> -     "microchip,sam9x60-i2c"
> +- compatible : Must be one of:
> +	"atmel,at91rm9200-i2c",
> +	"atmel,at91sam9261-i2c",
> +	"atmel,at91sam9260-i2c",
> +	"atmel,at91sam9g20-i2c",
> +	"atmel,at91sam9g10-i2c",
> +	"atmel,at91sam9x5-i2c",
> +	"atmel,sama5d4-i2c",
> +	"atmel,sama5d2-i2c",
> +	"microchip,sam9x60-i2c".
>  - reg: physical base address of the controller and length of memory mapped
>       region.
>  - interrupts: interrupt number to the cpu.
> -- 
> 2.7.4
> 
