From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [next] i2c-designware build errors
Date: Thu, 17 Mar 2011 12:58:42 +0100
Message-ID: <AANLkTimbk8vk7bV2255=fOSXgodnxi2Z9ySKHuOVnYvW@mail.gmail.com>
References: <AANLkTikWRAOAzPgwmzn8UrbKZx4r90smruAayWTPd68t@mail.gmail.com>
	<AANLkTimCwOhpwrLx1c5wdGzmkxB7pH=k6Wg1iQgj07VJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTimCwOhpwrLx1c5wdGzmkxB7pH=k6Wg1iQgj07VJ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sedat.dilek-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Sedat Dilek <sedat.dilek-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-Next <linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 17, 2011 at 12:15, Sedat Dilek <sedat.dilek-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>=
 wrote:
> On Thu, Mar 17, 2011 at 11:58 AM, Geert Uytterhoeven
> <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>> http://kisskb.ellerman.id.au/kisskb/buildresult/4002561/:
>>
>> drivers/i2c/busses/i2c-designware-core.c:321: error: implicit
>> declaration of function 'mdelay'
>> drivers/i2c/busses/i2c-designware-pcidrv.c:256: error: implicit
>> declaration of function 'pci_request_region'
>> drivers/i2c/busses/i2c-designware-pcidrv.c:338: error: implicit
>> declaration of function 'pci_release_region'
>>
>> i2c-designware-core.c needs to include <linux/delay.h>
>> CONFIG_I2C_DESIGNWARE_PCI should depend on CONFIG_PCI
>>
>> Gr{oetje,eeting}s,
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 Geert
>>
>> --
>> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@lin=
ux-m68k.org
>>
>
> Just FYI:
> Randy sent already a patch for this issue "[PATCH -next] i2c:
> designware-pcidrv depends on PCI" [1].
>
> - Sedat -
>
> [1] http://marc.info/?l=3Dlinux-next&m=3D130030077521605&w=3D2

Ah, sorry, my initial search didn't reveal any patches yet...

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
