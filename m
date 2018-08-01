From: Mike Shettel <mshettel@codeaurora.org>
Subject: [PATCH v1 3/3] MAINTAINERS: Add Qualcomm Generic Interface I3C driver maintainer
Date: Tue, 31 Jul 2018 23:39:02 -0600
Message-ID: <1533101942-29442-4-git-send-email-mshettel@codeaurora.org>
References: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533101942-29442-1-git-send-email-mshettel@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, boris.brezillon@bootlin.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: Mike Shettel <mshettel@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, evgreen@chromium.org, acourbot@chromium.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, bjorn.andersson@linaro.org
List-Id: linux-i2c@vger.kernel.org

Signed-off-by: Mike Shettel <mshettel@codeaurora.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 622327b..775829c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10943,6 +10943,14 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/qualcomm/emac/
 
+QUALCOMM GENERIC INTERFACE I3C DRIVER
+M:	Alok Chauhan <alokc@codeaurora.org>
+M:	Mike Shettel <mshettel@codeaurora.org>
+L:	linux-i2c@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Supported
+F:	drivers/i3c/master/i3c-master-qcom-geni.c
+
 QUALCOMM HEXAGON ARCHITECTURE
 M:	Richard Kuo <rkuo@codeaurora.org>
 L:	linux-hexagon@vger.kernel.org
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
