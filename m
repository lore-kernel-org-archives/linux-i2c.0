From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v8 7/8] i2c: cavium: Use booleon values for booleon variables
Date: Mon,  2 May 2016 19:35:47 +0200
Message-ID: <1462210548-4648-8-git-send-email-jglauber@cavium.com>
References: <1462210548-4648-1-git-send-email-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462210548-4648-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Initialize booleon values with true instead of 1.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-cavium.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cavium.c b/drivers/i2c/busses/i2c-cavium.c
index e95ee5c..140f0d1 100644
--- a/drivers/i2c/busses/i2c-cavium.c
+++ b/drivers/i2c/busses/i2c-cavium.c
@@ -63,7 +63,7 @@ static bool octeon_i2c_test_ready(struct octeon_i2c *i2c, bool *first)
 static int octeon_i2c_wait(struct octeon_i2c *i2c)
 {
 	long time_left;
-	bool first = 1;
+	bool first = true;
 
 	/*
 	 * Some chip revisions don't assert the irq in the interrupt
@@ -176,7 +176,7 @@ static void octeon_i2c_hlc_disable(struct octeon_i2c *i2c)
  */
 static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 {
-	bool first = 1;
+	bool first = true;
 	int time_left;
 
 	/*
-- 
1.9.1
