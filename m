From: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] Dove - Support init val. for i2c delay after STOP
Date: Thu, 31 Mar 2011 16:40:09 +0200
Message-ID: <1301582411-2437-3-git-send-email-kostap@marvell.com>
References: <1301582411-2437-1-git-send-email-kostap@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1301582411-2437-1-git-send-email-kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add initialization value for delay after STOP bit for Dove i2c
controller (mv-64xxx driver).

Signed-off-by: Konstantin Porotchkin <kostap-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-dove/common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index e06a88f..7ebc82f 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -497,6 +497,7 @@ void __init dove_spi1_init(void)
 static struct mv64xxx_i2c_pdata dove_i2c_data = {
 	.freq_m		= 10, /* assumes 166 MHz TCLK gets 94.3kHz */
 	.freq_n		= 3,
+	.delay_after_stop = 3, /* 3 ms delay needed when freq is 94.3kHz */
 	.timeout	= 1000, /* Default timeout of 1 second */
 };
 
-- 
1.7.4.1
