From: Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 0/8] devicetree cleanup for i2c muxes/arbs/gates
Date: Mon, 15 Aug 2016 15:40:23 +0200
Message-ID: <1471268431-5148-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Guenter Roeck <linux@roeck-us.net>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>
List-Id: linux-i2c@vger.kernel.org

Hi!

The nxp pca9541 chip does not have any devicetree bindings.
When trying to write such bindings matching the implementation,
I stumbled upon something which I did not like. I had to
give the node holding the i2c child bus a 'reg' property that
is left unused and is really odd to explain from a devicetree
point of view. It really is a leftover from the fact that linux
implements i2c arbitrators (and i2c gates) using the i2c mux
code. See this thread for history [1].

This series resolves the issues, and maintains backwards compat
with old device trees (well, one could, in theory, create a
device tree that would break with these changes, but my guess
is that the odds for that happening inadvertedly are high...)

This should also help Crestez Dan Leonard with the mpu6050
series containing the changes for its auxiliary i2c master [2],
especially if you also consider the recent (very similar) changes
from Jon Hunter that adds an optional 'i2c-bus' subnode [3].

If this is ok, I will follow up with patches for other drivers
so that they inform the i2c mux core if they are muxes, arbs or
gates. As stated, they will continue to work with these changes,
so there is no huge rush.

The mux core does not really need to differentiate between
arbitrators and gates. Should they be folded? What to call them
in that case?

Changes since v1:

- Fixes and additions suggested by Rob Herring (3/8 still needs an ack).
- Inserted patch 6/8 so that the two arb drivers support the new more
  compact dt syntax.

Cheers,
Peter

[1] https://lkml.org/lkml/2016/6/27/203
[2] https://lkml.org/lkml/2016/5/18/355
[3] https://patchwork.ozlabs.org/patch/641934/

Peter Rosin (8):
  dt-bindings: i2c: add support for 'i2c-mux' subnode
  dt-bindings: i2c: add support for 'i2c-arb' subnode
  dt-bindings: i2c: add support for 'i2c-gate' subnode
  dt-bindings: i2c: add bindings for nxp,pca9541
  i2c: mux: add support for 'i2c-mux', 'i2c-arb' and 'i2c-gate' DT
    subnodes
  i2c: mux: inform the i2c mux core about how it is used
  i2c: pca9541: add device tree binding
  i2c: pca954x: add device tree binding

 .../bindings/i2c/i2c-arb-gpio-challenge.txt        |  8 +---
 Documentation/devicetree/bindings/i2c/i2c-arb.txt  | 35 ++++++++++++++++
 Documentation/devicetree/bindings/i2c/i2c-gate.txt | 41 +++++++++++++++++++
 Documentation/devicetree/bindings/i2c/i2c-mux.txt  | 23 ++++++++---
 .../devicetree/bindings/i2c/nxp,pca9541.txt        | 29 ++++++++++++++
 MAINTAINERS                                        |  2 +
 drivers/i2c/i2c-mux.c                              | 44 +++++++++++++++++----
 drivers/i2c/muxes/i2c-arb-gpio-challenge.c         |  2 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c                | 11 +++++-
 drivers/i2c/muxes/i2c-mux-pca954x.c                | 46 ++++++++++++++++------
 include/linux/i2c-mux.h                            |  8 +++-
 11 files changed, 214 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-arb.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gate.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/nxp,pca9541.txt

-- 
2.1.4
