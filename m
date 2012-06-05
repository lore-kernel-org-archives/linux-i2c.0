From: Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
Subject: [PATCH 0/3] Multiple piix4-compatible SMBus support
Date: Mon,  4 Jun 2012 21:49:21 -0400
Message-ID: <1338860964-10803-1-git-send-email-andrew@asquaredlabs.com>
References: <20120604091643.208956fe@endymion.delvare>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120604091643.208956fe-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Armenia <andrew-Lwj1yN59in/Ib2jZbfQ/kQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

These patches make it easier to support multiple SMBus controllers
that may be present within one piix4-compatible PCI device, and
enable support for the secondary SMBus controller found in the AMD
SP5100 chipset.

Andrew Armenia (3):
  i2c-piix4: eliminate global I/O base address
  i2c-piix4: separate registration and probing code
  i2c-piix4: support aux SMBus on AMD chipsets

 drivers/i2c/busses/i2c-piix4.c |  179 +++++++++++++++++++++++++++++++++-------
 1 file changed, 151 insertions(+), 28 deletions(-)

-- 
1.7.10
