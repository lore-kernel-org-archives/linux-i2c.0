From: Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2 0/4] Qualcomm Camera Control Interface driver
Date: Fri, 13 Oct 2017 13:56:39 +0300
Message-ID: <1507892203-17033-1-git-send-email-todor.tomov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
List-Id: linux-i2c@vger.kernel.org

This patchset adds basic support for the Qualcomm Camera Control Interface
(CCI) controller found on Qualcomm MSM8916/APQ8016 and MSM8996/APQ8996 SoC.

CCI has one I2C bus on MSM8916/APQ8016 and two I2C busses on MSM8996/APQ8096.
The present driver supports the first I2C bus only.

The driver is implemented using as a reference the Qualcomm CCI driver
for Android as found in Code Aurora [1] and [2].

The driver is tested on Dragonboard 410c (APQ8016) and Dragonboard 820c 
(APQ8096) with one and two OV5645 camera sensors.


[1] https://source.codeaurora.org/quic/la/kernel/msm-3.10/
[2] https://source.codeaurora.org/quic/la/kernel/msm-3.18/

--------------------------------------------------------------------------------

Changes in v2:
- use clock bulk API for clock handling;
- remove reg and interrupt names from dt binding as there are only one from
  each;
- improved checks in cci_validate_queue();
- halt and reset CCI on timeout after run queue;
- a fix for CCI reset after halt;
- a lot of small code and style fixes.

--------------------------------------------------------------------------------

Todor Tomov (4):
  dt-bindings: media: Binding document for Qualcomm Camera Control
    Interface driver
  i2c: Add Qualcomm Camera Control Interface driver
  MAINTAINERS: Add Qualcomm Camera Control Interface driver
  arm64: dts: qcom: Add Camera Control Interface support

 .../devicetree/bindings/i2c/i2c-qcom-cci.txt       |  46 ++
 MAINTAINERS                                        |   7 +
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi         |  14 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  19 +
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi         |  14 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  22 +
 drivers/i2c/busses/Kconfig                         |  10 +
 drivers/i2c/busses/Makefile                        |   1 +
 drivers/i2c/busses/i2c-qcom-cci.c                  | 789 +++++++++++++++++++++
 9 files changed, 922 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
 create mode 100644 drivers/i2c/busses/i2c-qcom-cci.c

-- 
2.7.4
