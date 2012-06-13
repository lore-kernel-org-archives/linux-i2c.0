From: Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
Subject: [PATCH 0/3] i2c-piix4: Multiple piix4-compatible SMBus support (revised)
Date: Wed, 13 Jun 2012 12:59:06 -0400
Message-ID: <1339606749-4578-1-git-send-email-andrew@asquaredlabs.com>
References: <20120613094739.360967aa@endymion.delvare>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120613094739.360967aa-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This is a revision to the earlier patch set I submitted, which adds
support for the secondary SMBus controller found on certain AMD
chipsets, notably the SB700 and its derivative the SP5100.

Andrew Armenia (3):
  i2c-piix4: eliminate piix4_smba global variable
  i2c-piix4: separate registration and probing code
  i2c-piix4: support AMD auxiliary SMBus controller

 Documentation/i2c/busses/i2c-piix4 |   13 ++-
 drivers/i2c/busses/Kconfig         |    6 +-
 drivers/i2c/busses/i2c-piix4.c     |  200 ++++++++++++++++++++++++++++--------
 3 files changed, 175 insertions(+), 44 deletions(-)

-- 
1.7.10
