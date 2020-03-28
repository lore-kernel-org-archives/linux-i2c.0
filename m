From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/1] iio: imu: inv_mpu6050: convert to use
 i2c_new_client_device()
Date: Sat, 28 Mar 2020 15:13:10 +0000
Message-ID: <20200328151310.1dfd04a3@archlinux>
References: <20200326210955.12991-1-wsa+renesas@sang-engineering.com>
        <20200326210955.12991-2-wsa+renesas@sang-engineering.com>
        <MN2PR12MB44228DEA7CE19B853292FE38C4CC0@MN2PR12MB4422.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MN2PR12MB44228DEA7CE19B853292FE38C4CC0@MN2PR12MB4422.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 27 Mar 2020 10:52:02 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hello,
>=20
> thanks for the patch.
> Looks good for me.
>=20
> Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Applied to the togreg branch of iio.git and pushed out as testing.

Note this has missed the coming merge window.  Hope that doesn't matter for=
 your
deprecation plans.

Thanks,

Jonathan

>=20
> Best regards,
> JB
>=20
>=20
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> o=
n behalf of Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Sent: Thursday, March 26, 2020 22:09
>=20
> To: linux-i2c@vger.kernel.org <linux-i2c@vger.kernel.org>
>=20
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>; Jonathan Cameron <ji=
c23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars=
@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; linux-iio@vger.ke=
rnel.org <linux-iio@vger.kernel.org>;
>  linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
>=20
> Subject: [PATCH 1/1] iio: imu: inv_mpu6050: convert to use i2c_new_client=
_device()
>=20
> =C2=A0
>=20
>=20
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
>=20
>=20
> Move away from the deprecated API and return the shiny new ERRPTR where
>=20
> useful.
>=20
>=20
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> ---
>=20
> =C2=A0drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 8 +++++---
>=20
> =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>=20
>=20
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_acpi.c
>=20
> index 2f8560ba4572..c27d06035c8b 100644
>=20
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
>=20
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c
>=20
> @@ -135,6 +135,7 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client =
*client)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st->mux_client =3D NULL;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ACPI_HANDLE(&client-=
>dev)) {
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct i2c_board_info info;
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct i2c_client *mux_client;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct acpi_device *adev;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D -1;
>=20
> =C2=A0
>=20
> @@ -172,9 +173,10 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client=
 *client)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =
else
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0; /* no secondary add=
r, which is OK */
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 st->mux_client =3D i2c_new_device(st->muxc->adapter[0], &info);
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (!st->mux_client)
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 mux_client =3D i2c_new_client_device(st->muxc->adapter[0], &in=
fo);
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 if (IS_ERR(mux_client))
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR=
(mux_client);
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 st->mux_client =3D mux_client;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>=20
