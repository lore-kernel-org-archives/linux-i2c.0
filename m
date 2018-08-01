From: Mike Shettel <mshettel@codeaurora.org>
Subject: [PATCH v1 0/3] Add a driver for Qualcomm GENI I3C master IP
Date: Tue, 31 Jul 2018 23:38:59 -0600
Message-ID: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, boris.brezillon@bootlin.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: Mike Shettel <mshettel@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, bjorn.andersson@linaro.org
List-Id: linux-i2c@vger.kernel.org

This patch series is a proposal for the I3C master driver for the
Qualcomm GENI IP. This patch is to be applied on top of the I3C
subsystem patchset v6 submitted by Boris Brezillon.

Features supported:
  Regular CCC commands
  I3C private transfers
  I2C transfers

Features not yet supported:
  Hot-join
  IBI


Mike Shettel (3):
  i3c: master: Add a driver for Qualcomm GENI I3C master IP
  dt-bindings: i3c: Document Qualcomm GENI I3C master bindings
  MAINTAINERS: Add Qualcomm Generic Interface I3C driver maintainer

 .../devicetree/bindings/i3c/qcom,geni-i3c.txt      |   44 +
 MAINTAINERS                                        |    8 +
 drivers/i3c/master/Kconfig                         |   13 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/i3c-master-qcom-geni.c          | 1243 ++++++++++++++++++++
 5 files changed, 1309 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/qcom,geni-i3c.txt
 create mode 100644 drivers/i3c/master/i3c-master-qcom-geni.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
