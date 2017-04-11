From: thor.thayer@linux.intel.com
Subject: [PATCH 1/3] MAINTAINERS: Add Altera I2C Controller Driver
Date: Tue, 11 Apr 2017 11:02:25 -0500
Message-ID: <1491926547-29510-2-git-send-email-thor.thayer@linux.intel.com>
References: <1491926547-29510-1-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:3079 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752781AbdDKP7k (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 11 Apr 2017 11:59:40 -0400
In-Reply-To: <1491926547-29510-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh@kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>

From: Thor Thayer <thor.thayer@linux.intel.com>

Add maintainer for the Altera I2C Controller Driver.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bfaea4..e654d34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -636,6 +636,11 @@ ALPS PS/2 TOUCHPAD DRIVER
 R:	Pali Rohár <pali.rohar@gmail.com>
 F:	drivers/input/mouse/alps.*
 
+ALTERA I2C CONTROLLER DRIVER
+M:	Thor Thayer <thor.thayer@linux.intel.com>
+S:	Maintained
+F:	drivers/i2c/busses/i2c-altera.c
+
 ALTERA MAILBOX DRIVER
 M:	Ley Foon Tan <lftan@altera.com>
 L:	nios2-dev@lists.rocketboards.org (moderated for non-subscribers)
-- 
1.9.1
