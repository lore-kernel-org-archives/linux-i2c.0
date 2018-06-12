From: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Subject: [PATCH v7 0/4] Introduce GENI SE Controller Driver
Date: Tue, 12 Jun 2018 11:09:04 -0600
Message-ID: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org
List-Id: linux-i2c@vger.kernel.org

Generic Interface (GENI) firmware based Qualcomm Universal Peripheral (QUP)
Wrapper is a next generation programmable module for supporting a wide
range of serial interfaces like UART, SPI, I2C, I3C, etc. A single QUP
module can provide upto 8 Serial Interfaces using its internal Serial
Engines (SE). The protocol supported by each interface is determined by
the firmware loaded to the Serial Engine.

This patch series introduces GENI SE Driver to manage the GENI based QUP
Wrapper and the common aspects of all SEs inside the QUP Wrapper. This
patch series also introduces the UART and I2C Controller drivers to
drive the SEs that are programmed with the respective protocols.

[v7]
 * Return appropriate error codes as idenitified in i2c fault-codes
 * Add Maintainer details for I2C controller driver
 * Fix an incorrect conditional check in DMA mode
 * Drop the patches in the series that got accepted

[v6]
 * Move the I2C clock-frequency configuration to the SDM845 board file
 * Remove a redundant comment in the I2C driver

[v5]
 * Remove Linux specific property from the device tree binding
 * Clarify I2C SCL time period documentation
 * Remove redundant checks in I2C controller driver during timeout
 * Use 100kHz as the default clock frequency in the I2C controller driver
 * Disable Wrapper controller by default in the SDM845 device tree and
   enable it explicitly for SDM845 MTP
 * Specify I2C clock frequency in the SDM845 device tree
 * Remove bias configuration for I2C pins under sleep state in device tree
 * Drop the serial driver from the patch series since it is merged
 * Specify the UART port options in the SDM845 device tree

[v4]
 * Add SPI controller information in device tree binding
 * Add support for debug UART & I2C controllers in SDM845 device tree
 * Remove any unnecessary parenthesis & casting
 * Identify break character in UART line and pass it to the framework
 * Transmit data from fault handler reliably in debug UART
 * Map the register block when the UART port is requested
 * Move concise exported functions as macros or inlines in public header
 * Move the clock performance table from the wrapper to serial engines
 * Add a lock to synchronize between IRQ & error handling in I2C controller
 * Remove any compiler optimization hints like likely/unlikely
 * Update documentation to clarify tables and hardware blocks

[v3]
 * Update the driver dependencies
 * Use the SPDX License Expression
 * Squash all the controller device tree bindings together
 * Use kernel doc format for documentation
 * Add additional documentation for packing configuration
 * Use clk_bulk_* API for related clocks
 * Remove driver references to pinctrl and their states
 * Replace magic numbers with appropriate macros
 * Update memory barrier usage and associated comments
 * Reduce interlacing of register reads/writes
 * Fix poll_get_char() operation in console UART driver under polling mode
 * Address other comments from Bjorn Andersson to improve code readability

[v2]
 * Updated device tree bindings to describe the hardware
 * Updated SE DT node as child node of QUP Wrapper DT node
 * Moved common AHB clocks to QUP Wrapper DT node
 * Use the standard "clock-frequency" I2C property
 * Update compatible field in UART Controller to reflect hardware manual
 * Addressed other device tree binding specific comments from Rob Herring

Karthikeyan Ramasubramanian (3):
  i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C
    controller
  MAINTAINERS: Add Qualcomm Generic Interface I2C driver maintainer
  arm64: dts: sdm845: Add support for an instance of I2C controller

Rajendra Nayak (1):
  arm64: dts: sdm845: Add serial console support

 MAINTAINERS                             |   8 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  60 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi    |  67 ++++
 drivers/i2c/busses/Kconfig              |  13 +
 drivers/i2c/busses/Makefile             |   1 +
 drivers/i2c/busses/i2c-qcom-geni.c      | 649 ++++++++++++++++++++++++++++++++
 6 files changed, 798 insertions(+)
 create mode 100644 drivers/i2c/busses/i2c-qcom-geni.c

-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
