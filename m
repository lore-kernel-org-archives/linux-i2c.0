From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH 0/3] Automatically register i2c devices from the device tree
Date: Thu, 24 Jun 2010 14:11:44 -0600
Message-ID: <20100624200509.10527.513.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, wg-ynQEQJNshbs@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The following series adds automatic registration of i2c devices from
OF device tree data.  If the i2c bus has the of_node pointer set, then
it will use that node pointer as the parent for a set of i2c devices and
automatically register the child nodes as new i2c devices.

When CONFIG_OF is not set, the of i2c hooks become empty stubs.

---

Grant Likely (3):
      of/i2c: Generalize OF support
      i2c: Add OF-style registration and binding
      of: refactor of_modalias_node() and remove explicit match table.


 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |    6 ++
 drivers/i2c/busses/i2c-cpm.c                   |    6 --
 drivers/i2c/busses/i2c-ibm_iic.c               |    4 --
 drivers/i2c/busses/i2c-mpc.c                   |    2 -
 drivers/i2c/i2c-core.c                         |    9 +++
 drivers/mmc/host/mmc_spi.c                     |    8 +++
 drivers/of/Kconfig                             |    2 -
 drivers/of/base.c                              |   64 +++---------------------
 drivers/of/of_i2c.c                            |   50 +++++++++++--------
 include/linux/of_i2c.h                         |   13 ++++-
 10 files changed, 75 insertions(+), 89 deletions(-)
