From: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH] Support for Netlogic XLR/XLS I2C controller
Date: Tue, 17 Jan 2012 19:18:19 +0530
Message-ID: <1326808100-22540-1-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, inux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>

This patch adds support to the I2C controller on Netlogic XLR/XLS
multi-core MIPS SoCs.

The patch has been sent out a many times already, and all the comments
we have seen are already taken care of.

It is a polling driver, but that is not an issue in our current usage
(and we have many CPUs on-chip).

Ganesan Ramalingam (1):
  i2c: Support for Netlogic XLR/XLS I2C controller.

 drivers/i2c/busses/Kconfig   |   14 ++
 drivers/i2c/busses/Makefile  |    1 +
 drivers/i2c/busses/i2c-xlr.c |  307 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 322 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-xlr.c

-- 
1.7.5.4
