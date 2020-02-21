From: Enric Balletbo i Serra <enric.balletbo-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: i2c: cros-ec-tunnel: convert
 i2c-cros-ec-tunnel.txt to yaml
Date: Fri, 21 Feb 2020 16:28:59 +0100
Message-ID: <f903795e-cd62-7407-2da2-bea3a1df8da0@collabora.com>
References: <20200221123214.26341-1-dafna.hirschfeld@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200221123214.26341-1-dafna.hirschfeld-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dafna Hirschfeld <dafna.hirschfeld-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, helen.koike-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, ezequiel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, dafna3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sebastian.reichel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Dafna,

On 21/2/20 13:32, Dafna Hirschfeld wrote:
> Convert the binding file i2c-cros-ec-tunnel.txt to yaml format.
> 
> This was tested and verified on ARM and ARM64 with:
> 
> make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
> make dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
> 
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> ---
> Changes since v1:
> - changing the subject to start with "dt-bindings: i2c: cros-ec-tunnel:"
> - changing the license to (GPL-2.0-only OR BSD-2-Clause)
> - removing "Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>" from the maintainers list
> - adding ref: /schemas/i2c/i2c-controller.yaml
> 
> Changes since v2:
> - adding another patch that fixes a warning found by this patch
> 
> Changes since v3:
> - In the example, change sbs-battery@b to battery@b
> 
> 
>  .../bindings/i2c/i2c-cros-ec-tunnel.txt       | 39 ------------
>  .../bindings/i2c/i2c-cros-ec-tunnel.yaml      | 63 +++++++++++++++++++
>  2 files changed, 63 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
> 

According to the feedback I received on another patch from Rob, seems that you
should name the file with the full compatible string
"google,i2c-cros-ec-tunnel.yaml"

I know we didn't do this with the extcon-usbc-cros-ec.yaml but seems this is the
right way to do it. Just take this in consideration for future patches.


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
> index 000000000000..cfe4f0aeb46f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
> +
> +description: |
> +  On some ChromeOS board designs we've got a connection to the EC (embedded
> +  controller) but no direct connection to some devices on the other side of
> +  the EC (like a battery and PMIC). To get access to those devices we need
> +  to tunnel our i2c commands through the EC.
> +  The node for this device should be under a cros-ec node like google,cros-ec-spi
> +  or google,cros-ec-i2c.
> +
> +allOf:
> +  - $ref: /schemas/i2c/i2c-controller.yaml#
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

Like we did with the extcon-usbc-cros-ec.yaml I think would be nice have a
complete example here too.

+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cros-ec@0 {
+            compatible = "google,cros-ec-spi";
+            reg = <0>;


> +        i2c-tunnel {
> +            compatible = "google,cros-ec-i2c-tunnel";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            google,remote-bus = <0>;
> +
> +            battery: battery@b {
> +                compatible = "sbs,sbs-battery";
> +                reg = <0xb>;
> +                sbs,poll-retry-count = <1>;
> +            };
> +        };
> +    };
> 
