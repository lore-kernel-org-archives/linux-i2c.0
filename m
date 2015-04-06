From: <grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 1/3] i2c: recovery: change input parameter to i2c_adapter for prepare/unprepare_recovery
Date: Mon,  6 Apr 2015 15:38:39 +0300
Message-ID: <1428323921-25832-2-git-send-email-grygorii.strashko@linaro.org>
References: <1428323921-25832-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428323921-25832-1-git-send-email-grygorii.strashko-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>

This patch changes type of input parameter for .prepare/unprepare_recov=
ery()
callbacks from struct i2c_bus_recovery_info * to struct i2c_adapter *.
This allows to simplify implementation of these callbacks and avoid
type conversations from i2c_bus_recovery_info to i2c_adapter.
The i2c_bus_recovery_info can be simply retrieved from struct i2c_adapt=
er
which contains pointer on it.

CC: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
CC: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
CC: Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/i2c-core.c | 4 ++--
 include/linux/i2c.h    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index fe80f85..617a19a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -561,7 +561,7 @@ static int i2c_generic_recovery(struct i2c_adapter =
*adap)
 	int i =3D 0, val =3D 1, ret =3D 0;
=20
 	if (bri->prepare_recovery)
-		bri->prepare_recovery(bri);
+		bri->prepare_recovery(adap);
=20
 	/*
 	 * By this time SCL is high, as we need to give 9 falling-rising edge=
s
@@ -586,7 +586,7 @@ static int i2c_generic_recovery(struct i2c_adapter =
*adap)
 	}
=20
 	if (bri->unprepare_recovery)
-		bri->unprepare_recovery(bri);
+		bri->unprepare_recovery(adap);
=20
 	return ret;
 }
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index c5e4bb2..898033f 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -435,8 +435,8 @@ struct i2c_bus_recovery_info {
 	void (*set_scl)(struct i2c_adapter *, int val);
 	int (*get_sda)(struct i2c_adapter *);
=20
-	void (*prepare_recovery)(struct i2c_bus_recovery_info *bri);
-	void (*unprepare_recovery)(struct i2c_bus_recovery_info *bri);
+	void (*prepare_recovery)(struct i2c_adapter *);
+	void (*unprepare_recovery)(struct i2c_adapter *);
=20
 	/* gpio recovery */
 	int scl_gpio;
--=20
1.9.1
