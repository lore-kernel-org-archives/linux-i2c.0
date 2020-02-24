From: Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 04/89] i2c: brcmstb: Allow to compile it on BCM2835
Date: Mon, 24 Feb 2020 10:06:06 +0100
Message-ID: <0ec2a26c7492b1ef6554d3bdada7a6fb8b41ab1c.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Eric Anholt <eric@anholt.net>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Tim Gover <tim.gover@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, Wolfram Sang <wsa@the-dreams.de>, Kamal Dasu <kdasu.kdev@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, Phil Elwell <phil@raspberrypi.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime@cerno.tech>
List-Id: linux-i2c@vger.kernel.org

The BCM2711, supported by ARCH_BCM2835, also has a controller by the
brcmstb driver so let's allow it to be compiled on that platform.

Cc: Kamal Dasu <kdasu.kdev@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 2ddca08f8a76..9b8494de4a59 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -476,7 +476,7 @@ config I2C_BCM_KONA
 config I2C_BRCMSTB
 	tristate "BRCM Settop/DSL I2C controller"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_63XX || \
-		   COMPILE_TEST
+		   COMPILE_TEST || ARCH_BCM2835
 	default y
 	help
 	  If you say yes to this option, support will be included for the
-- 
git-series 0.9.1
