From: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3 v2] i2c-eg20t: Call init() when wait-event timeout occurs
Date: Mon, 26 Mar 2012 15:34:10 +0900
Message-ID: <1332743650-9412-1-git-send-email-tomoya.rohm@gmail.com>
References: <1332741325-7746-2-git-send-email-tomoya.rohm@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1332741325-7746-2-git-send-email-tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, joel.clark-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

v1 had checkpatch warnings.

Signed-off-by: Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2
 - Updated for checkpatch
---
 drivers/i2c/busses/i2c-eg20t.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index d73975b..0e3a89f 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -445,7 +445,10 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 			pch_i2c_init(adap);
 			return -EAGAIN;
 		} else { /* wait-event timeout */
+			pch_err(adap, "%s(L.%d):wait-event timeout\n",
+				__func__, __LINE__);
 			pch_i2c_stop(adap);
+			pch_i2c_init(adap);
 			return -ETIME;
 		}
 	} else {
@@ -469,7 +472,10 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 		pch_i2c_init(adap);
 		return -EAGAIN;
 	} else { /* wait-event timeout */
+		pch_err(adap, "%s(L.%d):wait-event timeout\n",
+			__func__, __LINE__);
 		pch_i2c_stop(adap);
+		pch_i2c_init(adap);
 		return -ETIME;
 	}
 
@@ -490,7 +496,10 @@ static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
 			pch_clrbit(adap->pch_base_address, PCH_I2CSR,
 				   I2CMIF_BIT);
 		} else { /* wait-event timeout */
+			pch_err(adap, "%s(L.%d):wait-event timeout\n",
+				__func__, __LINE__);
 			pch_i2c_stop(adap);
+			pch_i2c_init(adap);
 			return -ETIME;
 		}
 	}
@@ -598,7 +607,10 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 			pch_i2c_init(adap);
 			return -EAGAIN;
 		} else { /* wait-event timeout */
+			pch_err(adap, "%s(L.%d):wait-event timeout\n",
+				__func__, __LINE__);
 			pch_i2c_stop(adap);
+			pch_i2c_init(adap);
 			return -ETIME;
 		}
 		pch_i2c_restart(adap);
@@ -621,7 +633,10 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 			pch_i2c_init(adap);
 			return -EAGAIN;
 		} else { /* wait-event timeout */
+			pch_err(adap, "%s(L.%d):wait-event timeout\n",
+				__func__, __LINE__);
 			pch_i2c_stop(adap);
+			pch_i2c_init(adap);
 			return -ETIME;
 		}
 	} else {
@@ -648,7 +663,10 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 		pch_i2c_init(adap);
 		return -EAGAIN;
 	} else { /* wait-event timeout */
+		pch_err(adap, "%s(L.%d):wait-event timeout\n",
+			__func__, __LINE__);
 		pch_i2c_stop(adap);
+		pch_i2c_init(adap);
 		return -ETIME;
 	}
 
@@ -677,7 +695,10 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 					return -EIO;
 				}
 			} else { /* wait-event timeout */
+				pch_err(adap, "%s(L.%d):wait-event timeout\n",
+					__func__, __LINE__);
 				pch_i2c_stop(adap);
+				pch_i2c_init(adap);
 				return -ETIME;
 			}
 
@@ -698,7 +719,10 @@ static s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg *msgs,
 				return -EIO;
 			}
 		} else { /* wait-event timeout */
+			pch_err(adap, "%s(L.%d):wait-event timeout\n",
+				__func__, __LINE__);
 			pch_i2c_stop(adap);
+			pch_i2c_init(adap);
 			return -ETIME;
 		}
 
-- 
1.7.7.6
