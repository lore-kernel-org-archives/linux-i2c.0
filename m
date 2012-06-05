From: "Jayachandran C" <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 0/4] I2C Ocores updates
Date: Tue, 5 Jun 2012 21:11:04 +0530
Message-ID: <1338910868-12318-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org, Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

[devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org copied since most of the changes are 
 device tree related]

While trying to add reg-io-width property to i2c-ocores, we noticed
a few things that needs to fixed up in i2c-ocores device tree code.

The changes are to: 
 * use the standard 'reg-shift' property instead of 'regstep'
 * fix the fallout of the about change in drivers/mfd/timberdale.c
 * move bindings documentation to under Documentation/, 
 * fix up formatting, and add \n to a few dev_* messages,
 * and finally to add reg-io-width optional property.

Regards,
JC.

Ganesan Ramalingam (2):
  i2c: i2c-ocores: Use reg-shift property
  i2c: i2c-ocores: support for 16bit and 32bit IO

Jayachandran C (2):
  i2c: i2c-ocores - DT bindings and minor fixes.
  V4L/DVB: mfd: use reg_shift instead of regstep

 .../devicetree/bindings/i2c/i2c-ocores.txt         |   33 +++++++
 drivers/i2c/busses/i2c-ocores.c                    |   96 +++++++++-----------
 drivers/mfd/timberdale.c                           |    2 +-
 include/linux/i2c-ocores.h                         |    7 +-
 4 files changed, 83 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-ocores.txt

-- 
1.7.9.5
