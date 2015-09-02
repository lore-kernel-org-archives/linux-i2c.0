From: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH] drivers/i2c/muxes/i2c-mux-reg: Change ioread endianness for readback
Date: Wed, 2 Sep 2015 11:40:46 -0500
Message-ID: <1441212046-2976-1-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Reading the register (if allowed) after writing is to ensure writing
is completed on a posted bus. The endianness of reading doesn't matter.

Signed-off-by: York Sun <yorksun-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-reg.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mux-reg.c
index 86d41d36..7f2a1ae 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -31,28 +31,28 @@ static int i2c_mux_reg_set(const struct regmux *mux, unsigned int chan_id)
 	if (!mux->data.reg)
 		return -EINVAL;
 
+	/*
+	 * Write to the register, followed by a read to ensure the write is
+	 * completed on a "posted" bus, for example PCI or write buffers.
+	 * The endianness of reading doesn't matter and the return data
+	 * is not used.
+	 */
 	switch (mux->data.reg_size) {
 	case 4:
-		if (mux->data.little_endian) {
+		if (mux->data.little_endian)
 			iowrite32(chan_id, mux->data.reg);
-			if (!mux->data.write_only)
-				ioread32(mux->data.reg);
-		} else {
+		else
 			iowrite32be(chan_id, mux->data.reg);
-			if (!mux->data.write_only)
-				ioread32(mux->data.reg);
-		}
+		if (!mux->data.write_only)
+			ioread32(mux->data.reg);
 		break;
 	case 2:
-		if (mux->data.little_endian) {
+		if (mux->data.little_endian)
 			iowrite16(chan_id, mux->data.reg);
-			if (!mux->data.write_only)
-				ioread16(mux->data.reg);
-		} else {
+		else
 			iowrite16be(chan_id, mux->data.reg);
-			if (!mux->data.write_only)
-				ioread16be(mux->data.reg);
-		}
+		if (!mux->data.write_only)
+			ioread16(mux->data.reg);
 		break;
 	case 1:
 		iowrite8(chan_id, mux->data.reg);
-- 
1.7.9.5
