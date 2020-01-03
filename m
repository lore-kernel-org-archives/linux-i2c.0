From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 3/4] dt-bindings: at24: remove the optional property
 write-protect-gpios
Date: Fri, 3 Jan 2020 16:44:25 -0700
Message-ID: <20200103234425.GA17746@bogus>
References: <20191219115141.24653-1-ktouil@baylibre.com>
 <20191219115141.24653-4-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191219115141.24653-4-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khouloud Touil <ktouil@baylibre.com>
Cc: bgolaszewski@baylibre.com, mark.rutland@arm.com, srinivas.kandagatla@linaro.org, baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linus.walleij@linaro.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Dec 19, 2019 at 12:51:40PM +0100, Khouloud Touil wrote:
> NVMEM framework is an interface for the at24 EEPROMs as well as for
> other drivers, instead of passing the wp-gpios over the different
> drivers each time, it would be better to pass it over the NVMEM
> subsystem once and for all.
> 
> Removing the optional property form the device tree binding document.
> 
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> index e8778560d966..75de83708146 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> @@ -145,10 +145,7 @@ properties:
>        over reads to the next slave address. Please consult the manual of
>        your device.
>  
> -  wp-gpios:
> -    description:
> -      GPIO to which the write-protect pin of the chip is connected.
> -    maxItems: 1
> +  wp-gpios: true
>  
>    address-width:
>      allOf:
> @@ -181,7 +178,6 @@ examples:
>            compatible = "microchip,24c32", "atmel,24c32";
>            reg = <0x52>;
>            pagesize = <32>;
> -          wp-gpios = <&gpio1 3 0>;

This is still valid, why is it being removed?

>            num-addresses = <8>;
>        };
>      };
> -- 
> 2.17.1
> 
