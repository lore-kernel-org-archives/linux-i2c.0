From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@freescale.com>
Subject: [PATCH linux-next] i2c-designware: use div_u64 to fix link
Date: Tue, 2 Jul 2013 11:46:54 +0200
Message-ID: <1372758414-21513-1-git-send-email-vincent.stehle@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@freescale.com>, Wolfram Sang <wsa@the-dreams.de>, Christian Ruppert <christian.ruppert@abilis.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>
List-Id: linux-i2c@vger.kernel.org

This fixes the following link error:

  drivers/built-in.o: In function `dw_i2c_probe':
  of_iommu.c:(.text+0x18c8f0): undefined reference to `__aeabi_uldivmod=
'
  make: *** [vmlinux] Error 1

Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@freescale.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Christian Ruppert <christian.ruppert@abilis.com>
Cc: Pierrick Hascoet <pierrick.hascoet@abilis.com>
---


Hi,

Linux next-20130702 link broke for ARM config multi_v7_defconfig. This =
is with
gcc 4.7.2 but I am not sure it matters much here.

This patch repairs the link.

It did not break anything for me on i.MX6 sabre sd, but it does'nt have=
 a
designware i2c, so more reviewing/testing is welcome.

Best regards,

V.


 drivers/i2c/busses/i2c-designware-platdrv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/=
busses/i2c-designware-platdrv.c
index def79b5..4c5fada 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -122,7 +122,8 @@ static int dw_i2c_probe(struct platform_device *pde=
v)
=20
 		of_property_read_u32(pdev->dev.of_node,
 					"i2c-sda-hold-time-ns", &ht);
-		dev->sda_hold_time =3D ((u64)ic_clk * ht + 500000) / 1000000;
+		dev->sda_hold_time =3D div_u64((u64)ic_clk * ht + 500000,
+					     1000000);
 	}
=20
 	dev->functionality =3D
--=20
1.7.10.4
