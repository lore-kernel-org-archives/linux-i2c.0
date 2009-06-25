From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: build issue #15 for v2.6.31-rc1 : build failure of
 i2c-designware.c
Date: Thu, 25 Jun 2009 15:02:13 +0200
Message-ID: <20090625150213.19164ea0@hyperion.delvare>
References: <200906251457.06527.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200906251457.06527.toralf.foerster-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Toralf =?ISO-8859-15?B?RvZyc3Rlcg==?= <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Toralf,

On Thu, 25 Jun 2009 14:57:06 +0200, Toralf F=F6rster wrote:
> Hello,
>=20
> the build (.config attached) failed, make ends with :
> ...
>   CC      drivers/w1/slaves/w1_ds2433.o
>   CC      drivers/w1/slaves/w1_ds2760.o
> drivers/video/s1d13xxxfb.c:421: warning: 'bltbit_wait_bitset' defined=
 but not used
> drivers/video/s1d13xxxfb.c:464: warning: 'bltbit_fifo_status' defined=
 but not used
>   CC      drivers/video/carminefb.o
>   CC      drivers/w1/slaves/w1_bq27000.o
>   LD      drivers/w1/slaves/built-in.o
>   LD      drivers/w1/wire.o
>   LD      drivers/w1/built-in.o
>   CC      drivers/video/vfb.o
>   CC      drivers/video/output.o
>   LD      drivers/video/fb.o
>   LD      drivers/video/built-in.o
>   LD      drivers/built-in.o
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> WARNING: modpost: Found 8 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=3Dy'
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `i2c_dw_init':
> i2c-designware.c:(.text+0x4ddcc2): undefined reference to `clk_get_ra=
te'
> drivers/built-in.o: In function `dw_i2c_probe':
> i2c-designware.c:(.devinit.text+0x50200): undefined reference to `clk=
_get'
> i2c-designware.c:(.devinit.text+0x5021d): undefined reference to `clk=
_enable'
> i2c-designware.c:(.devinit.text+0x50349): undefined reference to `clk=
_disable'
> i2c-designware.c:(.devinit.text+0x50354): undefined reference to `clk=
_put'
> drivers/built-in.o: In function `dw_i2c_remove':
> i2c-designware.c:(.devexit.text+0x5cba): undefined reference to `clk_=
disable'
> i2c-designware.c:(.devexit.text+0x5cc5): undefined reference to `clk_=
put'
> make: *** [.tmp_vmlinux1] Error 1
>=20
> The build was made with :
> $>make randconfig; make clean; make

Thanks for reporting. Already fixed, please see:
http://marc.info/?l=3Dlinux-i2c&m=3D124592430920676&w=3D2

--=20
Jean Delvare
