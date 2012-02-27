From: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
Subject: [PATCH] i2c: export bit-banging algo functions
Date: Tue, 28 Feb 2012 00:39:39 +0100
Message-ID: <1330385979-19406-1-git-send-email-daniel.vetter@ffwll.ch>
References: <20120227225223.GB1050@phenom.ffwll.local>
Mime-Version: 1.0
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120227225223.GB1050-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Intel Graphics Development <intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, DRI Development <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

i915 has a hw i2c controller (gmbus) but for a bunch of stupid reasons
we need to be able to fall back to the bit-banging algo on gpio pins.

The current code sets up a 2nd i2c controller for the same i2c bus using
the bit-banging algo. This has a bunch of issues, the major one being
that userspace can directly access this fallback i2c adaptor behind
the drivers back.

But we need to frob a few registers before and after using fallback
gpio bit-banging, so this horribly fails.

The new plan is to only set up one i2c adaptor and transparently fall
back to bit-banging by directly calling the xfer function of the bit-
banging algo in the i2c core.

To make that possible, export the 2 i2c algo functions.

v2: As suggested by Jean Delvare, simply export the i2c_bit_algo
vtable instead of the individual functions.

Signed-off-by: Daniel Vetter <daniel.vetter-/w4YWyX8dFk@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |    3 ++-
 include/linux/i2c-algo-bit.h     |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 525c734..ad0459c 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -610,10 +610,11 @@ static u32 bit_func(struct i2c_adapter *adap)
 
 /* -----exported algorithm data: -------------------------------------	*/
 
-static const struct i2c_algorithm i2c_bit_algo = {
+const struct i2c_algorithm i2c_bit_algo = {
 	.master_xfer	= bit_xfer,
 	.functionality	= bit_func,
 };
+EXPORT_SYMBOL(i2c_bit_algo);
 
 /*
  * registering functions to load algorithms at runtime
diff --git a/include/linux/i2c-algo-bit.h b/include/linux/i2c-algo-bit.h
index 4f98148..584ffa0 100644
--- a/include/linux/i2c-algo-bit.h
+++ b/include/linux/i2c-algo-bit.h
@@ -49,5 +49,6 @@ struct i2c_algo_bit_data {
 
 int i2c_bit_add_bus(struct i2c_adapter *);
 int i2c_bit_add_numbered_bus(struct i2c_adapter *);
+extern const struct i2c_algorithm i2c_bit_algo;
 
 #endif /* _LINUX_I2C_ALGO_BIT_H */
-- 
1.7.7.5
