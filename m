From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: davinci: Increase module clock frequency
Date: Mon, 30 Nov 2015 16:02:37 +0100
Message-ID: <20151130150236.GL1513@katana>
References: <564DBEE3.4030508@nokia.com>
 <20151130135504.GE1513@katana>
 <565C566C.7000809@nokia.com>
 <20151130141054.GG1513@katana>
 <565C6254.6080602@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2EnvhqpWJq810sZn"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33234 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754135AbbK3PCm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 30 Nov 2015 10:02:42 -0500
Content-Disposition: inline
In-Reply-To: <565C6254.6080602@nokia.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-i2c@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>


--2EnvhqpWJq810sZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 30, 2015 at 03:51:00PM +0100, Alexander Sverdlin wrote:
> I2C controller used in Keystone SoC has an undocumented peculiarity which
> results in SDA-SCL margins being dependent on module clock. Driving high
> capacity bus near its limits can result in STOP condition sometimes being
> understood as REPEATED-START by slaves (or NACK instead of ACK, etc...).
> Driving the module with higher clocks increases the margin between SDA an=
d SCL
> transitions, making the operations with higher bus rates more robust. The=
refore,
> target the module clock to 12MHz instead of 7MHz, still staying within
> the specification limits.
>=20
> Before the change STOP timing looked like this on 400kHz:
>=20

Applied to for-current and added stable, thanks!


--2EnvhqpWJq810sZn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXGUMAAoJEBQN5MwUoCm2b5cP/3llZ1XddAG7S/56WqnFwIcs
74cfYtCZOLJABBVLPMIBS4L42BEe/Qh5mdG/LNv8rYbKeI0axRYDrVXzfonsRzf6
TebO5+zCbX4tJ4u2+Arc6nk+ao9NgqE3zHcLP+aBjIpMckI8DQ6+Iyd+t3FMRxc3
99Pp8+PyGLwxc8qapuqGHRDBADDb1GVasVDpwRAA1yljvoxMn0rtwRw62JcyhVzQ
cAIUUcM41fpnupQp3vstlTWkiGEgdLXBiI6QJ+oRjSYNSs/idmO2dkZwLpku45yW
AMJoDHadeK8MaZFns637J+0zXltDzX5DGRCMISt5Es73E6g1b6Zw0Ag/T8FYalSQ
sIQA9OJyrclsoHvPicziixX7GrLJiryzCLCJWuNiyGPElBQuwTbeQI3PPKCvEV6l
haIN6WfCULpx/9nyEP/gEecFnxGn4LTV6Yg5frmNDoHmqXC9gZyAj5G2OAWCSeo/
pCJOZEMRKj5rPjPXXsVB79lNxzOX4PwhgTnlmM0n/eMJGOS59b7ZFkqlODlKQB1o
ipxgX5ecciOIb4zp/NrHnwmpBG0YtEivqT6E4OMM9DMc7mQbIFuRWQWZvmFnfL8Q
Z6FXlwRHLum/2NtPVMW/SaqCgdvjeDQSEsOeC4zey5MGnNt0Mfu0V8VeGLqvFi2m
a8pBiOezvuPdBXVaeUsz
=5pEU
-----END PGP SIGNATURE-----

--2EnvhqpWJq810sZn--
