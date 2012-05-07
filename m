From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V1 0/2] i2c: tegra: cleanup and bug fixes.
Date: Mon,  7 May 2012 12:14:06 +0530
Message-ID: <1336373047-12654-2-git-send-email-ldewangan@nvidia.com>
References: <1336373047-12654-1-git-send-email-ldewangan@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336373047-12654-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, swarren@wwwdotorg.org, olof@lixom.net, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Laxman Dewangan <ldewangan@nvidia.com>
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
