From: wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 2/3] i2c-pnx: Add stop conditions for end of transfer
Date: Tue, 16 Mar 2010 15:55:37 -0700
Message-ID: <1268780138-10019-4-git-send-email-wellsk40@gmail.com>
References: <1268780138-10019-1-git-send-email-wellsk40@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1268780138-10019-1-git-send-email-wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: vitaly.wool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add a stop condition bit flag to the last byte in the transfer.
This will generate an extra clock to handle the stop condition
and prevent devices from staying in an ACK'd state.

Signed-off-by: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-pnx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 77919fa..6bb6ff7 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -172,6 +172,9 @@ static int i2c_pnx_master_xmit(struct i2c_pnx_algo_data *alg_data)
 		/* We still have something to talk about... */
 		val = *alg_data->mif.buf++;
 
+		if (alg_data->mif.len == 1)
+			val |= stop_bit;
+
 		alg_data->mif.len--;
 		iowrite32(val, I2C_REG_TX(alg_data));
 
@@ -245,6 +248,9 @@ static int i2c_pnx_master_rcv(struct i2c_pnx_algo_data *alg_data)
 			__func__);
 
 		if (alg_data->mif.len == 1) {
+			/* Last byte, do not acknowledge next rcv. */
+			val |= stop_bit;
+
 			/*
 			 * Enable interrupt RFDAIE (data in Rx fifo),
 			 * and disable DRMIE (need data for Tx)
-- 
1.6.6
