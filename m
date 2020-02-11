From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 06/14] MIPS: CI20: defconfig: compile leds-gpio driver into the kernel and configure for LED triggers
Date: Tue, 11 Feb 2020 22:41:23 +0100
Message-ID: <235c328ff497b5e14009ad9f4e12d2db9520f4d9.1581457290.git.hns@goldelico.com>
References: <cover.1581457290.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1581457290.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>, Paul Boddie <paul@boddie.org.uk>, Alex Smith <alex.smith@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "David S. Miller" <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Andi Kleen <ak@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Miquel Raynal <miquel.raynal@bootlin.com>, =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>, Richard Fontana <rfontana@redhat.com>
Cc: devicetree@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org, netdev@vger.kernel.org, linux-gpio@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-i2c@vger.kernel.org

DTS has been augmented to add some gpio-leds. We need the leds-gpio driver
and enable the triggers.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/configs/ci20_defconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index e0d3c9d4c2ae..30a47a7a2994 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -167,3 +167,16 @@ CONFIG_STACKTRACE=y
 # CONFIG_FTRACE is not set
 CONFIG_CMDLINE_BOOL=y
 CONFIG_CMDLINE="earlycon console=ttyS4,115200 clk_ignore_unused"
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_MTD=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_ONESHOT=y
+CONFIG_LEDS_TRIGGER_ONESHOT=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_BACKLIGHT=m
+CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
+CONFIG_LEDS_TRIGGER_TRANSIENT=y
+CONFIG_LEDS_TRIGGER_CAMERA=m
-- 
2.23.0
