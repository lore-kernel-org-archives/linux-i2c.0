From: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c-pnx: fix setting start/stop condition
Date: Mon, 1 Mar 2010 15:13:12 +0100
Message-ID: <acd2a5931003010613v4b0f7666ua47e19d72921c151@mail.gmail.com>
References: <1267446264-8446-1-git-send-email-l.fu@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1267446264-8446-1-git-send-email-l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>, Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 1, 2010 at 1:24 PM, Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> The start/stop condtions are set in different places repetedly in the=
 i2c-pnx
> driver. =A0Beside in i2c_pnx_start and i2c_pnx_stop the start/stop bi=
t are also
> set during the transfer of a i2c message in the master_xmit/rcv calls=
=2E This is
> wrong since we can't set the start/stop condition during the transact=
ion of a
> single message any way. As a matter of fact, the driver will sometime=
s set both
> the start and the stop bits at one time. This can be easily reproduce=
d by
> sending a simple read request like e.g
> struct i2c_msg msgs[] =3D {
> { addr, 0, 1, buf },
> { addr, I2C_M_RD, offset, buf }
> };
> While processing the first message the i2c_pnx_master_xmit will set b=
oth the
> start_bit and the stop_bit, which will eventually confuse the slave.
>
> Fixed by remove setting start/stop condition from the transmit routin=
es.
>
> Signed-off-by: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Acked-by: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
