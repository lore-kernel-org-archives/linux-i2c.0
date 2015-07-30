From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 0/3] i2c: uniphier: add two I2C controller drivers for
 UniPhier SoC platform
Date: Thu, 30 Jul 2015 17:12:19 +0900
Message-ID: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Baruch Siach <baruch@tkos.co.il>, Wolfram Sang <wsa@the-dreams.de>, Andrew Bresticker <abrestic@chromium.org>, Sachin Kamat <sachin.kamat@samsung.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, David Box <david.e.box@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Xudong Chen <xudong.chen@mediatek.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Subhendu Sekhar Behera <sbehera@broadcom.com>, Wei Yan <sledge.yanwei@huawei.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, devicetree@vger.kernel.org, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Ray Jui <rjui@broadcom.com>, Beniamino Galvani <b.galvani@gmail.com>, Rob
List-Id: linux-i2c@vger.kernel.org


This series adds two I2C controller drivers.
(they are completely different IPs.)

The first one is a very simple FIFO-less I2C controller,
which is used on some older UniPhier SoCs.

The other one is higher-performance I2C controller with TX/RX FIFO,
used on newer UniPhier SoCs.



Masahiro Yamada (3):
  i2c: uniphier: add UniPhier FIFO-less I2C driver
  i2c: uniphier_f: add UniPhier FIFO-builtin I2C driver
  i2c: uniphier: add bindings for UniPhier I2C controllers

 .../devicetree/bindings/i2c/i2c-uniphier.txt       |  46 ++
 drivers/i2c/busses/Kconfig                         |  16 +
 drivers/i2c/busses/Makefile                        |   2 +
 drivers/i2c/busses/i2c-uniphier-f.c                | 589 +++++++++++++++++++++
 drivers/i2c/busses/i2c-uniphier.c                  | 446 ++++++++++++++++
 5 files changed, 1099 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
 create mode 100644 drivers/i2c/busses/i2c-uniphier-f.c
 create mode 100644 drivers/i2c/busses/i2c-uniphier.c

-- 
1.9.1
