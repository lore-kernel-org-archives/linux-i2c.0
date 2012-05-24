From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH 1/8] i2c: i2c-bfin-twi: Illegal i2c bus lock upon certain
 transfer scenarios.
Date: Thu, 24 May 2012 17:17:27 +0800
Message-ID: <CAJxxZ0MyEFfs9MT8ffZroUXtxsZ2ftd2Zky4ktywF4yeD9__nw@mail.gmail.com>
References: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337152826-9850-1-git-send-email-sonic.zhang@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sonic.zhang@analog.com
Cc: Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>
List-Id: linux-i2c@vger.kernel.org

PING


On Wed, May 16, 2012 at 3:20 PM,  <sonic.zhang@analog.com> wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
>
> For transfer counts > 255 bytes i2c-bfin-twi sets the data
> transfer counter DCNT to 0xFF indicating unlimited transfers.
> It then uses a flag iface->manual_stop to manually issue the STOP
> condition, once the required amount of bytes are received.
>
> We found that on I2C receive operation issuing the STOP condition
> together with a FULL RCV FIFO (2bytes) will cause SDA and SCL be
> constantly driven low.
>
> Temporary workaround until further investigation:
> Discard the RCV FIFO before issuing the STOP condition.
>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
>
> git-svn-id: svn://localhost/svn/linux-kernel/trunk@9011 526b6c2d-f592=
-4532-a319-5dd88ccb003d
> ---
> =A0drivers/i2c/busses/i2c-bfin-twi.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i=
2c-bfin-twi.c
> index cdb59e5..e6dd3c9 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -131,6 +131,10 @@ static void bfin_twi_handle_interrupt(struct bfi=
n_twi_iface *iface,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iface->transPtr++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iface->readNum--;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (iface->manual_stop) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Avoid possible bus s=
tall -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Flush FIFO before =
issuing the STOP condition
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_RCV_DATA16(iface);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0write_MASTER_CTL(iface=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0read_M=
ASTER_CTL(iface) | STOP);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (iface->cur_mode =3D=3D TWI_=
I2C_MODE_REPEAT &&
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
