From: thor.thayer@linux.intel.com
Subject: [PATCHv3 2/4] MAINTAINERS: Add Altera I2C Controller Driver
Date: Fri,  2 Jun 2017 18:52:37 -0500
Message-ID: <1496447559-19782-3-git-send-email-thor.thayer@linux.intel.com>
References: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12689 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbdFBXuA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 2 Jun 2017 19:50:00 -0400
In-Reply-To: <1496447559-19782-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, dinguyen@kernel.org, thor.thayer@linux.intel.com
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add maintainer for the Altera I2C Controller Driver.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2&3  No change
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9609ca6..86053d6 100644
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
2.7.4
