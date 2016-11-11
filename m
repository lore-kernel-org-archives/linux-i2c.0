From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 2/2] i2c: octeon: Fix waiting for operation completion
Date: Fri, 11 Nov 2016 09:57:07 +0100
Message-ID: <20161111085707.GC16907@hardcore>
References: <20161107200921.30284-1-paul.burton@imgtec.com>
 <20161107200921.30284-2-paul.burton@imgtec.com>
 <20161109134103.GC2960@hardcore>
 <1595446.2T31j1Ekg5@np-p-burton>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <1595446.2T31j1Ekg5@np-p-burton>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Paul Burton <paul.burton@imgtec.com>
Cc: linux-i2c@vger.kernel.org, linux-mips@linux-mips.org, David Daney <david.daney@cavium.com>, Peter Swain <pswain@cavium.com>, Wolfram Sang <wsa@the-dreams.de>, "Steven J. Hill" <Steven.Hill@cavium.com>
List-Id: linux-i2c@vger.kernel.org

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

> As you can see octeon_i2c_driver_init never returns. Are you able to test on 
> one of your MIPS-based systems?
> 
> Thanks,
>     Paul

Hi Paul,

we can reproduce the problem on our side, but I don't have direct access
to a MIPS system so I'm still just guessing what happens. If you want
you can try the attached patches.

I'm trying to get rid of the polling around the interrupt altogether.
It works fine on Thunderx, sometimes I run into an interrupt timeout 
after a lost-arbitration but recovery/retry is able to clean that up.

Please also revert 70121f7 as before. The last patch adds some debugging
output to see if we run into timeouts or recovery.

thanks,
Jan

--T4sUOijqQbZv57TR
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0001-i2c-octeon-thunderx-TWSI-software-reset-in-recovery.patch"

>From 21a158efd0b6c5a08af8f1c1b078bc4b40291bbf Mon Sep 17 00:00:00 2001
From: Jan Glauber <jglauber@cavium.com>
Date: Fri, 11 Nov 2016 09:17:19 +0100
Subject: [PATCH 1/3] i2c: octeon: thunderx: TWSI software reset in recovery

I've seen i2c recovery reporting long loops of:

[ 1035.887818] i2c i2c-4: SCL is stuck low, exit recovery
[ 1037.999748] i2c i2c-4: SCL is stuck low, exit recovery
[ 1040.111694] i2c i2c-4: SCL is stuck low, exit recovery
...

Add a TWSI software reset which clears the status and
STA,STP,IFLG in SW_TWSI_EOP_TWSI_CTL.

With this the recovery works fine and above message is not seen.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 419b54b..0b02070 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -791,6 +791,9 @@ static void octeon_i2c_prepare_recovery(struct i2c_adapter *adap)
 	struct octeon_i2c *i2c = i2c_get_adapdata(adap);
 
 	octeon_i2c_hlc_disable(i2c);
+	octeon_i2c_reg_write(i2c, SW_TWSI_EOP_TWSI_RST, 0);
+	/* wait for software reset to settle */
+	udelay(5);
 
 	/*
 	 * Bring control register to a good state regardless
-- 
1.9.1


--T4sUOijqQbZv57TR
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0002-i2c-octeon-thunderx-Remove-polling-after-interrupt.patch"

>From d904526a298edcf1bfba173b1b71a677eb413677 Mon Sep 17 00:00:00 2001
From: Jan Glauber <jglauber@cavium.com>
Date: Fri, 11 Nov 2016 09:34:34 +0100
Subject: [PATCH 2/3] i2c: octeon: thunderx: Remove polling after interrupt

Remove the polling after the interrupt. In case the IFLG
is not set although the interrupt occured we will run into
a timeout and retry the operation. This should happen very
seldom.

Note: the default timeout (1s) can be changed via an ioclt
per device.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 43 ++----------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 0b02070..1d8775799 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -36,24 +36,6 @@ static bool octeon_i2c_test_iflg(struct octeon_i2c *i2c)
 	return (octeon_i2c_ctl_read(i2c) & TWSI_CTL_IFLG);
 }
 
-static bool octeon_i2c_test_ready(struct octeon_i2c *i2c, bool *first)
-{
-	if (octeon_i2c_test_iflg(i2c))
-		return true;
-
-	if (*first) {
-		*first = false;
-		return false;
-	}
-
-	/*
-	 * IRQ has signaled an event but IFLG hasn't changed.
-	 * Sleep and retry once.
-	 */
-	usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
-	return octeon_i2c_test_iflg(i2c);
-}
-
 /**
  * octeon_i2c_wait - wait for the IFLG to be set
  * @i2c: The struct octeon_i2c
@@ -63,7 +45,6 @@ static bool octeon_i2c_test_ready(struct octeon_i2c *i2c, bool *first)
 static int octeon_i2c_wait(struct octeon_i2c *i2c)
 {
 	long time_left;
-	bool first = true;
 
 	/*
 	 * Some chip revisions don't assert the irq in the interrupt
@@ -80,7 +61,7 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 	}
 
 	i2c->int_enable(i2c);
-	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_ready(i2c, &first),
+	time_left = wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c),
 				       i2c->adap.timeout);
 	i2c->int_disable(i2c);
 
@@ -102,25 +83,6 @@ static bool octeon_i2c_hlc_test_valid(struct octeon_i2c *i2c)
 	return (__raw_readq(i2c->twsi_base + SW_TWSI(i2c)) & SW_TWSI_V) == 0;
 }
 
-static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c, bool *first)
-{
-	/* check if valid bit is cleared */
-	if (octeon_i2c_hlc_test_valid(i2c))
-		return true;
-
-	if (*first) {
-		*first = false;
-		return false;
-	}
-
-	/*
-	 * IRQ has signaled an event but valid bit isn't cleared.
-	 * Sleep and retry once.
-	 */
-	usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
-	return octeon_i2c_hlc_test_valid(i2c);
-}
-
 static void octeon_i2c_hlc_int_clear(struct octeon_i2c *i2c)
 {
 	/* clear ST/TS events, listen for neither */
@@ -176,7 +138,6 @@ static void octeon_i2c_hlc_disable(struct octeon_i2c *i2c)
  */
 static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 {
-	bool first = true;
 	int time_left;
 
 	/*
@@ -195,7 +156,7 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 
 	i2c->hlc_int_enable(i2c);
 	time_left = wait_event_timeout(i2c->queue,
-				       octeon_i2c_hlc_test_ready(i2c, &first),
+				       octeon_i2c_hlc_test_valid(i2c),
 				       i2c->adap.timeout);
 	i2c->hlc_int_disable(i2c);
 	if (!time_left)
-- 
1.9.1


--T4sUOijqQbZv57TR
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0003-i2c-octeon-thunderx-Debug-prints-for-timeout-and-rec.patch"

>From 45eae05b8d793f5652f77ab1d5faa62c30927a10 Mon Sep 17 00:00:00 2001
From: Jan Glauber <jglauber@cavium.com>
Date: Fri, 11 Nov 2016 09:40:15 +0100
Subject: [PATCH 3/3] i2c: octeon: thunderx: Debug prints for timeout and
 recovery

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 1d8775799..a2a92b6 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -72,9 +72,10 @@ static int octeon_i2c_wait(struct octeon_i2c *i2c)
 		return 0;
 	}
 
-	if (!time_left)
+	if (!time_left) {
+		pr_err("%s: timed out\n", __func__);
 		return -ETIMEDOUT;
-
+	}
 	return 0;
 }
 
@@ -169,8 +170,10 @@ static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 		return 0;
 	}
 
-	if (!time_left)
+	if (!time_left) {
+		pr_err("%s: timed out\n", __func__);
 		return -ETIMEDOUT;
+	}
 	return 0;
 }
 
@@ -280,6 +283,7 @@ static int octeon_i2c_start(struct octeon_i2c *i2c)
 
 error:
 	/* START failed, try to recover */
+	pr_err("%s: try to recover from status: %d\n", __func__, stat);
 	ret = octeon_i2c_recovery(i2c);
 	return (ret) ? ret : -EAGAIN;
 }
-- 
1.9.1


--T4sUOijqQbZv57TR--
