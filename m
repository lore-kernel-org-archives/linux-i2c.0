From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v11 7/8] i2c: octeon: Use booleon values for booleon variables
Date: Wed, 24 Aug 2016 23:25:48 +0200
Message-ID: <20160824212549.16140-8-jglauber@cavium.com>
References: <20160824212549.16140-1-jglauber@cavium.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824212549.16140-1-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Initialize booleon values with true instead of 1.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index a327a5f..f45ea5e 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
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
2.9.0.rc0.21.g7777322
