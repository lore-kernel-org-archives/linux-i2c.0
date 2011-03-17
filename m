From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [next] i2c-designware build errors
Date: Thu, 17 Mar 2011 11:58:07 +0100
Message-ID: <AANLkTikWRAOAzPgwmzn8UrbKZx4r90smruAayWTPd68t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>, Ben Dooks <ben-linux@fluff.org>
Cc: linux-i2c@vger.kernel.org, Linux-Next <linux-next@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

http://kisskb.ellerman.id.au/kisskb/buildresult/4002561/:

drivers/i2c/busses/i2c-designware-core.c:321: error: implicit
declaration of function 'mdelay'
drivers/i2c/busses/i2c-designware-pcidrv.c:256: error: implicit
declaration of function 'pci_request_region'
drivers/i2c/busses/i2c-designware-pcidrv.c:338: error: implicit
declaration of function 'pci_release_region'

i2c-designware-core.c needs to include <linux/delay.h>
CONFIG_I2C_DESIGNWARE_PCI should depend on CONFIG_PCI

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
