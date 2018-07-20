From: Vitor soares <Vitor.Soares@synopsys.com>
Subject: [PATCH 3/3] MAINTAINERS: Add myself as the dw-i3c-master module maintainer
Date: Fri, 20 Jul 2018 21:57:52 +0100
Message-ID: <1532120272-17157-4-git-send-email-soares@synopsys.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532120272-17157-1-git-send-email-soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: boris.brezillon@bootlin.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de
Cc: psroka@cadence.com, agolec@cadence.com, adouglas@cadence.com, bfolta@cadence.com, dkos@cadence.com, alicja@cadence.com, cwronka@cadence.com, sureshp@cadence.com, rafalc@cadence.com, thomas.petazzoni@bootlin.com, nm@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linus.walleij@linaro.org, Xiang.Lin@synaptics.com, linux-gpio@vger.kernel.org, nsekhar@ti.com, pgaj@cadence.com, peda@axentia.se, Joao.Pinto@synopsys.com, Vitor.Soares@synopsys.com
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Vitor soares <soares@synopsys.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f3e3cb2..d284ba3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6773,6 +6773,12 @@ F:	drivers/i3c/
 F:	include/linux/i3c/
 F:	include/dt-bindings/i3c/
 
+I3C DRIVER FOR SYNOPSYS DESIGNWARE
+M:	Vitor Soares <soares@synopsys.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
+F:	drivers/i3c/master/dw*
+
 IA64 (Itanium) PLATFORM
 M:	Tony Luck <tony.luck@intel.com>
 M:	Fenghua Yu <fenghua.yu@intel.com>
-- 
2.7.4
