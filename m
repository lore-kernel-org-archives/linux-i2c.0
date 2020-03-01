From: Tali Perry <tali.perry1@gmail.com>
Subject: [PATCH v8 0/3] i2c: npcm: add NPCM i2c controller driver
Date: Mon,  2 Mar 2020 00:31:58 +0200
Message-ID: <20200301223201.185450-1-tali.perry1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: brendanhiggins@google.com, avifishman70@gmail.com, tmaimon77@gmail.com, kfting@nuvoton.com, venture@google.com, yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org, wsa@the-dreams.de, andriy.shevchenko@linux.intel.com
Cc: devicetree@vger.kernel.org, kbuild test robot <lkp@intel.com>, Rob Herring <robh@kernel.org>, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, Tali Perry <tali.perry1@gmail.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

This patch set adds i2c controller support 
for the Nuvoton NPCM Baseboard Management Controller (BMC).

NPCM7xx includes 16 I2C controllers. This driver operates the controller.
This module also includes a slave mode.

---
v8 -> v7:
	- Split to two commits, one for master, one for slave.
	- Rename smb to i2c.
	- Remove global vars.

v7 -> v6:
	- Rebased on Linux 5.4-rc8  (was Linux 5.4-rc7).
	- Fix issue found by kbuild test robot (redundant include).
	- Note: left a warning related to fall through. This fall through is
	  intentional.
	
v6 -> v5:
	- Update documentation

v5 -> v4:
	- support recovery
	- master-slave switch support needed for IPMB

v4 -> v3:
	- typo on cover letter.

v3 -> v2:
	- fix dt binding: compatible name: omit "bus"

v2 -> v1:
	- run check patch in strict mode.
	- use linux crc.
	- define regs in constant offset without base.
	- remove debug prints.
	- no declarations for local functions.
	
v1: initial version

Signed-off-by: Tali Perry <tali.perry1@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reported-by: kbuild test robot <lkp@intel.com>

---
Tali Perry (3):
  dt-bindings: i2c: npcm7xx: add NPCM I2C controller documentation
  i2c: npcm7xx: Add Nuvoton NPCM I2C controller driver
  i2c: npcm7xx: Add support for slave mode for Nuvoton NPCM BMC I2C
    controller driver.

 .../devicetree/bindings/i2c/i2c-npcm7xx.txt   |   29 +
 drivers/i2c/busses/Kconfig                    |    9 +
 drivers/i2c/busses/Makefile                   |    1 +
 drivers/i2c/busses/i2c-npcm7xx.c              | 2490 +++++++++++++++++
 4 files changed, 2529 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-npcm7xx.txt
 create mode 100644 drivers/i2c/busses/i2c-npcm7xx.c


base-commit: af42d3466bdc8f39806b26f593604fdc54140bcb
-- 
2.22.0
