From: "Jayachandran C" <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH] i2c: ocores: Fix pointer to integer cast warning
Date: Tue, 19 Feb 2013 13:03:19 +0530
Message-ID: <1361259199-24709-1-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

After commit a000b8c1 [i2c: ocores: Add support for the GRLIB port of the
controller and use function pointers for getreg and setreg function],
compiling i2c-ocores.c for 64-bit gives the following warning:

  drivers/i2c/busses/i2c-ocores.c: In function 'ocores_i2c_of_probe':
  drivers/i2c/busses/i2c-ocores.c:334:15: warning: cast from pointer to integer of different size

Fix it by casting the pointer to long.

Signed-off-by: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
---
 drivers/i2c/busses/i2c-ocores.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index a873d0a..6afa02d 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -331,7 +331,7 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 				&i2c->reg_io_width);
 
 	match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
-	if (match && (int)match->data == TYPE_GRLIB) {
+	if (match && (long)match->data == TYPE_GRLIB) {
 		dev_dbg(&pdev->dev, "GRLIB variant of i2c-ocores\n");
 		i2c->setreg = oc_setreg_grlib;
 		i2c->getreg = oc_getreg_grlib;
-- 
1.7.9.5
