From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] i2c: xiic: Record xilinx i2c with Zynq fragment
Date: Fri,  7 Sep 2018 08:02:05 +0200
Message-ID: <a36257084b0816bd84bb1caacdcde586b7fcb007.1536300108.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, linux-i2c@vger.kernel.org, wsa@the-dreams.de
Cc: "David S. Miller" <davem@davemloft.net>, Heiko Schocher <hs@denx.de>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, u-boot@lists.denx.de, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-i2c@vger.kernel.org

Include xilinx soft i2c controller to Zynq fragment to make clear who is
responsible for it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Normally we are handling all these drivers via one fragment to make sure
that there is only one central contact. Another reason is that people are
changing and their responsibility is moving time to time.

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..d870cb57c887 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2311,6 +2311,7 @@ F:	drivers/clocksource/cadence_ttc_timer.c
 F:	drivers/i2c/busses/i2c-cadence.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
 F:	drivers/edac/synopsys_edac.c
+F:	drivers/i2c/busses/i2c-xiic.c
 
 ARM64 PORT (AARCH64 ARCHITECTURE)
 M:	Catalin Marinas <catalin.marinas@arm.com>
-- 
1.9.1
