From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V1 0/2] i2c: tegra: 10 bit and M_NOSTART support
Date: Tue, 24 Apr 2012 12:49:34 +0530
Message-ID: <1335251976-31925-1-git-send-email-ldewangan@nvidia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Adding support for i2c protocoal mangling M_NOSTART and
fixes bug for 10 bit address configuration.

Laxman Dewangan (2):
  i2c: tegra: fix 10bit address configuration
  i2c: tegra: support for I2C_M_NOSTART protocol mangling

 drivers/i2c/busses/i2c-tegra.c |   41 ++++++++++++++++++++++++++++++++-------
 1 files changed, 33 insertions(+), 8 deletions(-)
