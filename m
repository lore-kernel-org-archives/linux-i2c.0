From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH v7 08/15] i2c: octeon: Improve performance if interrupt is early
Date: Mon, 25 Apr 2016 16:33:37 +0200
Message-ID: <1461594824-7215-9-git-send-email-jglauber@cavium.com>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Jan Glauber <jglauber@cavium.com>
List-Id: linux-i2c@vger.kernel.org

=46rom: Peter Swain <pswain@cavium.com>

There is a race between the TWSI interrupt and the condition
that is required before proceeding:

Low-level: interrupt flag bit must be set
High-level controller: valid bit must be clear

If the interrupt comes too early and the condition is not met
the wait will time out, and the transfer is aborted leading
to very poor performance.

To avoid this race retry for the condition ~80 =C2=B5s later.
The retry is avoided on the very first invocation of
wait_event_timeout() (which tests the condition before entering
the wait and is therefore always wrong in this case).

EEPROM reads on 100kHz i2c now measure ~5.2kB/s, about 1/2 what's
achievable, and much better than the worst-case 100 bytes/sec before.

While at it remove the debug print from the low-level wait function.

Signed-off-by: Peter Swain <pswain@cavium.com>
Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon.c | 55 +++++++++++++++++++++++++++++++++=
+-------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon.c b/drivers/i2c/busses/i2c-o=
cteon.c
index 76fa479..3144fe9 100644
--- a/drivers/i2c/busses/i2c-octeon.c
+++ b/drivers/i2c/busses/i2c-octeon.c
@@ -109,6 +109,8 @@
 #define TWSI_INT_SDA		BIT_ULL(10)
 #define TWSI_INT_SCL		BIT_ULL(11)
=20
+#define I2C_OCTEON_EVENT_WAIT 80 /* microseconds */
+
 struct octeon_i2c {
 	wait_queue_head_t queue;
 	struct i2c_adapter adap;
@@ -340,11 +342,29 @@ static irqreturn_t octeon_i2c_hlc_isr78(int irq, =
void *dev_id)
 	return IRQ_HANDLED;
 }
=20
-static int octeon_i2c_test_iflg(struct octeon_i2c *i2c)
+static bool octeon_i2c_test_iflg(struct octeon_i2c *i2c)
 {
 	return (octeon_i2c_ctl_read(i2c) & TWSI_CTL_IFLG);
 }
=20
+static bool octeon_i2c_test_ready(struct octeon_i2c *i2c, bool *first)
+{
+	if (octeon_i2c_test_iflg(i2c))
+		return true;
+
+	if (*first) {
+		*first =3D false;
+		return false;
+	}
+
+	/*
+	 * IRQ has signaled an event but IFLG hasn't changed.
+	 * Sleep and retry once.
+	 */
+	usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
+	return octeon_i2c_test_iflg(i2c);
+}
+
 /**
  * octeon_i2c_wait - wait for the IFLG to be set
  * @i2c: The struct octeon_i2c
@@ -354,15 +374,14 @@ static int octeon_i2c_test_iflg(struct octeon_i2c=
 *i2c)
 static int octeon_i2c_wait(struct octeon_i2c *i2c)
 {
 	long time_left;
+	bool first =3D 1;
=20
 	i2c->int_enable(i2c);
-	time_left =3D wait_event_timeout(i2c->queue, octeon_i2c_test_iflg(i2c=
),
+	time_left =3D wait_event_timeout(i2c->queue, octeon_i2c_test_ready(i2=
c, &first),
 				       i2c->adap.timeout);
 	i2c->int_disable(i2c);
-	if (!time_left) {
-		dev_dbg(i2c->dev, "%s: timeout\n", __func__);
+	if (!time_left)
 		return -ETIMEDOUT;
-	}
=20
 	return 0;
 }
@@ -428,11 +447,28 @@ static int octeon_i2c_check_status(struct octeon_=
i2c *i2c, int final_read)
 	}
 }
=20
-static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c)
+static bool octeon_i2c_hlc_test_valid(struct octeon_i2c *i2c)
+{
+	return (__raw_readq(i2c->twsi_base + SW_TWSI) & SW_TWSI_V) =3D=3D 0;
+}
+
+static bool octeon_i2c_hlc_test_ready(struct octeon_i2c *i2c, bool *fi=
rst)
 {
-	u64 val =3D __raw_readq(i2c->twsi_base + SW_TWSI);
+	/* check if valid bit is cleared */
+	if (octeon_i2c_hlc_test_valid(i2c))
+		return true;
=20
-	return (val & SW_TWSI_V) =3D=3D 0;
+	if (*first) {
+		*first =3D false;
+		return false;
+	}
+
+	/*
+	 * IRQ has signaled an event but valid bit isn't cleared.
+	 * Sleep and retry once.
+	 */
+	usleep_range(I2C_OCTEON_EVENT_WAIT, 2 * I2C_OCTEON_EVENT_WAIT);
+	return octeon_i2c_hlc_test_valid(i2c);
 }
=20
 static void octeon_i2c_hlc_int_enable(struct octeon_i2c *i2c)
@@ -454,11 +490,12 @@ static void octeon_i2c_hlc_int_clear(struct octeo=
n_i2c *i2c)
  */
 static int octeon_i2c_hlc_wait(struct octeon_i2c *i2c)
 {
+	bool first =3D 1;
 	int time_left;
=20
 	i2c->hlc_int_enable(i2c);
 	time_left =3D wait_event_timeout(i2c->queue,
-				       octeon_i2c_hlc_test_ready(i2c),
+				       octeon_i2c_hlc_test_ready(i2c, &first),
 				       i2c->adap.timeout);
 	i2c->hlc_int_disable(i2c);
 	if (!time_left) {
--=20
1.9.1
