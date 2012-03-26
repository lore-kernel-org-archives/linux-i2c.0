From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: [PATCH 2/3] i2c-eg20t: Call init() when wait-event timeout occurs
Date: Mon, 26 Mar 2012 14:55:24 +0900
Message-ID: <1332741325-7746-2-git-send-email-tomoya.rohm@gmail.com>
References: <1332741325-7746-1-git-send-email-tomoya.rohm@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1332741325-7746-1-git-send-email-tomoya.rohm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Feng Tang <feng.tang@intel.com>, Alexander Stein <alexander.stein@systec-electronic.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, Tomoya MORINAGA <tomoya.rohm@gmail.com>
List-Id: linux-i2c@vger.kernel.org


Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>
---
 drivers/i2c/busses/i2c-eg20t.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index d73975b..714b070 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -445,7 +445,9 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 			pch_i2c_init(adap);
 			return -EAGAIN;
 		} else { /* wait-event timeout */
+			pch_err(adap, "%s(L.%d):wait-event timeout\n", __func__, __LINE__);
 			pch_i2c_stop(adap);
+			pch_i2c_init(adap);
 			return -ETIME;
 		}
 	} else {
@@ -469,7 +471,9 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 		pch_i2c_init(adap);
 		return -EAGAIN;
 	} else { /* wait-event timeout */
+		pch_err(adap, "%s(L.%d):wait-event timeout\n", __func__, __LINE__);
 		pch_i2c_stop(adap);
+		pch_i2c_init(adap);
 		return -ETIME;
 	}
 
@@ -490,7 +494,9 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
 				   I2CMIF_BIT);
 		} else { /* wait-event timeout */
+			pch_err(adap, "%s(L.%d):wait-event timeout\n", __func__, __LINE__);
 			pch_i2c_stop(adap);
+			pch_i2c_init(adap);
 			return -ETIME;
 		}
 	}
@@ -598,7 +604,9 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 			pch_i2c_init(adap);
 			return -EAGAIN;
 		} else { /* wait-event timeout */
+			pch_err(adap, "%s(L.%d):wait-event timeout\n", __func__, __LINE__);
 			pch_i2c_stop(adap);
+			pch_i2c_init(adap);
 			return -ETIME;
 		}
 		pch_i2c_restart(adap);
@@ -621,7 +629,9 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 			pch_i2c_init(adap);
 			return -EAGAIN;
 		} else { /* wait-event timeout */
+			pch_err(adap, "%s(L.%d):wait-event timeout\n", __func__, __LINE__);
 			pch_i2c_stop(adap);
+			pch_i2c_init(adap);
 			return -ETIME;
 		}
 	} else {
@@ -648,7 +658,9 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		pch_i2c_init(adap);
 		return -EAGAIN;
 	} else { /* wait-event timeout */
+		pch_err(adap, "%s(L.%d):wait-event timeout\n", __func__, __LINE__);
 		pch_i2c_stop(adap);
+		pch_i2c_init(adap);
 		return -ETIME;
 	}
 
@@ -677,7 +689,9 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 					return -EIO;
 				}
 			} else { /* wait-event timeout */
+				pch_err(adap, "%s(L.%d):wait-event timeout\n", __func__, __LINE__);
 				pch_i2c_stop(adap);
+				pch_i2c_init(adap);
 				return -ETIME;
 			}
 
@@ -698,7 +712,9 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 				return -EIO;
 			}
 		} else { /* wait-event timeout */
+			pch_err(adap, "%s(L.%d):wait-event timeout\n", __func__, __LINE__);
 			pch_i2c_stop(adap);
+			pch_i2c_init(adap);
 			return -ETIME;
 		}
 
-- 
1.7.7.6
