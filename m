From: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Subject: [PATCH v7 2/4] MAINTAINERS: Add Qualcomm Generic Interface I2C driver maintainer
Date: Tue, 12 Jun 2018 11:09:06 -0600
Message-ID: <1528823348-30532-3-git-send-email-kramasub@codeaurora.org>
References: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528823348-30532-1-git-send-email-kramasub@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org
List-Id: linux-i2c@vger.kernel.org

Add Alok Chauhan and myself as maintainers for Qualcomm GENI I2C master
controller driver.

Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 868be4a..08a6b6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11814,6 +11814,14 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/qualcomm/emac/
 
+QUALCOMM GENERIC INTERFACE I2C DRIVER
+M:	Alok Chauhan <alokc@codeaurora.org>
+M:	Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
+L:	linux-i2c@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Supported
+F:	drivers/i2c/busses/i2c-qcom-geni.c
+
 QUALCOMM HEXAGON ARCHITECTURE
 M:	Richard Kuo <rkuo@codeaurora.org>
 L:	linux-hexagon@vger.kernel.org
-- 
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
