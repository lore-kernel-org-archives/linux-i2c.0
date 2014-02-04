From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH] i2c: designware-pci: Cleanup driver power management
Date: Tue,  4 Feb 2014 14:37:07 +0200
Message-ID: <1391517427-16204-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, xinhuix.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The PCI part of the DesignWare I2C driver does a lot of things that are=
 not
required anymore. For example drivers aren't supposed to handle PCI sta=
te
transitions themselves. This is all provided by the PCI bus core alread=
y.

In addition to that there is no point scheduling RPM suspend on driver'=
s
idle hook but instead we can use RPM autosuspend for this (which is ena=
bled
in the driver already).

As a bonus, this patch also fixes following compile warning which is
emitted when the driver was compiled without CONFIG_PM_RUNTIME set:

drivers/i2c/busses/i2c-designware-pcidrv.c:245:12: warning: =E2=80=98i2=
c_dw_pci_runtime_idle=E2=80=99 defined but not used [-Wunused-function]

Reported-by: xinhui.pan <xinhuix.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reported-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 57 ++++------------------=
--------
 1 file changed, 7 insertions(+), 50 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/b=
usses/i2c-designware-pcidrv.c
index f6ed06c966ee..c0a87a5eb63e 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -138,69 +138,25 @@ static struct i2c_algorithm i2c_dw_algo =3D {
 	.functionality	=3D i2c_dw_func,
 };
=20
+#ifdef CONFIG_PM
 static int i2c_dw_pci_suspend(struct device *dev)
 {
 	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
-	struct dw_i2c_dev *i2c =3D pci_get_drvdata(pdev);
-	int err;
-
-
-	i2c_dw_disable(i2c);
-
-	err =3D pci_save_state(pdev);
-	if (err) {
-		dev_err(&pdev->dev, "pci_save_state failed\n");
-		return err;
-	}
-
-	err =3D pci_set_power_state(pdev, PCI_D3hot);
-	if (err) {
-		dev_err(&pdev->dev, "pci_set_power_state failed\n");
-		return err;
-	}
=20
+	i2c_dw_disable(pci_get_drvdata(pdev));
 	return 0;
 }
=20
 static int i2c_dw_pci_resume(struct device *dev)
 {
 	struct pci_dev *pdev =3D container_of(dev, struct pci_dev, dev);
-	struct dw_i2c_dev *i2c =3D pci_get_drvdata(pdev);
-	int err;
-	u32 enabled;
-
-	enabled =3D i2c_dw_is_enabled(i2c);
-	if (enabled)
-		return 0;
-
-	err =3D pci_set_power_state(pdev, PCI_D0);
-	if (err) {
-		dev_err(&pdev->dev, "pci_set_power_state() failed\n");
-		return err;
-	}
=20
-	pci_restore_state(pdev);
-
-	i2c_dw_init(i2c);
-	return 0;
+	return i2c_dw_init(pci_get_drvdata(pdev));
 }
+#endif
=20
-static int i2c_dw_pci_runtime_idle(struct device *dev)
-{
-	int err =3D pm_schedule_suspend(dev, 500);
-	dev_dbg(dev, "runtime_idle called\n");
-
-	if (err !=3D 0)
-		return 0;
-	return -EBUSY;
-}
-
-static const struct dev_pm_ops i2c_dw_pm_ops =3D {
-	.resume         =3D i2c_dw_pci_resume,
-	.suspend        =3D i2c_dw_pci_suspend,
-	SET_RUNTIME_PM_OPS(i2c_dw_pci_suspend, i2c_dw_pci_resume,
-			   i2c_dw_pci_runtime_idle)
-};
+static UNIVERSAL_DEV_PM_OPS(i2c_dw_pm_ops, i2c_dw_pci_suspend,
+			    i2c_dw_pci_resume, NULL);
=20
 static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 {
@@ -290,6 +246,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
=20
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 1000);
 	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
 	pm_runtime_allow(&pdev->dev);
=20
 	return 0;
--=20
1.8.5.2
