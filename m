From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH] i2c: I2C_ELEKTOR should depend on HAS_IOPORT
Date: Mon,  8 Aug 2011 13:20:46 +0200
Message-ID: <1312802446-19154-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Hans Berglund <hb-wBUg6WsUcUgXWF+eFR7m5Q@public.gmane.org>
Cc: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On m68k, I get:

drivers/i2c/busses/i2c-elektor.c: In function =E2=80=98pcf_isa_init=E2=80=
=99:
drivers/i2c/busses/i2c-elektor.c:153: error: implicit declaration of fu=
nction =E2=80=98ioport_map=E2=80=99
drivers/i2c/busses/i2c-elektor.c:153: warning: assignment makes pointer=
 from integer without a cast
drivers/i2c/busses/i2c-elektor.c: In function =E2=80=98elektor_probe=E2=
=80=99:
drivers/i2c/busses/i2c-elektor.c:287: error: implicit declaration of fu=
nction =E2=80=98ioport_unmap=E2=80=99

Since commit 82ed223c264def2b15ee4bec2e8c3048092ceb5f ("iomap: make IOP=
ORT/PCI
mapping functions conditional"), ioport_map() is only available on plat=
forms
that set HAS_IOPORT.

Signed-off-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 646068e..d1fc5cf 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -789,7 +789,7 @@ config I2C_ACORN
=20
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
-	depends on ISA && BROKEN_ON_SMP
+	depends on ISA && HAS_IOPORT && BROKEN_ON_SMP
 	select I2C_ALGOPCF
 	help
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
--=20
1.7.0.4
