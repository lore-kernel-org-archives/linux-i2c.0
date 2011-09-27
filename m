From: Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c:i2c-bfin-twi: TWI controller fails to restart next
 transfer in high system load.
Date: Tue, 27 Sep 2011 10:18:33 +0800
Message-ID: <CAJxxZ0OVRnjUE3kigvab0XU2Tke0yimfmKkZb2TPNtfkbNftWA@mail.gmail.com>
References: <1316759153-17608-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316759153-17608-1-git-send-email-sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Ping.


Sonic Zhang

On Fri, Sep 23, 2011 at 2:25 PM, Sonic Zhang <sonic.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
> From: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
>
> Current driver was developed based on BF537 0.2 HRM. In high system l=
oad, BUFRDERR error
> interrupt may be raised if XMTSERV interrupt of last TX byte is not s=
erved in time
> (set RSTART bit), which breaks restart tranfer as expected.
>
> "Buffer Read Error (BUFRDERR)" description in Blackfin HRM only apply=
s to BF537
> rev. < 0.3. In later rev. and later announced Blackfin chips, such as=
 BF527 and
> BF548, a new TWI master feature "Clock Stretching" is added into the =
TWI controller,
> BUFRDERR interrupt is not triggered after TX FIFO is empty.
>
> This patch sets RSTART bit at the beginning of the first transfer. Th=
e SCL and SDA
> is hold till XMTSERV interrupt of last TX byte is served. Restart tra=
nsfer is not broken
> in high system load.
>
> Reported-by: Lukas Weiss <lukas.weiss-o7FnQhZdtX+ELgA04lAiVw@public.gmane.org>
> Signed-off-by: Sonic Zhang <sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> ---
> =A0drivers/i2c/busses/i2c-bfin-twi.c | =A0 42 +++++++++++++++++++++--=
-------------
> =A01 files changed, 24 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i=
2c-bfin-twi.c
> index cbc98ae..5887ca4 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -99,7 +99,7 @@ static void bfin_twi_handle_interrupt(struct bfin_t=
wi_iface *iface,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (iface->cur_mode =3D=3D TWI_I2=
C_MODE_COMBINED)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_MASTER_CTL(iface=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_MA=
STER_CTL(iface) | MDIR | RSTART);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_MA=
STER_CTL(iface) | MDIR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (iface->manual_stop)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_MASTER_CTL(iface=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read_M=
ASTER_CTL(iface) | STOP);
> @@ -107,10 +107,10 @@ static void bfin_twi_handle_interrupt(struct bf=
in_twi_iface *iface,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iface->cur_msg + 1 < =
iface->msg_num) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (iface->pmsg[iface-=
>cur_msg + 1].flags & I2C_M_RD)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_=
MASTER_CTL(iface,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 read_MASTER_CTL(iface) | RSTART | MDIR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 read_MASTER_CTL(iface) | MDIR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_=
MASTER_CTL(iface,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (read_MASTER_CTL(iface) | RSTART) & ~MDIR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 read_MASTER_CTL(iface) & ~MDIR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (twi_int_status & RCVSERV) {
> @@ -130,17 +130,20 @@ static void bfin_twi_handle_interrupt(struct bf=
in_twi_iface *iface,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iface->transPtr++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iface->readNum--;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (iface->manual_stop) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_MASTER_CTL(iface,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_MA=
STER_CTL(iface) | STOP);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (iface->cur_mode =3D=3D TWI_I=
2C_MODE_REPEAT &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iface->cur_msg +=
 1 < iface->msg_num) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (iface->pmsg[iface->=
cur_msg + 1].flags & I2C_M_RD)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_M=
ASTER_CTL(iface,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 read_MASTER_CTL(iface) | RSTART | MDIR);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (iface->readNum =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (iface->manual_stop)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_=
MASTER_CTL(iface,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (read_MASTER_CTL(iface) | RSTART) & ~MDIR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 read_MASTER_CTL(iface) | STOP);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (iface->cur_m=
ode =3D=3D TWI_I2C_MODE_REPEAT &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
iface->cur_msg + 1 < iface->msg_num) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ifa=
ce->pmsg[iface->cur_msg + 1].flags & I2C_M_RD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 write_MASTER_CTL(iface,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 read_MASTER_CTL(iface) | MDIR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 write_MASTER_CTL(iface,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 read_MASTER_CTL(iface) & ~MDIR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (twi_int_status & MERR) {
> @@ -252,9 +255,10 @@ static void bfin_twi_handle_interrupt(struct bfi=
n_twi_iface *iface,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0(0xff << 6)));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iface-=
>manual_stop =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* remove restart bit a=
nd enable master receive */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_MASTER_CTL(iface,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_MA=
STER_CTL(iface) & ~RSTART);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* remove restart bit b=
efore last message */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (iface->cur_msg+1 =3D=
=3D iface->msg_num)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_M=
ASTER_CTL(iface,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 read_MASTER_CTL(iface) & ~RSTART);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iface->result =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_INT_MASK(iface, =
0);
> @@ -311,7 +315,8 @@ static int bfin_twi_do_master_xfer(struct i2c_ada=
pter *adap,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 iface->cur_mode =3D TWI_I2C_MODE_REPEAT;
> + =A0 =A0 =A0 if (iface->msg_num > 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iface->cur_mode =3D TWI_I2C_MODE_REPEAT=
;
> =A0 =A0 =A0 =A0iface->manual_stop =3D 0;
> =A0 =A0 =A0 =A0iface->transPtr =3D pmsg->buf;
> =A0 =A0 =A0 =A0iface->writeNum =3D iface->readNum =3D pmsg->len;
> @@ -356,6 +361,7 @@ static int bfin_twi_do_master_xfer(struct i2c_ada=
pter *adap,
>
> =A0 =A0 =A0 =A0/* Master enable */
> =A0 =A0 =A0 =A0write_MASTER_CTL(iface, read_MASTER_CTL(iface) | MEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (iface->msg_num > 1 ? RSTART : 0) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((iface->read_write =3D=3D I2C_SMBUS_R=
EAD) ? MDIR : 0) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((CONFIG_I2C_BLACKFIN_TWI_CLK_KHZ > 10=
0) ? FAST : 0));
> =A0 =A0 =A0 =A0SSYNC();
> @@ -520,7 +526,7 @@ int bfin_twi_do_smbus_xfer(struct i2c_adapter *ad=
ap, u16 addr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_MASTER_CTL(iface=
, 0x1 << 6);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Master enable */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_MASTER_CTL(iface, read_MASTER_CTL=
(iface) | MEN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_MASTER_CTL(iface, read_MASTER_CTL=
(iface) | MEN | RSTART |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((CONFIG_I2C_BLACKFIN_=
TWI_CLK_KHZ>100) ? FAST : 0));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0default:
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
