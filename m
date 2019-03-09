From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: cadence: try reset when master receive
 arbitration lost
Date: Sat, 9 Mar 2019 10:44:52 +0100
Message-ID: <20190309094452.GB1340@kunai>
References: <20190219012447.5900-1-sxauwsk@163.com>
 <20190223094842.GF1018@kunai>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1919300266985989102=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190223094842.GF1018@kunai>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shikai Wang <sxauwsk@163.com>
Cc: linux-kernel@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--===============1919300266985989102==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Content-Disposition: inline


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2019 at 10:48:43AM +0100, Wolfram Sang wrote:
> On Tue, Feb 19, 2019 at 09:24:47AM +0800, Shikai Wang wrote:
> > When the adapter receive arbitration lost error interrupts,
> > cdns_i2c_master_xfer return to the caller directly instead of resetting
> > the adapter which resulted in the adapter being out of control.
> >=20
> > So when driver detect err_status such as arbitration lost,
> > then try to repair and fix it.
>=20
> Just checking because resetting looks like a big hammer to me: there is
> no way to gracefully recover form 'arbitration lost' interrupt?

I am still wondering about this but since it is acked by the maintainer:

Applied to for-current, thanks!


--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlyDixQACgkQFA3kzBSg
KbZoDw//dfwpM+U7L54v9ts0GdpP/4y51a7yCJmrs40qEaLaK/8v04JW8o0/4UaR
K6YHGGT7EYLcs/eYleYQh9Pyjzj5RdxlnPcMHjUrWFCt0P+z1m0b4yJQpRoYbIH1
a+BHvWoddxJ/U+McGLHqoBHXh7NX2J5wMVdNjh+e46Lxvt3i3KMsJzNDY5XsRpA1
i0PiyhZ3P1THw+X7DRYxIOptqXpjXWEuRKoNDjG/SN5eTPFzsyCV6F/WBqhQZ2T8
SU8+XbxrDIuy/eh0WwPp2kl4UWLAtxb/ZEsD5alVzWBcLOVVnJ6cayIEeSmrCelh
djmNwN9PEP128vtoWYaHY74MgStj4X4IDVpJOSUYTsJMwMzQwEjVeHwVwZr9nmsv
S0c33NsSJwQJB7SpgET+j9JWaALGmSZLB0G7gyOPTNVXcPWmNn9X88ul61xIKIba
Au7pTg9fokkNMi6yWPosaKRVXO4RDc28xbp3rz9B0NhKBi28l4Bkwx4bOo0ydX7e
ho+QCENy7Dk4EkcXR6s4THiywDdNj2sKsQnMhRKNvqeMKf3sA/O0W+loUXE3oF4j
hhvAG8eLsUtnQlDwNnI/WK0c8cnr/PZaiCeBu7nkxBWiECX8+YU8Bw4WKFKUFDPD
rjGK0/8X96kgadurkDZJ5jg9QRcjX7GTf7UMgIC3M7gKsrQCZ4A=
=eNxl
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--


--===============1919300266985989102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1919300266985989102==--
