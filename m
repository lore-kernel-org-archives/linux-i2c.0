From: "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUG] i2c-designware: (allyesconfig) error: multiple definition
Date: Tue, 29 Nov 2011 15:35:38 +0200
Message-ID: <CAE1zotJy6eYMOuNqQx7eiFPnnJ5raDRSDqTaLcV8iie5MJ0wbg@mail.gmail.com>
References: <1322567933.2182.16.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1322567933.2182.16.camel@mars>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Fritz <chf.fritz-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 29, 2011 at 1:58 PM, Christoph Fritz
<chf.fritz-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> wrote:
> Hi,
>
> =A0I just hit this bug with allyesconfig:
>
> make[2]: `include/generated/mach-types.h' is up to date.
> =A0CALL =A0 =A0/xxx/linux-2.6/scripts/checksyscalls.sh
> =A0CHK =A0 =A0 include/generated/compile.h
> =A0CHK =A0 =A0 kernel/config_data.h
> =A0CHECK =A0 /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c
> =A0CC =A0 =A0 =A0drivers/i2c/busses/i2c-designware-core.o
> =A0CHECK =A0 /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-pcidrv.=
c
> =A0CC =A0 =A0 =A0drivers/i2c/busses/i2c-designware-pcidrv.o
> =A0CHECK =A0 /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-platdrv=
=2Ec
> =A0CC =A0 =A0 =A0drivers/i2c/busses/i2c-designware-platdrv.o
> =A0LD =A0 =A0 =A0drivers/i2c/busses/i2c-designware-pci.o
> =A0LD =A0 =A0 =A0drivers/i2c/busses/i2c-designware-platform.o
> =A0LD =A0 =A0 =A0drivers/i2c/busses/built-in.o
> drivers/i2c/busses/i2c-designware-pci.o: In function `i2c_dw_clear_in=
t':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:694: multiple=
 definition of `i2c_dw_clear_int'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:694: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `i2c_dw_init':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:247: multiple=
 definition of `i2c_dw_init'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:247: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `dw_readl':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:169: multiple=
 definition of `dw_readl'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:169: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `i2c_dw_isr':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:627: multiple=
 definition of `i2c_dw_isr'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:627: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `i2c_dw_xfer':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:498: multiple=
 definition of `i2c_dw_xfer'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:498: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `i2c_dw_is_enabled':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:679: multiple=
 definition of `i2c_dw_is_enabled'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:679: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `dw_writel':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:177: multiple=
 definition of `dw_writel'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:177: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `i2c_dw_xfer_msg':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:362: multiple=
 definition of `i2c_dw_xfer_msg'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:362: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `i2c_dw_enable':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:674: multiple=
 definition of `i2c_dw_enable'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:674: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `i2c_dw_read_comp_param':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:704: multiple=
 definition of `i2c_dw_read_comp_param'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:704: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `i2c_dw_disable':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:683: multiple=
 definition of `i2c_dw_disable'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:683: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `i2c_dw_func':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:562: multiple=
 definition of `i2c_dw_func'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:562: first defined here drivers/i2c/bus=
ses/i2c-designware-pci.o: In function `i2c_dw_disable_int':
> /xxx/linux-2.6/drivers/i2c/busses/i2c-designware-core.c:699: multiple=
 definition of `i2c_dw_disable_int'
> drivers/i2c/busses/i2c-designware-platform.o:/xxx/linux-2.6/drivers/i=
2c/busses/i2c-designware-core.c:699: first defined here make[4]: *** [d=
rivers/i2c/busses/built-in.o] Error 1
> make[3]: *** [drivers/i2c/busses] Error 2
> make[2]: *** [drivers/i2c] Error 2
> make[1]: *** [drivers] Error 2
> make: *** [sub-make] Error 2
>
>

Hi Christoph,

What tree are you using? I tried the following on Linus's tree (head
at 8748dfae379573cdbea4e765b55e608a1764f918):

make allyesconfig
make -j4 drivers/i2c/busses/

and did not run into any errors.

Thanks,
Tavi
