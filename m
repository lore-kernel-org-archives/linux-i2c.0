From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v4] i2c: designware-platdrv: fix unbalanced clk enable and prepare
Date: Fri, 22 Apr 2016 16:49:31 +0800
Message-ID: <1461314971-5944-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:59322 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751659AbcDVIxj (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 22 Apr 2016 04:53:39 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

If i2c_dw_probe() fails, we should disable and unprepare the clock,
otherwise the clock enable and prepare is left unbalanced.

In dw_i2c_plat_remove(), we'd better to not rely on runtime PM to
disable and unprepare the clock since CONFIG_PM may be disabled when
configuring the kernel. So we explicitly disable and unprepare the
clock in dw_i2c_plat_remove() rather than implicitly rely on
pm_runtime_put_sync(). To keep the device usage count balanced, we
call pm_runtime_put_noidle() to decrease the usage count.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 Since v3:
  - use runtime PM rather than rpm in commit msg
  - remove duplicated "(" in commit msg

 Since v2:
 =C2=A0- s/clk/clock
 =C2=A0- describe why use pm_runtime_put_noidle()
=20
 Since v1:
 =C2=A0- fix commit msg: "not rely on rpm" rather than "rely on rpm"
 =C2=A0- call i2c_dw_plat_prepare_clk after pm_rumtime_disable()
 drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/=
busses/i2c-designware-platdrv.c
index d656657..a771781 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -253,8 +253,11 @@ static int dw_i2c_plat_probe(struct platform_devic=
e *pdev)
 	}
=20
 	r =3D i2c_dw_probe(dev);
-	if (r && !dev->pm_runtime_disabled)
-		pm_runtime_disable(&pdev->dev);
+	if (r) {
+		if (!dev->pm_runtime_disabled)
+			pm_runtime_disable(&pdev->dev);
+		i2c_dw_plat_prepare_clk(dev, false);
+	}
=20
 	return r;
 }
@@ -264,15 +267,16 @@ static int dw_i2c_plat_remove(struct platform_dev=
ice *pdev)
 	struct dw_i2c_dev *dev =3D platform_get_drvdata(pdev);
=20
 	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	if (!dev->pm_runtime_disabled)
+		pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
=20
 	i2c_del_adapter(&dev->adapter);
=20
 	i2c_dw_disable(dev);
=20
-	pm_runtime_dont_use_autosuspend(&pdev->dev);
-	pm_runtime_put_sync(&pdev->dev);
-	if (!dev->pm_runtime_disabled)
-		pm_runtime_disable(&pdev->dev);
+	i2c_dw_plat_prepare_clk(dev, false);
=20
 	return 0;
 }
--=20
2.8.1
