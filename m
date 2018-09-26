From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] i2c-omap: Enable i2c-omap driver for AM654 SoCs
Date: Wed, 26 Sep 2018 17:27:49 +0530
Message-ID: <20180926115751.20421-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Vignesh R <vigneshr@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Couple of patches to enable i2c-omap driver to be used with TI's new
AM654 platforms.

Vignesh R (2):
  dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
  i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3

 Documentation/devicetree/bindings/i2c/i2c-omap.txt | 1 +
 drivers/i2c/busses/Kconfig                         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.0
