From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 2/3] i2c/pxa: only define 'blue_murder'-function if DEBUG is #defined
Date: Wed, 24 Feb 2010 12:01:45 +0100
Message-ID: <1267009306-17227-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100224110044.GB15181@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100224110044.GB15181-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

This talkative function is also called on timeouts. As timeouts can
happen on regular writes to EEPROMs (no error case), this creates false
positives.  Giving lots of details is interesting only for developers
anyhow, so just use the function if DEBUG is #defined.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Acked-by: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.=
c
index b3c6c9d..d8a9159 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -208,16 +208,6 @@ static void i2c_pxa_show_state(struct pxa_i2c *i2c=
, int lno, const char *fname)
 }
=20
 #define show_state(i2c) i2c_pxa_show_state(i2c, __LINE__, __func__)
-#else
-#define i2c_debug	0
-
-#define show_state(i2c) do { } while (0)
-#define decode_ISR(val) do { } while (0)
-#define decode_ICR(val) do { } while (0)
-#endif
-
-static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
-static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
=20
 static void i2c_pxa_scream_blue_murder(struct pxa_i2c *i2c, const char=
 *why)
 {
@@ -233,6 +223,20 @@ static void i2c_pxa_scream_blue_murder(struct pxa_=
i2c *i2c, const char *why)
 	printk("\n");
 }
=20
+#else /* ifdef DEBUG */
+
+#define i2c_debug	0
+
+#define show_state(i2c) do { } while (0)
+#define decode_ISR(val) do { } while (0)
+#define decode_ICR(val) do { } while (0)
+#define i2c_pxa_scream_blue_murder(i2c, why) do { } while (0)
+
+#endif /* ifdef DEBUG / else */
+
+static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
+static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
+
 static inline int i2c_pxa_is_slavemode(struct pxa_i2c *i2c)
 {
 	return !(readl(_ICR(i2c)) & ICR_SCLE);
--=20
1.6.6.2
