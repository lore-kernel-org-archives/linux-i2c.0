From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 6/6] Cleanup
Date: Mon, 28 Jan 2013 19:40:07 +0100
Message-ID: <20130128194007.3d3c0d4d@endymion.delvare>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
	<1357305215-17643-1-git-send-email-amaury.decreme@gmail.com>
	<1357305215-17643-7-git-send-email-amaury.decreme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357305215-17643-7-git-send-email-amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amaury =?ISO-8859-1?B?RGVjcuptZQ==?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri,  4 Jan 2013 14:13:35 +0100, Amaury Decr=EAme wrote:
> This patch corrects checkpatch errors.
> Some "80 columns" warnings have been expressly omitted to keep readin=
g
> easy.

You can get rid of these too by splitting the affected lines. You do
not have to split the strings themselves, but the other parameters can
be on different lines. checkpatch.pl will be silent once you get this
right.

> The changes has also been removed as it has less meaning with version
> control tools.
>=20
> Signed-off-by: Amaury Decr=EAme <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-sis630.c |  175 ++++++++++++++++++-----------=
----------
>  1 files changed, 82 insertions(+), 93 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-sis630.c b/drivers/i2c/busses/i2c=
-sis630.c
> index 4bc970d..ff08dde 100644
> --- a/drivers/i2c/busses/i2c-sis630.c
> +++ b/drivers/i2c/busses/i2c-sis630.c
> @@ -16,24 +16,6 @@
>      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>  */
> =20
> -/*
> -   Changes:
> -   24.08.2002
> -   	Fixed the typo in sis630_access (Thanks to Mark M. Hoffman)
> -	Changed sis630_transaction.(Thanks to Mark M. Hoffman)
> -   18.09.2002
> -	Added SIS730 as supported.
> -   21.09.2002
> -	Added high_clock module option.If this option is set
> -	used Host Master Clock 56KHz (default 14KHz).For now we save old Ho=
st
> -	Master Clock and after transaction completed restore (otherwise
> -	it's confuse BIOS and hung Machine).
> -   24.09.2002
> -	Fixed typo in sis630_access
> -	Fixed logical error by restoring of Host Master Clock
> -   31.07.2003
> -   	Added block data read/write support.
> -*/
> =20

You can delete one more blank line.

>  /*
>     Status: beta
> @@ -150,9 +132,10 @@ static inline void sis630_write(u8 reg, u8 data)
>  	outb(data, smbus_base + reg);
>  }
> =20
> -static int sis630_transaction_start(struct i2c_adapter *adap, int si=
ze, u8 *oldclock)
> +static int sis630_transaction_start(struct i2c_adapter *adap, int si=
ze,
> +								u8 *oldclock)
>  {
> -        u8 temp;
> +	u8 temp;

This doesn't apply as the change is already present in a previous patch=
=2E

> =20
>  	/* Make sure the SMBus host is ready to start transmitting. */
>  	temp =3D sis630_read(SMB_CNT);
> (...)

All the rest looks good, thanks for doing that.

--=20
Jean Delvare
