From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 0/3] Delay I2C OF IRQ mapping until probe time
Date: Thu, 30 Oct 2014 15:59:35 +0200
Message-ID: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Hello,

I recently ran into an issue with the OF IRQ parsing code in the I2C core
(of_i2c_register_devices in drivers/i2c/i2c-core.c).

My DT contains the following nodes.

        gpio1: gpio@e6051000 {
                ...
                #interrupt-cells = <2>;
                interrupt-controller;
                clocks = <&mstp9_clks R8A7790_CLK_GPIO1>;
        };

        iic2: i2c@e6520000 {
                #address-cells = <1>;
                #size-cells = <0>;
                ...
                hdmi@39 {
                        compatible = "adi,adv7511w";
                        reg = <0x39>;
                        interrupt-parent = <&gpio1>;
                        interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
                        ...
                };
        };

        mstp9_clks: mstp9_clks@e6150994 {
                ...
        };

The i2c@e6520000 node is probed before the gpio@e6051000 node. The
of_i2c_register_devices() function tries to register all children, including
hdmi@39. It tries to parse and map the I2C client IRQ by calling
irq_of_parse_and_map(), which returns 0 as the interrupt controller isn't
probed yet. The adv7511 driver later probes the hdmi@39 device and gets
client->irq set to 0.

As we can't control the probe order in the general case we need to rely on
deferred probing. This patch series is an attempt to do so, by moving IRQ
mapping from device registration time to device probe time were probing can be
deferred.

Laurent Pinchart (3):
  of/irq: Export of_irq_get()
  i2c: core: Dispose OF IRQ mapping at client removal time
  i2c: core: Map OF IRQ at probe time

 drivers/i2c/i2c-core.c | 14 ++++++++++++--
 drivers/of/irq.c       |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
Regards,

Laurent Pinchart
