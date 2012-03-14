From: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: [PATCH] i2c-algo-bit: Fix spurious SCL timeouts under heavy load
Date: Wed, 14 Mar 2012 10:32:52 +0200
Message-ID: <1331713973-7711-1-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <syrjala-ORSVBvAovxo@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When the system is under heavy load, there can be a significant delay
between the getscl() and time_after() calls inside sclhi(). That delay
may cause the time_after() check to trigger after SCL has gone high,
causing sclhi() to return -ETIMEDOUT.

To fix the problem, double check that SCL is still low after the
timeout has been reached, before deciding to return -ETIMEDOUT.

Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <syrjala-ORSVBvAovxo@public.gmane.org>
---
I can easily reproduce these spurious timeouts on my HP-compaq nc6000
laptop with the radeon kms driver. It's enough to have a -j2 kernel
build running, and simultaneosly issue xrandr commands in a
terminal. Calling xrandr will cause the driver to re-read the EDID
from the display. A significant number of the EDID reads will fail.
With this fix I have yet to see any failed EDID reads.

 drivers/i2c/algos/i2c-algo-bit.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-a=
lgo-bit.c
index 525c734..d25112e 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -104,9 +104,11 @@ static int sclhi(struct i2c_algo_bit_data *adap)
 		 * are processing data internally.
 		 */
 		if (time_after(jiffies, start + adap->timeout))
-			return -ETIMEDOUT;
+			break;
 		cond_resched();
 	}
+	if (!getscl(adap))
+		return -ETIMEDOUT;
 #ifdef DEBUG
 	if (jiffies !=3D start && i2c_debug >=3D 3)
 		pr_debug("i2c-algo-bit: needed %ld jiffies for SCL to go "
--=20
1.7.3.4
