From: "Jayachandran C." <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Subject: [PATCH UPDATED] Support for Netlogic XLR/XLS I2C controller
Date: Wed, 18 Jan 2012 21:03:21 +0530
Message-ID: <1326900802-27831-1-git-send-email-jayachandranc@netlogicmicro.com>
References: <20120117232318.GB7774@freya.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120117232318.GB7774-RazCHl0VsYgkUSuvROHNpA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>

This version addresses the review comments by Wolfram and Ben to the
previous version (BTW, thanks Wolfram for the detailed review).

The adap.class is set to I2C_CLASS_HWMON, because we have a temparature
sensor on the I2C bus, and I have added a udelay in both the tx and rx
loops so that we are not completely relying on number of retries.

Also as I noted earlier, it is a polling driver, but that is not an issue
in our current usage (and we have many CPUs on-chip).

Ganesan Ramalingam (1):
  i2c: Support for Netlogic XLR/XLS I2C controller.

 drivers/i2c/busses/Kconfig   |   14 ++
 drivers/i2c/busses/Makefile  |    1 +
 drivers/i2c/busses/i2c-xlr.c |  285 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 300 insertions(+), 0 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-xlr.c

-- 
1.7.5.4
