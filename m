From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 04/10] dt-bindings: clock: Add documentation for AD242x clock providers
Date: Mon, 23 Dec 2019 23:32:27 -0800
Message-ID: <20191224073228.68302206B7@mail.kernel.org>
References: <20191209183511.3576038-1-daniel@zonque.org> <20191209183511.3576038-6-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209183511.3576038-6-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mturquette@baylibre.com, robh+dt@kernel.org, broonie@kernel.org, lee.jones@linaro.org, lars@metafoo.de, pascal.huerst@gmail.com, Daniel Mack <daniel@zonque.org>
List-Id: linux-i2c@vger.kernel.org

Quoting Daniel Mack (2019-12-09 10:35:05)
> diff --git a/Documentation/devicetree/bindings/clock/adi,ad242x-clk.yaml =
b/Documentation/devicetree/bindings/clock/adi,ad242x-clk.yaml
> new file mode 100644
> index 000000000000..f434b3e4928e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/adi,ad242x-clk.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/clock/adi,ad242x-clk.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Analog Devices AD242x clock provider
> +
> +maintainers:
> +  - Daniel Mack <daniel@zonque.org>
> +
> +description: |
> +  This module is part of the AD242x MFD device. For more details and an =
example
> +  refer to Documentation/devicetree/bindings/mfd/ad242x.yaml.

I think we usually leave off Documentation/devicetree/ from paths when
they're inside the bindings directory.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad2428w-clk
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clock-output-names:
> +    minItems: 2
> +    maxItems: 2
> +    description: |
> +      Array of two strings to use as names for the generated output cloc=
ks
> +
> +required:
> +  - compatible
> +  - '#clock-cells'
> \ No newline at end of file

Why no newline at end of file? Is there an example?
