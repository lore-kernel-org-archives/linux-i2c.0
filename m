From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [V1, 2/2] dt-bindings: i2c: Update i2c-brcmstb compatible string
Date: Wed, 16 Dec 2015 15:49:10 -0500
Message-ID: <1450298950-5229-2-git-send-email-kdasu.kdev@gmail.com>
References: <1450298950-5229-1-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:58142 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbbLPUta (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 16 Dec 2015 15:49:30 -0500
In-Reply-To: <1450298950-5229-1-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org, wsa@the-dreams.de
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, Kamal Dasu <kdasu.kdev@gmail.com>

Adding compatibility with the DSL and CM SoCs that use
the "Peripheral" i2c hardware. "brcm,brcmper-i2c" is
also an allowed string.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt b/Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt
index d6f724e..aeceace 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-brcmstb.txt
@@ -2,7 +2,7 @@ Broadcom stb bsc iic master controller
 
 Required properties:
 
-- compatible: should be "brcm,brcmstb-i2c"
+- compatible: should be "brcm,brcmstb-i2c" or "brcm,brcmper-i2c"
 - clock-frequency: 32-bit decimal value of iic master clock freqency in Hz
 		   valid values are 375000, 390000, 187500, 200000
 		   93750, 97500, 46875 and 50000
-- 
2.3.2
