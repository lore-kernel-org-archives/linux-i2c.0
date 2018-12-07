From: <Andrei.Stefanescu@microchip.com>
Subject: [RESEND PATCH] i2c: at91: switched to resume/suspend callbacks.
Date: Fri, 7 Dec 2018 11:33:04 +0000
Message-ID: <1544182362-7001-1-git-send-email-andrei.stefanescu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Cristian.Birsan@microchip.com
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Andrei.Stefanescu@microchip.com
List-Id: linux-i2c@vger.kernel.org

In the previous version of the driver resume/suspend_noirq callbacks
were used. Because of this, when resuming from suspend-to-ram,
an I2C (belonging to a FLEXCOM) would resume before FLEXCOM.
The first read on the I2C bus would then result in a timeout.

This patch switches to resume/suspend callbacks which are=20
called after FLEXCOM resumes. FLEXCOM, SPI and USART drivers use
resume/suspend callbacks.

Signed-off-by: Andrei Stefanescu <andrei.stefanescu@microchip.com>
---
 drivers/i2c/busses/i2c-at91.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index bfd1fdf..81f7b94 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -1174,7 +1174,7 @@ static int at91_twi_runtime_resume(struct device *dev=
)
 	return clk_prepare_enable(twi_dev->clk);
 }
=20
-static int at91_twi_suspend_noirq(struct device *dev)
+static int at91_twi_suspend(struct device *dev)
 {
 	if (!pm_runtime_status_suspended(dev))
 		at91_twi_runtime_suspend(dev);
@@ -1182,7 +1182,7 @@ static int at91_twi_suspend_noirq(struct device *dev)
 	return 0;
 }
=20
-static int at91_twi_resume_noirq(struct device *dev)
+static int at91_twi_resume(struct device *dev)
 {
 	struct at91_twi_dev *twi_dev =3D dev_get_drvdata(dev);
 	int ret;
@@ -1202,8 +1202,8 @@ static int at91_twi_resume_noirq(struct device *dev)
 }
=20
 static const struct dev_pm_ops at91_twi_pm =3D {
-	.suspend_noirq	=3D at91_twi_suspend_noirq,
-	.resume_noirq	=3D at91_twi_resume_noirq,
+	.suspend	=3D at91_twi_suspend,
+	.resume		=3D at91_twi_resume,
 	.runtime_suspend	=3D at91_twi_runtime_suspend,
 	.runtime_resume		=3D at91_twi_runtime_resume,
 };
--=20
2.7.4
