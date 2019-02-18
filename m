From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH] i2c: cadence: try reset when master receive arbitration
 lost
Date: Mon, 18 Feb 2019 10:30:36 +0100
Message-ID: <3ed0ec78-907b-f0ec-7f5a-b54eb34e432c@monstr.eu>
References: <20190218083522.4681-1-sxauwsk@163.com>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4670512523844337799=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190218083522.4681-1-sxauwsk@163.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: sxauwsk <sxauwsk@163.com>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============4670512523844337799==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hhuTRlIR5TG8GRsPOIb0kPLKQv3Evob59"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hhuTRlIR5TG8GRsPOIb0kPLKQv3Evob59
Content-Type: multipart/mixed; boundary="ESxpEaEOdf4sdLwoxdv608fHGeC8F8DJo";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: sxauwsk <sxauwsk@163.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: linux-kernel@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
 linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
Message-ID: <3ed0ec78-907b-f0ec-7f5a-b54eb34e432c@monstr.eu>
Subject: Re: [PATCH] i2c: cadence: try reset when master receive arbitration
 lost
References: <20190218083522.4681-1-sxauwsk@163.com>
In-Reply-To: <20190218083522.4681-1-sxauwsk@163.com>

--ESxpEaEOdf4sdLwoxdv608fHGeC8F8DJo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

On 18. 02. 19 9:35, sxauwsk wrote:
> When the adapter receive arbitration lost error interrupts,
> cdns_i2c_master_xfer return to the caller directly instead of resetting=

> the adapter which resulted in the adapter being out of control.
>=20
> So when driver detect err_status such as arbitration lost,
> then try to repair and fix it.
>=20
> Signed-off-by: sxauwsk <sxauwsk@163.com>

Can you please fix your name here? And also in subject.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs



--ESxpEaEOdf4sdLwoxdv608fHGeC8F8DJo--

--hhuTRlIR5TG8GRsPOIb0kPLKQv3Evob59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlxqez8ACgkQykllyylKDCESLgCcCUixywnhPhCNyTZ5U1vIJOrv
u/kAn1OSGcnXk7UV3Uad9OKI3Lrs7YF8
=xrVy
-----END PGP SIGNATURE-----

--hhuTRlIR5TG8GRsPOIb0kPLKQv3Evob59--


--===============4670512523844337799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4670512523844337799==--
