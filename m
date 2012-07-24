From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for Linux 3.6
Date: Tue, 24 Jul 2012 14:52:09 +0200
Message-ID: <20120724145209.6b0ff2e7@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 3.6 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

The most important changes here are a big cleanup of the i2c-piix4
driver, cleanups and interrupt support to the i2c-i801 driver, and
support for the SCCB protocol.

 Documentation/i2c/busses/i2c-i801          |   13 +-
 Documentation/i2c/busses/i2c-piix4         |    9 +
 Documentation/i2c/writing-clients          |   23 ++-
 drivers/i2c/busses/Kconfig                 |    6 +-
 drivers/i2c/busses/i2c-ali1535.c           |   13 +-
 drivers/i2c/busses/i2c-ali1563.c           |   14 +-
 drivers/i2c/busses/i2c-ali15x3.c           |   13 +-
 drivers/i2c/busses/i2c-amd756.c            |   13 +-
 drivers/i2c/busses/i2c-amd8111.c           |   13 +-
 drivers/i2c/busses/i2c-designware-pcidrv.c |   12 +-
 drivers/i2c/busses/i2c-diolan-u2c.c        |    2 +-
 drivers/i2c/busses/i2c-eg20t.c             |   12 +-
 drivers/i2c/busses/i2c-hydra.c             |   17 +--
 drivers/i2c/busses/i2c-i801.c              |  343 +++++++++++++++++++++-------
 drivers/i2c/busses/i2c-intel-mid.c         |   13 +-
 drivers/i2c/busses/i2c-nforce2.c           |   14 +-
 drivers/i2c/busses/i2c-omap.c              |    5 +-
 drivers/i2c/busses/i2c-pasemi.c            |   13 +-
 drivers/i2c/busses/i2c-piix4.c             |  209 +++++++++++++-----
 drivers/i2c/busses/i2c-pxa-pci.c           |   12 +-
 drivers/i2c/busses/i2c-sis630.c            |   15 +--
 drivers/i2c/busses/i2c-sis96x.c            |   15 +--
 drivers/i2c/busses/i2c-tiny-usb.c          |    1 +
 drivers/i2c/busses/i2c-via.c               |   14 +-
 drivers/i2c/i2c-core.c                     |   16 +-
 drivers/i2c/i2c-smbus.c                    |   13 +-
 drivers/i2c/muxes/i2c-mux-pca9541.c        |    2 +-
 drivers/staging/media/go7007/wis-i2c.h     |    5 -
 include/linux/i2c.h                        |    3 +
 29 files changed, 487 insertions(+), 366 deletions(-)

---------------

Andrew Armenia (3):
      i2c-piix4: Eliminate piix4_smba global variable
      i2c-piix4: Separate registration and probing code
      i2c-piix4: Support AMD auxiliary SMBus controller

Axel Lin (1):
      i2c/busses: Use module_pci_driver

Daniel Kurtz (7):
      i2c-i801: Refactor use of LAST_BYTE in i801_block_transaction_byte_by_byte
      i2c-i801: Clear only status bits in HST_STS
      i2c-i801: Check and return errors during byte-by-byte transfers
      i2c-i801: Rename some SMBHSTCNT bit constants
      i2c-i801: Drop ENABLE_INT9
      i2c-i801: Enable IRQ for SMBus transactions
      i2c-i801: Enable IRQ for byte_by_byte transactions

Emmanuel Deloget (1):
      i2c-tiny-usb: Add support for the Robofuzz OSIF USB/I2C converter

Fabio Estevam (1):
      i2c-smbus: Use module_i2c_driver()

Guenter Roeck (1):
      i2c: Update Guenter Roeck's e-mail address

Jean Delvare (3):
      i2c/writing-clients: Mention module_i2c_driver()
      i2c-i801: Consolidate polling
      i2c-i801: Enable interrupts on ICH5/7/8/9/10

Laurent Pinchart (3):
      i2c: Add SCCB support
      i2c: Fall back to emulated SMBus if the operation isn't supported natively
      i2c-omap: Add support for I2C_M_STOP message flag

Thanks,
-- 
Jean Delvare
