From: Boris BREZILLON <boris.brezillon@free-electrons.com>
Subject: [RESEND2 PATCH v4 0/2] i2c: sunxi: add P2WI controller support
Date: Tue,  3 Jun 2014 10:49:50 +0200
Message-ID: <1401785392-26602-1-git-send-email-boris.brezillon@free-electrons.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Hans de Goede <hdegoede@redhat.com>, Shuge <shuge@allwinnertech.com>, kevin@allwinnertech.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Boris BREZILLON <boris.brezillon@free-electrons.com>
List-Id: linux-i2c@vger.kernel.org

Hello,

Sorry for the noise, I forgot to add the linux-i2c ML in Cc.

This series adds support for the P2WI block used by some Allwinner boards
to interface with the AXP221 PMIC.

Best Regards,

Boris

Changes since v3:
- update the DT bindings doc
- fix a comment that was no longer true

Changes since v2:
- drop the initialization (switch from I2C to P2WI mode) part
- print devm_ioremap_resource err code

Changes since v1:
- implement P2WI initilization
- implement P2WI bus frequency configuration
- implement address consistency check
- fix devm_request_and_ioremap return check
- rework the macro definitions
- fix typos

[1] http://www.spinics.net/lists/linux-i2c/msg15066.html
[2] http://comments.gmane.org/gmane.comp.hardware.netbook.arm.sunxi/8947
Boris BREZILLON (2):
  i2c: sunxi: add P2WI DT bindings documentation
  i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support

 .../devicetree/bindings/i2c/i2c-sunxi-p2wi.txt     |  41 +++
 drivers/i2c/busses/Kconfig                         |  12 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-sun6i-p2wi.c                | 349 +++++++++++++++++++++
 4 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sunxi-p2wi.txt
 create mode 100644 drivers/i2c/busses/i2c-sun6i-p2wi.c

-- 
1.8.3.2

