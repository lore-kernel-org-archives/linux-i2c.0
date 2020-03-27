From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: Re: [PATCH 1/1] iio: imu: inv_mpu6050: convert to use
 i2c_new_client_device()
Date: Fri, 27 Mar 2020 10:52:02 +0000
Message-ID: <MN2PR12MB44228DEA7CE19B853292FE38C4CC0@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200326210955.12991-1-wsa+renesas@sang-engineering.com>,<20200326210955.12991-2-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:24418 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbgC0Kw2 (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 27 Mar 2020 06:52:28 -0400
In-Reply-To: <20200326210955.12991-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello,=0A=
=0A=
thanks for the patch.=0A=
Looks good for me.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Wolfram Sang <wsa+renesas@sang-engineering.com>=0A=
=0A=
Sent: Thursday, March 26, 2020 22:09=0A=
=0A=
To: linux-i2c@vger.kernel.org <linux-i2c@vger.kernel.org>=0A=
=0A=
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>; Jonathan Cameron <jic2=
3@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@m=
etafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; linux-iio@vger.kern=
el.org <linux-iio@vger.kernel.org>;=0A=
 linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>=0A=
=0A=
Subject: [PATCH 1/1] iio: imu: inv_mpu6050: convert to use i2c_new_client_d=
evice()=0A=
=0A=
=A0=0A=
=0A=
=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
Move away from the deprecated API and return the shiny new ERRPTR where=0A=
=0A=
useful.=0A=
=0A=
=0A=
=0A=
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>=0A=
=0A=
---=0A=
=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c | 8 +++++---=0A=
=0A=
=A01 file changed, 5 insertions(+), 3 deletions(-)=0A=
=0A=
=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_acpi.c=0A=
=0A=
index 2f8560ba4572..c27d06035c8b 100644=0A=
=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c=0A=
=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_acpi.c=0A=
=0A=
@@ -135,6 +135,7 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *c=
lient)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 st->mux_client =3D NULL;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (ACPI_HANDLE(&client->dev)) {=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct i2c_board_info info=
;=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct i2c_client *mux_client;=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct acpi_device *adev;=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret =3D -1;=0A=
=0A=
=A0=0A=
=0A=
@@ -172,9 +173,10 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *=
client)=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } =
else=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 return 0; /* no secondary addr, which is OK */=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->mux_client =3D i2c_new_devi=
ce(st->muxc->adapter[0], &info);=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->mux_client)=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
-ENODEV;=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mux_client =3D i2c_new_client_d=
evice(st->muxc->adapter[0], &info);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (IS_ERR(mux_client))=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return =
PTR_ERR(mux_client);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->mux_client =3D mux_client;=
=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
=A0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
-- =0A=
=0A=
2.20.1=0A=
=0A=
=0A=
=0A=
