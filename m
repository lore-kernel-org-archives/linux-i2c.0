From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/6] i2c: sh_mobile: replace magic hex values with constants
Date: Thu,  1 May 2014 00:21:05 +0200
Message-ID: <1398896470-24663-2-git-send-email-wsa@the-dreams.de>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

No functional change, binaries are identical.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 1d79585ba4b3..d91625eea6bb 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -316,7 +316,7 @@ static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 
 	switch (op) {
 	case OP_START: /* issue start and trigger DTE interrupt */
-		iic_wr(pd, ICCR, 0x94);
+		iic_wr(pd, ICCR, ICCR_ICE | ICCR_TRS | ICCR_BBSY);
 		break;
 	case OP_TX_FIRST: /* disable DTE interrupt and write data */
 		iic_wr(pd, ICIC, ICIC_WAITE | ICIC_ALE | ICIC_TACKE);
@@ -327,10 +327,11 @@ static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 		break;
 	case OP_TX_STOP: /* write data and issue a stop afterwards */
 		iic_wr(pd, ICDR, data);
-		iic_wr(pd, ICCR, pd->send_stop ? 0x90 : 0x94);
+		iic_wr(pd, ICCR, pd->send_stop ? ICCR_ICE | ICCR_TRS
+					       : ICCR_ICE | ICCR_TRS | ICCR_BBSY);
 		break;
 	case OP_TX_TO_RX: /* select read mode */
-		iic_wr(pd, ICCR, 0x81);
+		iic_wr(pd, ICCR, ICCR_ICE | ICCR_SCP);
 		break;
 	case OP_RX: /* just read data */
 		ret = iic_rd(pd, ICDR);
@@ -338,13 +339,13 @@ static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 	case OP_RX_STOP: /* enable DTE interrupt, issue stop */
 		iic_wr(pd, ICIC,
 		       ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE);
-		iic_wr(pd, ICCR, 0xc0);
+		iic_wr(pd, ICCR, ICCR_ICE | ICCR_RACK);
 		break;
 	case OP_RX_STOP_DATA: /* enable DTE interrupt, read data, issue stop */
 		iic_wr(pd, ICIC,
 		       ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE);
 		ret = iic_rd(pd, ICDR);
-		iic_wr(pd, ICCR, 0xc0);
+		iic_wr(pd, ICCR, ICCR_ICE | ICCR_RACK);
 		break;
 	}
 
-- 
1.9.2

