From: <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Subject: [PATCH 0/6] i2c: designeware: Add Baikal-T1 SoC DW I2C specifics support
Date: Fri, 6 Mar 2020 16:19:49 +0300
Message-ID: <20200306132001.1B875803087C@mail.baikalelectronics.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Serge Semin <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>, Serge Semin <fancer.lancer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexey Malahov <Alexey.Malahov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>, Maxim Kaurkin <Maxim.Kaurkin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>, Pavel Parkhomenko <Pavel.Parkhomenko-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>, Ramil Zaripov <Ramil.Zaripov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>, Ekaterina Skachko <Ekaterina.Skachko-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>, Vadim Vlasov <V.Vlasov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>, Thomas Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>, Paul Burton <paulburton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Wolfram
List-Id: linux-i2c@vger.kernel.org

From: Serge Semin <fancer.lancer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

There are three DW I2C controllers embedded into the Baikal-T1 SoC. Two
of them are normal with standard DW I2C IP-core configurations and registers
accessible over normal MMIO space - so they are acceptable by the available
DW I2C driver with no modification. But there is a third, which is a bit
different. Its registers are indirectly accessed be means of "command/data
in/data out" registers tuple. In order to have it also supported by the DW
I2C driver, we must modify the code a bit. This is a main purpose of this
patchset.

First of all traditionally we replaced the legacy plain text-based dt-binding
file with yaml-based one. Then we found and fixed a bug in the DW I2C FIFO size
detection algorithm which tried to do it too early before dw_readl/dw_writel
methods could be used. Finally we introduced a platform-specific flag
ACCESS_INDIRECT, which would enable the indirect access to the DW I2C registers
implemented for one of the Baikal-T1 SoC DW I2C controllers. See the commit
message of the corresponding patch for details.

This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
commit 98d54f81e36b ("Linux 5.6-rc4").

Signed-off-by: Serge Semin <Sergey.Semin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Signed-off-by: Alexey Malahov <Alexey.Malahov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Cc: Maxim Kaurkin <Maxim.Kaurkin-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Cc: Pavel Parkhomenko <Pavel.Parkhomenko-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Cc: Ramil Zaripov <Ramil.Zaripov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Cc: Ekaterina Skachko <Ekaterina.Skachko-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Cc: Vadim Vlasov <V.Vlasov-UN2wsyeM1qLJ45LvJ/SUn8gurn75+9Lz@public.gmane.org>
Cc: Thomas Bogendoerfer <tsbogend-I1c7kopa9pxLokYuJOExCg@public.gmane.org>
Cc: Paul Burton <paulburton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Serge Semin (6):
  scripts/dtc: check: Add additional i2c reg flags support
  dt-bindings: i2c: Replace DW I2C legacy bindings with YAML-based one
  dt-bindings: i2c: dw: Add Baikal-T1 SoC I2C controller
  i2c: designware: Detect the FIFO size in the common code
  i2c: designware: Discard i2c_dw_read_comp_param() function
  i2c: designware: Add Baikal-T1 SoC I2C controller support

 .../bindings/i2c/i2c-designware.txt           |  73 --------
 .../bindings/i2c/snps,designware-i2c.yaml     | 158 ++++++++++++++++++
 drivers/i2c/busses/i2c-designware-common.c    | 107 ++++++++++--
 drivers/i2c/busses/i2c-designware-core.h      |  16 +-
 drivers/i2c/busses/i2c-designware-master.c    |   3 +
 drivers/i2c/busses/i2c-designware-platdrv.c   |  25 +--
 drivers/i2c/busses/i2c-designware-slave.c     |   3 +
 scripts/dtc/checks.c                          |  13 +-
 8 files changed, 280 insertions(+), 118 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-designware.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml

-- 
2.25.1
