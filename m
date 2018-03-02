From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 0/2] add support for Socionext SynQuacer I2C controller
Date: Fri,  2 Mar 2018 08:31:21 +0000
Message-ID: <20180302083123.7259-1-ard.biesheuvel@linaro.org>
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
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: andy.shevchenko@gmail.com, jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Add a binding and a driver for the I2C IP found in the Socionext SynQuacer
SoC, which is essentially a rebranded version of the Fujitsu F_I2C controller.

I think this is good to go now. Wolfram?

v5:
- add Rob's ack to #1
- drop unnecessary 'platform_set_drvdata(pdev, NULL)' in remove path (#2)

v4:
- clarify binding that only a single interrupt specifier is expected (#1)
- check return value of clk_prepare_enable() on probe path (#2)
- add Andy's R-b to patch #2

v3:
- incorporate more of Andy's review comments (#2), especially regarding the
  bus speed and clock source handling for ACPI
- patch #1 unchanged.

v2:
- incorporate Andy's review comments (#2)
- patch #1 unchanged.

Ard Biesheuvel (2):
  dt-bindings: i2c: add binding for Socionext SynQuacer I2C
  i2c: add support for Socionext SynQuacer I2C controller

 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt |  29 +
 drivers/i2c/busses/Kconfig                              |  10 +
 drivers/i2c/busses/Makefile                             |   1 +
 drivers/i2c/busses/i2c-synquacer.c                      | 791 ++++++++++++++++++++
 4 files changed, 831 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
 create mode 100644 drivers/i2c/busses/i2c-synquacer.c

-- 
2.11.0
