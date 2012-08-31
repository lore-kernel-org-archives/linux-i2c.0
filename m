From: <ludovic.desroches@atmel.com>
Subject: [PATCH 0/8] i2c: at91: cleanup and dt support
Date: Fri, 31 Aug 2012 11:21:16 +0200
Message-ID: <1346404884-18451-1-git-send-email-ludovic.desroches@atmel.com>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: plagnioj@jcrosoft.com, n.voss@weinmann.de, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-i2c@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

This set of patches is based on Nikolaus at91_i2c driver.

Ludovic Desroches (8):
  i2c: at91: use managed resources
  i2c: at91: add warning about transmission issues for some devices
  i2c: at91: use an id table for SoC dependent parameters
  ARM: at91: do not configure at91sam9g10 twi pio as open-drain
  i2c: at91: add dt support to i2c-at91
  ARM: at91: add clocks for I2C DT entries
  ARM: dts: add twi nodes for atmel SOCs
  ARM: dts: add twi nodes for atmel boards

 .../devicetree/bindings/i2c/atmel-i2c.txt          |  30 +++
 arch/arm/boot/dts/at91sam9260.dtsi                 |  23 +--
 arch/arm/boot/dts/at91sam9263.dtsi                 |  23 +--
 arch/arm/boot/dts/at91sam9263ek.dts                |  20 +-
 arch/arm/boot/dts/at91sam9g20.dtsi                 |   4 +
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |  28 +--
 arch/arm/boot/dts/at91sam9g25ek.dts                |  12 ++
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  33 ++--
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |   8 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  33 ++--
 arch/arm/boot/dts/at91sam9n12ek.dts                |   8 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  69 +++----
 arch/arm/mach-at91/at91rm9200.c                    |   2 +-
 arch/arm/mach-at91/at91rm9200_devices.c            |  11 +-
 arch/arm/mach-at91/at91sam9260.c                   |   4 +-
 arch/arm/mach-at91/at91sam9260_devices.c           |   8 +-
 arch/arm/mach-at91/at91sam9261.c                   |   3 +-
 arch/arm/mach-at91/at91sam9261_devices.c           |  31 ++-
 arch/arm/mach-at91/at91sam9263.c                   |   3 +-
 arch/arm/mach-at91/at91sam9263_devices.c           |   2 +-
 arch/arm/mach-at91/at91sam9g45.c                   |   6 +-
 arch/arm/mach-at91/at91sam9g45_devices.c           |   4 +-
 arch/arm/mach-at91/at91sam9n12.c                   |   2 +
 arch/arm/mach-at91/at91sam9rl.c                    |   4 +-
 arch/arm/mach-at91/at91sam9rl_devices.c            |   2 +-
 arch/arm/mach-at91/at91sam9x5.c                    |   6 +-
 drivers/i2c/busses/Kconfig                         |   6 +
 drivers/i2c/busses/i2c-at91.c                      | 217 +++++++++++++--------
 28 files changed, 367 insertions(+), 235 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/atmel-i2c.txt

-- 
1.7.11.3
