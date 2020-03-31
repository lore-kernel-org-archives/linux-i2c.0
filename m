From: Akash Asthana <akashast@codeaurora.org>
Subject: [PATCH V3 0/8] Add interconnect support to QSPI and QUP drivers
Date: Tue, 31 Mar 2020 16:39:28 +0530
Message-ID: <1585652976-17481-1-git-send-email-akashast@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, agross@kernel.org, bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, georgi.djakov@linaro.org
Cc: linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, swboyd@chromium.org, mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, mka@chromium.org, dianders@chromium.org, evgreen@chromium.org, Akash Asthana <akashast@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org

dt-binding patch for QUP drivers.
 - https://patchwork.kernel.org/patch/11436621/ [Convert QUP bindings
        to YAML and add ICC, pin swap doc]

dt-binding patch for QSPI.
 - https://patchwork.kernel.org/patch/11436719/ [Convert QSPI binding
        to YAML and add interconnect doc]

High level design:
 - QUP wrapper/common driver.
   Vote for QUP core on behalf of earlycon from probe.
   Remove BW vote during earlycon exit call

 - SERIAL driver.
   Vote only for CPU/CORE path because driver is in FIFO mode only
   Vote/unvote from qcom_geni_serial_pm func.
   Bump up the CPU vote from set_termios call based on real time need

 - I2C driver.
   Vote for CORE/CPU/DDR path
   Vote/unvote from runtime resume/suspend callback
   As bus speed for I2C is fixed from probe itself no need for bump up.

 - SPI QUP driver.
   Vote only for CPU/CORE path because driver is in FIFO mode only
   Vote/unvote from runtime resume/suspend callback
   Bump up CPU vote based on real time need per transfer.

 - QSPI driver.
   Vote only for CPU path
   Vote/unvote from runtime resume/suspend callback
   Bump up CPU vote based on real time need per transfer.

Changes in V2:
 - Add devm_of_icc_get() API interconnect core.
 - Add ICC support to common driver to fix earlyconsole crash.

Changes in V3:
 - Define common ICC APIs in geni-se driver and use it across geni based
   I2C,SPI and UART driver.

Akash Asthana (8):
  interconnect: Add devm_of_icc_get() as exported API for users
  soc: qcom: geni: Support for ICC voting
  soc: qcom-geni-se: Add interconnect support to fix earlycon crash
  i2c: i2c-qcom-geni: Add interconnect support
  spi: spi-geni-qcom: Add interconnect support
  tty: serial: qcom_geni_serial: Add interconnect support
  spi: spi-qcom-qspi: Add interconnect support
  arm64: dts: sc7180: Add interconnect for QUP and QSPI

 arch/arm64/boot/dts/qcom/sc7180.dtsi  | 127 +++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-qcom-geni.c    |  30 ++++++-
 drivers/interconnect/core.c           |  25 ++++++
 drivers/soc/qcom/qcom-geni-se.c       | 149 ++++++++++++++++++++++++++++++++++
 drivers/spi/spi-geni-qcom.c           |  31 ++++++-
 drivers/spi/spi-qcom-qspi.c           |  46 ++++++++++-
 drivers/tty/serial/qcom_geni_serial.c |  35 +++++++-
 include/linux/interconnect.h          |   7 ++
 include/linux/qcom-geni-se.h          |  38 +++++++++
 9 files changed, 482 insertions(+), 6 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project
