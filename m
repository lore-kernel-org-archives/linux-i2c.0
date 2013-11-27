From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: [PATCH] i2c: bcm-kona: fix module device table symbol
Date: Wed, 27 Nov 2013 23:38:40 +0100
Message-ID: <1385591920-7714-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This fixes the following compilation error when compiling in module:

  drivers/i2c/busses/i2c-bcm-kona.c:894:1: error: =E2=80=98__mod_of_dev=
ice_table=E2=80=99 aliased to undefined symbol =E2=80=98kona_i2c_of_mat=
ch=E2=80=99

Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---

Hi,

Compilation breakage can be seen on mainline with e.g. arm allmodconfig=
=2E

Best regards,

V.

 drivers/i2c/busses/i2c-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c=
-bcm-kona.c
index 036cf03..2fefc24 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -891,7 +891,7 @@ static const struct of_device_id bcm_kona_i2c_of_ma=
tch[] =3D {
 	{.compatible =3D "brcm,kona-i2c",},
 	{},
 };
-MODULE_DEVICE_TABLE(of, kona_i2c_of_match);
+MODULE_DEVICE_TABLE(of, bcm_kona_i2c_of_match);
=20
 static struct platform_driver bcm_kona_i2c_driver =3D {
 	.driver =3D {
--=20
1.8.4.3
