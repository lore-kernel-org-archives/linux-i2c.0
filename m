From: "Jayachandran C" <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 0/2] i2c: open cores I2C changes for XLP
Date: Tue, 8 May 2012 18:55:27 +0530
Message-ID: <1336483529-19140-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The two patches are to support the OpenCores based I2C controller
integrated into the Netlogic XLP SoC (this is different from the
Netlogic XLR I2C controller submitted earlier).

The first patch is to register i2c devices with of_i2c_register_devices(),
which is needed to add i2c devices from the FDT. The second patch is to
support a 'regwidth' parameter (both platform and device tree), that allows
us do 16-bit or 32-bit register read/write. XLP requires 32-bit IO to its
I2C register space and will use 'regwidth = 4' in its device tree.

Please let us know your comments.

Thanks,
JC.

Ganesan Ramalingam (2):
  i2c-ocore: register OF i2c devices
  i2c-ocore: support 16 and 32-bit wide registers

 drivers/i2c/busses/i2c-ocores.c |   37 ++++++++++++++++++++++++++++++++++---
 include/linux/i2c-ocores.h      |    1 +
 2 files changed, 35 insertions(+), 3 deletions(-)

-- 
1.7.9.5
