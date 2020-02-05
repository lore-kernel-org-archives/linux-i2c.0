From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: convert i2c-cros-ec-tunnel.txt to yaml
Date: Wed, 5 Feb 2020 17:47:40 +0000
Message-ID: <20200205174740.GA10738@bogus>
References: <20200127161213.13339-1-dafna.hirschfeld@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200127161213.13339-1-dafna.hirschfeld-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dafna Hirschfeld <dafna.hirschfeld-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, helen.koike-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, ezequiel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, dafna3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 27, 2020 at 05:12:13PM +0100, Dafna Hirschfeld wrote:
> Convert the binding file i2c-cros-ec-tunnel.txt to yaml format.
> 
> This was tested and verified on ARM and ARM64 with:
> 
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
>  .../bindings/i2c/i2c-cros-ec-tunnel.txt       | 39 ------------
>  .../bindings/i2c/i2c-cros-ec-tunnel.yaml      | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt b/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
> deleted file mode 100644
> index 898f030eba62..000000000000
> --- a/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -I2C bus that tunnels through the ChromeOS EC (cros-ec)
> -======================================================
> -On some ChromeOS board designs we've got a connection to the EC (embedded
> -controller) but no direct connection to some devices on the other side of
> -the EC (like a battery and PMIC).  To get access to those devices we need
> -to tunnel our i2c commands through the EC.
> -
> -The node for this device should be under a cros-ec node like google,cros-ec-spi
> -or google,cros-ec-i2c.
> -
> -
> -Required properties:
> -- compatible: google,cros-ec-i2c-tunnel
> -- google,remote-bus: The EC bus we'd like to talk to.
> -
> -Optional child nodes:
> -- One node per I2C device connected to the tunnelled I2C bus.
> -
> -
> -Example:
> -	cros-ec@0 {
> -		compatible = "google,cros-ec-spi";
> -
> -		...
> -
> -		i2c-tunnel {
> -			compatible = "google,cros-ec-i2c-tunnel";
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			google,remote-bus = <0>;
> -
> -			battery: sbs-battery@b {
> -				compatible = "sbs,sbs-battery";
> -				reg = <0xb>;
> -				sbs,poll-retry-count = <1>;
> -			};
> -		};
> -	}
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml b/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
> new file mode 100644
> index 000000000000..c1383e607f47
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/i2c-cros-ec-tunnel.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2C bus that tunnels through the ChromeOS EC (cros-ec)
> +
> +maintainers:
> +  - Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> +  - Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> +  - Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> +
> +description: |
> +  On some ChromeOS board designs we've got a connection to the EC (embedded
> +  controller) but no direct connection to some devices on the other side of
> +  the EC (like a battery and PMIC). To get access to those devices we need
> +  to tunnel our i2c commands through the EC.
> +  The node for this device should be under a cros-ec node like google,cros-ec-spi
> +  or google,cros-ec-i2c.

You should have a ref to /schemas/i2c-controller.yaml here.

> +
> +properties:
> +  compatible:
> +    const:
> +      google,cros-ec-i2c-tunnel
> +
> +  google,remote-bus:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    description: The EC bus we'd like to talk to.
> +
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +    description: One node per I2C device connected to the tunnelled I2C bus.
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - google,remote-bus
> +
> +examples:
> +  - |
> +    cros-ec@0 {
> +        compatible = "google,cros-ec-spi";
> +        i2c-tunnel {
> +            compatible = "google,cros-ec-i2c-tunnel";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            google,remote-bus = <0>;
> +
> +            battery: sbs-battery@b {
> +                compatible = "sbs,sbs-battery";
> +                reg = <0xb>;
> +                sbs,poll-retry-count = <1>;
> +            };
> +        };
> +    };
> -- 
> 2.17.1
> 
