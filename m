From: Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v4 0/8] iProc I2C slave mode and NIC mode
Date: Mon,  4 Feb 2019 15:15:46 -0800
Message-ID: <20190204231554.87666-1-ray.jui@broadcom.com>
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
To: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-i2c@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

This patch series adds the following support to the iProc I2C driver:
- Increase maximum read transfer size to 255 bytes
- I2C slave mode
- Polling mode
- NIC I2C mode

This patch series is based on kernel v5.0-rc3 and available at:
https://github.com/Broadcom/arm64-linux.git
branch: i2c-slave-v4

Changes from v3:
 - Various minor fixes on commit messages and commits
 - Rebased to v5.0-rc3

Changes from v2:
 - Address Ray's review comments.

Changes from v1:
 - Rebased to Linux v5.0.0-rc2

Ray Jui (1):
  dt-bindings: i2c: iproc: make 'interrupts' optional

Rayagonda Kokatanur (5):
  i2c: iproc: add polling support
  i2c: iproc: use wrapper for read/write access
  dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
  i2c: iproc: add NIC I2C support
  arm64: dts: Stingray: Add NIC i2c device node

Shreesha Rajashekar (2):
  i2c: iproc: Extend I2C read up to 255 bytes
  i2c: iproc: Add slave mode support

 .../bindings/i2c/brcm,iproc-i2c.txt           |  15 +-
 .../boot/dts/broadcom/stingray/stingray.dtsi  |  18 +
 drivers/i2c/busses/Kconfig                    |   1 +
 drivers/i2c/busses/i2c-bcm-iproc.c            | 758 +++++++++++++++---
 4 files changed, 661 insertions(+), 131 deletions(-)

-- 
2.17.1
