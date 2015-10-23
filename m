From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 0/2] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
Date: Fri, 23 Oct 2015 19:51:58 +0900
Message-ID: <1445597520-6299-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Andrew Bresticker <abrestic@chromium.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, David Box <david.e.box@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Xudong Chen <xudong.chen@mediatek.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Subhendu Sekhar Behera <sbehera@broadcom.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Feng Kan <fkan@apm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jiri Slaby <jslaby@suse.com>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, devicetree@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Pawel Moll <pawel.moll@ar>
List-Id: linux-i2c@vger.kernel.org


This series adds two I2C controller drivers.
(they are completely different IPs.)

The first one is a very simple FIFO-less I2C controller,
which is used on some older UniPhier SoCs.

The other one is higher-performance I2C controller with TX/RX FIFO,
used on newer UniPhier SoCs.


Changes in v2:
  - Delete if-block after platform_get_resource()
  - Add I2C_FUNC_SMBUS_EMUL to functionality
  - Add bindings document
  - Add entry to MAINTAINERS
  - Delete if-block after platform_get_resource()
  - Add I2C_FUNC_SMBUS_EMUL to functionality
  - Add bindings document
  - Fix a typo in a comment block

Masahiro Yamada (2):
  i2c: uniphier: add UniPhier FIFO-less I2C driver
  i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver

 .../devicetree/bindings/i2c/i2c-uniphier-f.txt     |  25 +
 .../devicetree/bindings/i2c/i2c-uniphier.txt       |  25 +
 MAINTAINERS                                        |   1 +
 drivers/i2c/busses/Kconfig                         |  16 +
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-uniphier-f.c                | 584 +++++++++++++++++++++
 drivers/i2c/busses/i2c-uniphier.c                  | 441 ++++++++++++++++
 7 files changed, 1094 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier-f.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
 create mode 100644 drivers/i2c/busses/i2c-uniphier-f.c
 create mode 100644 drivers/i2c/busses/i2c-uniphier.c

-- 
1.9.1
