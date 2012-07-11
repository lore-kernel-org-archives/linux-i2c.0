From: Richard =?ISO-8859-1?Q?R=F6jfors?=
	<richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Subject: Re: [PATCH 3/4] V4L/DVB: mfd: use reg_shift instead of regstep
Date: Wed, 11 Jul 2012 23:09:40 +0200
Message-ID: <1342040980.3798.1.camel@rorics.office.pelagicore.net>
References: <1341900658-7698-1-git-send-email-jayachandranc@netlogicmicro.com>
	 <1341900658-7698-4-git-send-email-jayachandranc@netlogicmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341900658-7698-4-git-send-email-jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 2012-07-10 at 11:40 +0530, Jayachandran C wrote:
> Update for change in i2c-ocores.h which uses reg_shift to
> specify the register offset shifts instead of regstep.
>=20
> Signed-off-by: Jayachandran C <jayachandranc-oSioyQM9ZPnuBjGU1YDckgC/G2K4zDHf@public.gmane.org>

Looks good to me.

Acked-by: Richard R=C3=B6jfors <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>

> ---
>  drivers/mfd/timberdale.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
> index 0ba26fb..a447f4e 100644
> --- a/drivers/mfd/timberdale.c
> +++ b/drivers/mfd/timberdale.c
> @@ -83,7 +83,7 @@ timberdale_xiic_platform_data =3D {
> =20
>  static __devinitdata struct ocores_i2c_platform_data
>  timberdale_ocores_platform_data =3D {
> -	.regstep =3D 4,
> +	.reg_shift =3D 2,
>  	.clock_khz =3D 62500,
>  	.devices =3D timberdale_i2c_board_info,
>  	.num_devices =3D ARRAY_SIZE(timberdale_i2c_board_info)
