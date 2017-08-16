From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v2 0/3] ARM: dts: keystone-k2g: Add I2C support for 66AK2G
Date: Wed, 16 Aug 2017 17:17:12 -0500
Message-ID: <20170816221715.15027-1-fcooper@ti.com>
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
To: wsa@the-dreams.de, robh+dt@kernel.org, linux@armlinux.org.uk, nsekhar@ti.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com, vigneshr@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-i2c@vger.kernel.org

Add I2C support to 66AK2G. Primary requirement is to add PM
Runtime support to the driver.

This has been tested on following platforms by performing simple i2c test
such as i2c detect and reading on board i2c devices:
K2G GP evm
OMAPL138
K2L GP EVM

and boot tested on:
K2E GP EVM
K2HK GP EVM

Version 2 changes:
Moved ordering of pm runtime calls

Franklin S Cooper Jr (3):
  i2c: davinci: Preserve return value of devm_clk_get
  i2c: davinci: Add PM Runtime Support
  dt-bindings: i2c: i2c-davinci: Update binding for 66AK2Gx pwr dm
    property

 .../devicetree/bindings/i2c/i2c-davinci.txt        | 12 ++++
 drivers/i2c/busses/i2c-davinci.c                   | 64 +++++++++++++++++++---
 2 files changed, 67 insertions(+), 9 deletions(-)

-- 
2.9.4.dirty
