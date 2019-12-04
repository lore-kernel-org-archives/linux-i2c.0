From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: at24: remove the optional property
 write-protect-gpios
Date: Wed, 4 Dec 2019 09:22:36 -0600
Message-ID: <20191204152236.GA22464@bogus>
References: <20191120142038.30746-1-ktouil@baylibre.com>
 <20191120142038.30746-4-ktouil@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191120142038.30746-4-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khouloud Touil <ktouil@baylibre.com>
Cc: bgolaszewski@baylibre.com, mark.rutland@arm.com, srinivas.kandagatla@linaro.org, baylibre-upstreaming@groups.io, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linus.walleij@linaro.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 20, 2019 at 03:20:37PM +0100, Khouloud Touil wrote:
> NVMEM framework is an interface for the at24 EEPROMs as well as for
> other drivers, instead of passing the wp-gpios over the different
> drivers each time, it would be better to pass it over the NVMEM
> subsystem once and for all.
> 
> Removing the optional property form the device tree binding document.
> 
> Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
> index e8778560d966..9894237ac432 100644
> --- a/Documentation/devicetree/bindings/eeprom/at24.yaml
> +++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
> @@ -145,11 +145,6 @@ properties:
>        over reads to the next slave address. Please consult the manual of
>        your device.
>  
> -  wp-gpios:
> -    description:
> -      GPIO to which the write-protect pin of the chip is connected.
> -    maxItems: 1
> -

At least 'wp-gpios: true' is still needed or you need to reference the 
common definition in nvmem.yaml. The reason being is every possible 
property (and child node) needs to be listed so we can have errors on 
any that aren't.

Rob
