From: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>
Subject: [PATCHv8 3/5] Documentation: DT: Add entry for Freescale LS1043a-RDB board
Date: Tue, 17 Nov 2015 17:53:20 +0800
Message-ID: <1447754002-40555-3-git-send-email-Zhiqiang.Hou@freescale.com>
References: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1447754002-40555-1-git-send-email-Zhiqiang.Hou@freescale.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Cc: mark.rutland@arm.com, linux@roeck-us.net, wsa@the-dreams.de, wim@iguana.be, corbet@lwn.net, mturquette@baylibre.com, sboyd@codeaurora.org, Mingkai.Hu@freescale.com, Shaohui.Xie@freescale.com, scottwood@freescale.com, bhupesh.sharma@freescale.com, Wenbin.Song@freescale.com, B48286@freescale.com
List-Id: linux-i2c@vger.kernel.org

From: Mingkai Hu <Mingkai.Hu@freescale.com>

Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
V8 - V2:
 - No change.

 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 34c88b0..752a685 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -131,6 +131,10 @@ Example:
 Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
 ----------------------------------------------------------------
 
+LS1043A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,ls1043a-rdb", "fsl,ls1043a";
+
 LS2080A ARMv8 based Simulator model
 Required root node properties:
     - compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
-- 
2.1.0.27.g96db324

