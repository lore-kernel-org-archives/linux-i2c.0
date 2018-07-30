From: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Subject: [PATCH v8 2/2] MAINTAINERS: Add Qualcomm Generic Interface I2C driver maintainer
Date: Mon, 30 Jul 2018 11:23:52 -0600
Message-ID: <1532971432-16784-3-git-send-email-kramasub@codeaurora.org>
References: <1532971432-16784-1-git-send-email-kramasub@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532971432-16784-1-git-send-email-kramasub@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org
List-Id: linux-i2c@vger.kernel.org

Add Alok Chauhan and myself as maintainers for Qualcomm GENI I2C master
controller driver.

Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32fbc6f..6e33b29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11830,6 +11830,14 @@ L:	netdev@vger.kernel.org
 S:	Maintained
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
