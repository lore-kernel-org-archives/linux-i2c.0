From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Subject: [PATCH 5/7] i2c-eg20t: add stop sequence in case wait-event timeout occurs
Date: Wed, 21 Sep 2011 16:51:47 +0900
Message-ID: <1316591509-4433-5-git-send-email-tomoya-linux@dsn.okisemi.com>
References: <1316591509-4433-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1316591509-4433-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Qi Wang <qi.wang@intel.com>, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, toshiharu-linux@dsn.okisemi.com, Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
List-Id: linux-i2c@vger.kernel.org

add stop sequence in case wait-event timeout in write processing.
(read processing already had it)

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
---
 drivers/i2c/busses/i2c-eg20t.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index b6d910d..ab93d73 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -432,6 +432,7 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 		pch_clrbit(adap->pch_base_address, PCH_I2CSR, I2CMIF_BIT);
 		return -EAGAIN;
 	} else { /* wait-event timeout */
+		pch_i2c_stop(adap);
 		return -ETIME;
 	}
 
@@ -452,6 +453,7 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
 				   I2CMIF_BIT);
 		} else { /* wait-event timeout */
+			pch_i2c_stop(adap);
 			return -ETIME;
 		}
 	}
-- 
1.7.4.4
