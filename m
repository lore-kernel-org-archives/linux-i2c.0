From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: [PATCH] i2c-designware: define i2c_dw_pci_runtime_idle only with runtime pm
Date: Fri, 27 Sep 2013 00:24:03 +0200
Message-ID: <1380234243-23787-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Make sure i2c_dw_pci_runtime_idle() is defined only when actually used,=
 when
CONFIG_PM_RUNTIME is defined.

This fixes the following compilation warning:

 drivers/i2c/busses/i2c-designware-pcidrv.c:188:12: warning: =E2=80=98i=
2c_dw_pci_runtime_idle=E2=80=99 defined but not used [-Wunused-function=
]

Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/b=
usses/i2c-designware-pcidrv.c
index f6ed06c..2b5d3a6 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -185,6 +185,7 @@ static int i2c_dw_pci_resume(struct device *dev)
 	return 0;
 }
=20
+#ifdef CONFIG_PM_RUNTIME
 static int i2c_dw_pci_runtime_idle(struct device *dev)
 {
 	int err =3D pm_schedule_suspend(dev, 500);
@@ -194,6 +195,7 @@ static int i2c_dw_pci_runtime_idle(struct device *d=
ev)
 		return 0;
 	return -EBUSY;
 }
+#endif
=20
 static const struct dev_pm_ops i2c_dw_pm_ops =3D {
 	.resume         =3D i2c_dw_pci_resume,
--=20
1.8.4.rc3
