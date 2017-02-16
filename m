From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 1/3] i2c: bcm2835: Avoid possible NULL ptr dereference
Date: Thu, 16 Feb 2017 21:20:45 +0000
Message-ID: <1487280047-29608-2-git-send-email-stefan.wahren@i2se.com>
References: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51957 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbdBPVVp (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 16 Feb 2017 16:21:45 -0500
In-Reply-To: <1487280047-29608-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Wolfram Sang <wsa@the-dreams.de>, Peter Robinson <pbrobinson@gmail.com>
Cc: Martin Sperl <kernel@martin.sperl.org>, =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>

Since commit e2474541032d ("bcm2835: Fix hang for writing messages
larger than 16 bytes") the interrupt handler is prone to a possible
NULL pointer dereference. This could happen if an interrupt fires
before curr_msg is set by bcm2835_i2c_xfer_msg() and randomly occurs
on the RPi 3. Even this is an unexpected behavior the driver must
handle that with an error instead of a crash.

CC: Noralf Trønnes <noralf@tronnes.org>
CC: Martin Sperl <kernel@martin.sperl.org>
Reported-by: Peter Robinson <pbrobinson@gmail.com>
Fixes: e2474541032d ("bcm2835: Fix hang for writing messages larger than 16 bytes")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/i2c/busses/i2c-bcm2835.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index c3436f6..10e39c8 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -195,7 +195,9 @@ static irqreturn_t bcm2835_i2c_isr(int this_irq, void *data)
 	}
 
 	if (val & BCM2835_I2C_S_DONE) {
-		if (i2c_dev->curr_msg->flags & I2C_M_RD) {
+		if (!i2c_dev->curr_msg) {
+			dev_err(i2c_dev->dev, "Got unexpected interrupt (from firmware?)\n");
+		} else if (i2c_dev->curr_msg->flags & I2C_M_RD) {
 			bcm2835_drain_rxfifo(i2c_dev);
 			val = bcm2835_i2c_readl(i2c_dev, BCM2835_I2C_S);
 		}
-- 
1.7.9.5
