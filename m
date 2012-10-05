From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [GIT PULL] i2c updates for Linux 3.7
Date: Fri, 5 Oct 2012 23:26:01 +0200
Message-ID: <20121005232601.7e505c84@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Linus,

Please pull i2c subsystem updates for Linux 3.7 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git i2c-for-linus

Most visible changes are the SMBus multiplexing support added to the
i2c-i801 driver, as well as support for the VIA VX900.

 Documentation/i2c/busses/i2c-viapro      |    6 +-
 Documentation/i2c/muxes/i2c-mux-gpio     |   18 +++
 drivers/i2c/Kconfig                      |   17 +++-
 drivers/i2c/busses/Kconfig               |   18 +---
 drivers/i2c/busses/i2c-designware-core.c |    2 +-
 drivers/i2c/busses/i2c-i801.c            |  185 +++++++++++++++++++++++++++++-
 drivers/i2c/busses/i2c-parport.c         |    2 +-
 drivers/i2c/busses/i2c-piix4.c           |    1 +
 drivers/i2c/busses/i2c-viapro.c          |    3 +
 drivers/i2c/busses/scx200_acb.c          |   24 ++--
 drivers/i2c/busses/scx200_i2c.c          |   15 +--
 drivers/i2c/i2c-core.c                   |   16 ++-
 drivers/i2c/i2c-mux.c                    |   22 ++++
 drivers/i2c/i2c-smbus.c                  |   11 +-
 drivers/i2c/muxes/i2c-mux-gpio.c         |   56 +++++++---
 drivers/i2c/muxes/i2c-mux-pca9541.c      |    2 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c      |   10 +-
 drivers/i2c/muxes/i2c-mux-pinctrl.c      |    2 +-
 include/linux/i2c-mux-gpio.h             |    5 +
 include/linux/i2c-mux.h                  |    1 +
 include/linux/i2c.h                      |    2 +-
 include/linux/i2c/pca954x.h              |    1 +
 include/linux/pci_ids.h                  |    1 +
 23 files changed, 347 insertions(+), 73 deletions(-)

---------------

Daniel J Blueman (1):
      i2c-piix4: Fix build failure

Jean Delvare (8):
      i2c-mux: Add support for device auto-detection
      i2c-designware: i2c_dw_xfer_msg can be static
      i2c-parport: i2c_parport_irq can be static
      i2c-viapro: Add VIA VX900 device ID
      i2c-i801: Support SMBus multiplexing on Asus Z8 series
      i2c-mux-gpio: Add support for dynamically allocated GPIO pins
      i2c-mux-gpio: Update documentation
      i2c-i801: Let i2c-mux-gpio find the GPIO chip

Jim Cromie (1):
      i2c/scx200_*: Replace printks with pr_<level>s

Julia Lawall (1):
      i2c-smbus: Convert kzalloc to devm_kzalloc

Maxime Ripard (1):
      i2c-mux-gpio: Use devm_kzalloc instead of kzalloc

Peter Huewe (1):
      i2c: Make I2C available on UML

Shubhrajyoti D (1):
      i2c: Convert struct i2c_msg initialization to C99 format

Vivien Didelot (1):
      i2c: Correct struct i2c_driver doc about detection

Thanks,
-- 
Jean Delvare
