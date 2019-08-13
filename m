From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH V2 09/13] dt-bindings: arm: Convert BCM2835 board/soc
 bindings to json-schema
Date: Tue, 13 Aug 2019 11:22:56 -0600
Message-ID: <CAL_Jsq+01vXQpf_ZuAvetWvcGLhK4EiiB1qFqhRkM3PQWAzdsA@mail.gmail.com>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
 <1565713248-4906-10-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565713248-4906-10-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>, Michael Turquette <mturquette@baylibre.com>, Eric Anholt <eric@anholt.net>, "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, Linux I2C <linux-i2c@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Aug 13, 2019 at 10:21 AM Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Convert the BCM2835/6/7 SoC bindings to DT schema format using json-schema.
> All the other Broadcom boards are maintained by Florian Fainelli.
>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> Acked-by: Eric Anholt <eric@anholt.net>
> ---
>  .../devicetree/bindings/arm/bcm/bcm2835.yaml       | 46 +++++++++++++++
>  .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   | 67 ----------------------
>  2 files changed, 46 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
>
> diff --git a/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
> new file mode 100644
> index 0000000..1a4be26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/bcm2835.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/bcm/bcm2835.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom BCM2711/BCM2835 Platforms Device Tree Bindings
> +
> +maintainers:
> +  - Eric Anholt <eric@anholt.net>
> +  - Stefan Wahren <wahrenst@gmx.net>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: BCM2835 based Boards
> +        items:
> +          - enum:
> +              - raspberrypi,model-a
> +              - raspberrypi,model-a-plus
> +              - raspberrypi,model-b
> +              - raspberrypi,model-b-i2c0  # Raspberry Pi Model B (no P5)
> +              - raspberrypi,model-b-rev2
> +              - raspberrypi,model-b-plus
> +              - raspberrypi,compute-module
> +              - raspberrypi,model-zero
> +              - raspberrypi,model-zero-w
> +          - const: brcm,bcm2835
> +
> +      - description: BCM2836 based Boards
> +        items:
> +          - enum:
> +              - raspberrypi,2-model-b

Don't you need brcm,bcm2836 here?

> +
> +      - description: BCM2837 based Boards
> +        items:
> +          - enum:
> +              - raspberrypi,3-model-a-plus
> +              - raspberrypi,3-model-b
> +              - raspberrypi,3-model-b-plus
> +              - raspberrypi,3-compute-module
> +              - raspberrypi,3-compute-module-lite

Don't you need brcm,bcm2837 here?

Please run 'dtbs_check' and make sure there aren't warnings (in the root node).

Rob
