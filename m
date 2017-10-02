From: Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH 3/4] MAINTAINERS: Add Qualcomm Camera Control Interface driver
Date: Mon,  2 Oct 2017 17:13:32 +0300
Message-ID: <1506953613-23875-4-git-send-email-todor.tomov@linaro.org>
References: <1506953613-23875-1-git-send-email-todor.tomov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506953613-23875-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
List-Id: linux-i2c@vger.kernel.org

Add an entry for Qualcomm Camera Control Interface driver.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6671f37..aa3484f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11158,6 +11158,13 @@ W:	http://wireless.kernel.org/en/users/Drivers/ath9k
 S:	Supported
 F:	drivers/net/wireless/ath/ath9k/
 
+QUALCOMM CAMERA CONTROL INTERFACE DRIVER
+M:	Todor Tomov <todor.tomov@linaro.org>
+L:	linux-i2c@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i2c/i2c-qcom-cci.txt
+F:	drivers/i2c/busses/i2c-qcom-cci.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Todor Tomov <todor.tomov@linaro.org>
 L:	linux-media@vger.kernel.org
-- 
2.7.4
