From: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V1 0/2] i2c: tegra: cleanup and bug fixes.
Date: Mon,  7 May 2012 12:16:18 +0530
Message-ID: <1336373179-12739-2-git-send-email-ldewangan@nvidia.com>
References: <1336373179-12739-1-git-send-email-ldewangan@nvidia.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1336373179-12739-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Following two changes:
1. Using devm_* for all allocation.
    This will reduce the code size for freeing resources.
2. Notifying transfer complete after clearing the interrupt status.
   This is to avoid the misconfiguration of i2c register in multi-core
   environment.

Laxman Dewangan (2):
  i2c: tegra: make all resource allocation through devm_*
  i2c: tegra: notify transfer-complete after clearing status.

 drivers/i2c/busses/i2c-tegra.c |   79 +++++++++++++---------------------------
 1 files changed, 25 insertions(+), 54 deletions(-)
