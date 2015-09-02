From: Mike Rapoport <mike.rapoport-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-mux-reg: fix compilation warnings
Date: Wed,  2 Sep 2015 11:03:41 +0300
Message-ID: <1441181021-4937-1-git-send-email-mike.rapoport@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <mike.rapoport-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

With CONFIG_OF=3Dn, the following warnings occur when compiling
drivers/i2c/muxes/i2c-mux-reg.c:

  CC      drivers/i2c/muxes/i2c-mux-reg.o
drivers/i2c/muxes/i2c-mux-reg.c:170:13: warning: =E2=80=98struct gpiomu=
x=E2=80=99 declared inside parameter list [enabled by default]
      struct platform_device *pdev)
             ^
drivers/i2c/muxes/i2c-mux-reg.c:170:13: warning: its scope
is only this definition or declaration, which is probably not what you =
want [enabled by default]
drivers/i2c/muxes/i2c-mux-reg.c: In function =E2=80=98i2c_mux_reg_probe=
=E2=80=99:
drivers/i2c/muxes/i2c-mux-reg.c:201:3: warning: passing argument 1 of =E2=
=80=98i2c_mux_reg_probe_dt=E2=80=99 from incompatible pointer type [ena=
bled by default]
   ret =3D i2c_mux_reg_probe_dt(mux, pdev);
   ^

Signed-off-by: Mike Rapoport <mike.rapoport-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/muxes/i2c-mux-reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/muxes/i2c-mux-reg.c b/drivers/i2c/muxes/i2c-mu=
x-reg.c
index 86d41d36..cff1519 100644
--- a/drivers/i2c/muxes/i2c-mux-reg.c
+++ b/drivers/i2c/muxes/i2c-mux-reg.c
@@ -166,7 +166,7 @@ static int i2c_mux_reg_probe_dt(struct regmux *mux,
 	return 0;
 }
 #else
-static int i2c_mux_reg_probe_dt(struct gpiomux *mux,
+static int i2c_mux_reg_probe_dt(struct regmux *mux,
 					struct platform_device *pdev)
 {
 	return 0;
--=20
1.8.3.1
