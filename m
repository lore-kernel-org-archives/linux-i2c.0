From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 23/25] i2c/mpc: make data used as *of_device_id.data const
Date: Mon, 23 Jul 2012 11:13:28 +0200
Message-ID: <1343034810-3386-24-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

=46rom: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

[ukl: split Arnd's patch by driver]

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mpc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.=
c
index 775062c..57f7703 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -730,24 +730,24 @@ static int mpc_i2c_resume(struct device *dev)
 SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
 #endif
=20
-static struct mpc_i2c_data mpc_i2c_data_512x __devinitdata =3D {
+static const struct mpc_i2c_data mpc_i2c_data_512x __devinitdata =3D {
 	.setup =3D mpc_i2c_setup_512x,
 };
=20
-static struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata =3D {
+static const struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata =3D {
 	.setup =3D mpc_i2c_setup_52xx,
 };
=20
-static struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata =3D {
+static const struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata =3D {
 	.setup =3D mpc_i2c_setup_8xxx,
 };
=20
-static struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata =3D {
+static const struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata =3D {
 	.setup =3D mpc_i2c_setup_8xxx,
 	.prescaler =3D 2,
 };
=20
-static struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata =3D {
+static const struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata =3D {
 	.setup =3D mpc_i2c_setup_8xxx,
 	.prescaler =3D 3,
 };
--=20
1.7.10.4
