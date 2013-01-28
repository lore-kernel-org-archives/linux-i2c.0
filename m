From: =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 5/6] Misc: display unsigned hex
Date: Mon, 28 Jan 2013 22:21:09 +0100
Message-ID: <1359408070-31832-6-git-send-email-amaury.decreme@gmail.com>
References: <20130124083043.57f91a3d@endymion.delvare>
 <1359408070-31832-1-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359408070-31832-1-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Amaury=20Decr=C3=AAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch corrects the display of the acpi_base unsigned hex value.

Signed-off-by: Amaury Decr=C3=AAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-sis630.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c-s=
is630.c
index b2fa741..424545b 100644
--- a/drivers/i2c/busses/i2c-sis630.c
+++ b/drivers/i2c/busses/i2c-sis630.c
@@ -463,7 +463,7 @@ static int sis630_setup(struct pci_dev *sis630_dev)
 		goto exit;
 	}
=20
-	dev_dbg(&sis630_dev->dev, "ACPI base at 0x%04x\n", acpi_base);
+	dev_dbg(&sis630_dev->dev, "ACPI base at 0x%04hx\n", acpi_base);
=20
 	if (supported[i] =3D=3D PCI_DEVICE_ID_SI_760)
 		smbus_base =3D acpi_base + 0xE0;
--=20
1.7.12.4
