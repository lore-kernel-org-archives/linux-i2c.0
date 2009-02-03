From: Mark Lord <lkml-gsilrlXbHYg@public.gmane.org>
Subject: [PATCH] ir-kbd-i2c: support Hauppauge HVR-1600 R/C port
Date: Mon, 02 Feb 2009 22:26:29 -0500
Message-ID: <4987B965.6020609@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Update the ir-kbd-i2c driver to recognize the remote-control port
on the Hauppauge HV-1600 hybrid tuner card.

Signed-off-by: Mark Lord <mlord-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>

--- old/drivers/media/video/ir-kbd-i2c.c	2008-12-24 18:26:37.000000000 -0500
+++ linux/drivers/media/video/ir-kbd-i2c.c	2009-02-01 13:08:19.000000000 -0500
@@ -354,6 +354,11 @@
 			} else {
 				ir_codes    = ir_codes_rc5_tv;
 			}
+		} else if (adap->id == I2C_HW_B_CX2341X) {
+			name        = "Hauppauge";
+			ir_type     = IR_TYPE_RC5;
+			ir->get_key = get_key_haup_xvr;
+			ir_codes    = ir_codes_hauppauge_new;
 		} else {
 			/* Handled by saa7134-input */
 			name        = "SAA713x remote";
@@ -449,7 +454,7 @@
 	   That's why we probe 0x1a (~0x34) first. CB
 	*/
 
-	static const int probe_bttv[] = { 0x1a, 0x18, 0x4b, 0x64, 0x30, -1};
+	static const int probe_bttv[] = { 0x1a, 0x18, 0x4b, 0x64, 0x30, 0x71, -1};
 	static const int probe_saa7134[] = { 0x7a, 0x47, 0x71, 0x2d, -1 };
 	static const int probe_em28XX[] = { 0x30, 0x47, -1 };
 	static const int probe_cx88[] = { 0x18, 0x6b, 0x71, -1 };
