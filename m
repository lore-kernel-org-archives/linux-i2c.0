From: Jean Delvare <khali@linux-fr.org>
Subject: [GIT PULL] i2c fixes for 2.6.25
Date: Sun, 24 Feb 2008 20:24:01 +0100
Message-ID: <20080224202401.4dc26735@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756612AbYBXTYV@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux I2C <i2c@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

Linus,

Please pull the i2c subsystem fixes for Linux 2.6.25 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 i2c-for-linus


 Documentation/i2c/busses/i2c-i801     |    3 ++-
 arch/arm/mach-omap1/board-sx1.c       |    2 ++
 drivers/i2c/busses/Kconfig            |    2 ++
 drivers/i2c/busses/i2c-i801.c         |   10 ++++++++--
 drivers/i2c/busses/i2c-pca-isa.c      |    7 +++++++
 drivers/i2c/busses/i2c-pmcmsp.c       |    4 ++--
 drivers/i2c/busses/i2c-pxa.c          |   25 ++++++++++++++-----------
 include/asm-mips/mach-db1x00/db1200.h |    1 +
 include/asm-mips/mach-db1x00/db1x00.h |    1 +
 include/asm-mips/mach-pb1x00/pb1200.h |    1 +
 include/asm-mips/mach-pb1x00/pb1550.h |    1 +
 include/linux/i2c.h                   |   11 +++++++++--
 12 files changed, 50 insertions(+), 18 deletions(-)

---------------

Christian Krafft (1):
      i2c-pca-isa: Add access check to legacy ioports

David Brownell (1):
      i2c: Make i2c_register_board_info() a NOP when CONFIG_I2C_BOARDINFO=n

Gaston, Jason D (1):
      i2c-i801: Add support for the ICH10

Jean Delvare (1):
      ARM: OMAP: Release i2c_adapter after use (Siemens SX1)

Manuel Lauss (1):
      Alchemy: compile fix

Tobias Klauser (1):
      i2c: Storage class should be before const qualifier

Wolfram Sang (1):
      i2c-pxa: Misc fixes

Thanks,
-- 
Jean Delvare
