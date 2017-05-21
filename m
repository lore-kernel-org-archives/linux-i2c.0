From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/1] gpu: drm: tc35876x: move header file out of I2C realm
Date: Mon, 22 May 2017 00:11:14 +0200
Message-ID: <20170521221114.2685-2-wsa@the-dreams.de>
References: <20170521221114.2685-1-wsa@the-dreams.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55543 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755133AbdEUWLR (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 21 May 2017 18:11:17 -0400
In-Reply-To: <20170521221114.2685-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c | 2 +-
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c                  | 2 +-
 include/linux/{i2c => platform_data}/tc35876x.h             | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/{i2c => platform_data}/tc35876x.h (100%)

diff --git a/arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c b/arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c
index b1526b95fd43ac..2905376559f160 100644
--- a/arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_tc35876x.c
@@ -11,7 +11,7 @@
  */
 
 #include <linux/gpio.h>
-#include <linux/i2c/tc35876x.h>
+#include <linux/platform_data/tc35876x.h>
 #include <asm/intel-mid.h>
 
 /*tc35876x DSI_LVDS bridge chip and panel platform data*/
diff --git a/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c b/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c
index 771ff66711af78..37c997e24b9ebb 100644
--- a/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c
+++ b/drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c
@@ -26,7 +26,7 @@
 #include "mdfld_output.h"
 #include "mdfld_dsi_pkg_sender.h"
 #include "tc35876x-dsi-lvds.h"
-#include <linux/i2c/tc35876x.h>
+#include <linux/platform_data/tc35876x.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <asm/intel_scu_ipc.h>
diff --git a/include/linux/i2c/tc35876x.h b/include/linux/platform_data/tc35876x.h
similarity index 100%
rename from include/linux/i2c/tc35876x.h
rename to include/linux/platform_data/tc35876x.h
-- 
2.11.0
