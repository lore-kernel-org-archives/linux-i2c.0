From: Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2 3/4] MAINTAINERS: Add Qualcomm Camera Control Interface driver
Date: Fri, 13 Oct 2017 13:56:42 +0300
Message-ID: <1507892203-17033-4-git-send-email-todor.tomov@linaro.org>
References: <1507892203-17033-1-git-send-email-todor.tomov@linaro.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ns.mm-sol.com ([37.157.136.199]:37942 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751607AbdJMK5s (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 13 Oct 2017 06:57:48 -0400
In-Reply-To: <1507892203-17033-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, linux-i2c@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>

Add an entry for Qualcomm Camera Control Interface driver.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3d750..10d78cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11171,6 +11171,13 @@ W:	http://wireless.kernel.org/en/users/Drivers/ath9k
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
