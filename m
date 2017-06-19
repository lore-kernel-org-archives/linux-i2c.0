From: thor.thayer@linux.intel.com
Subject: [PATCHv4 1/3] MAINTAINERS: Add Altera I2C Controller Driver
Date: Mon, 19 Jun 2017 15:36:56 -0500
Message-ID: <1497904618-27010-2-git-send-email-thor.thayer@linux.intel.com>
References: <1497904618-27010-1-git-send-email-thor.thayer@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497904618-27010-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, thor.thayer@linux.intel.com
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add maintainer for the Altera I2C Controller Driver.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2-4  No change
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ced1383..c00af95 100644
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
