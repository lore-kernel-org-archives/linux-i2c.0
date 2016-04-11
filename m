From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v6 05/19] i2c: octeon: Remove superfluous check in octeon_i2c_test_iflg
Date: Mon, 11 Apr 2016 17:28:36 +0200
Message-ID: <7b7b1facacacc94eb5b668a2e87811aa96f9a08c.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
In-Reply-To: <cover.1460387640.git.jglauber@cavium.com>
References: <cover.1460387640.git.jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Remove superfluous check and stray newline.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-octeon.c
index b25c491..4275007 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -198,10 +198,9 @@ static irqreturn_t octeon_i2c_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-
 static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
 {
-	return (octeon_i2c_ctl_read(i2c) & TWSI_CTL_IFLG) != 0;
+	return (octeon_i2c_ctl_read(i2c) & TWSI_CTL_IFLG);
 }
 
 /**
-- 
1.9.1
