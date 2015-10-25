From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH-RESEND 0/3] i2c: core/pxa: Add support for hardware lock
Date: Sun, 25 Oct 2015 10:52:00 +0100
Message-ID: <20151025095200.GE2159@katana>
References: <vaibhav.hiremath@linaro.org>
 <1433270731-23790-1-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:44978 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbbJYJwF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sun, 25 Oct 2015 05:52:05 -0400
Content-Disposition: inline
In-Reply-To: <1433270731-23790-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2015 at 12:15:28AM +0530, Vaibhav Hiremath wrote:
> To justify the need for hardware lock, lets take a real usecase scenario -
>    =20
> In case of Marvell SoC, PXA910 silicon, both AP and CP are present and
> these two ARM cores are sharing one pair of I2C pins.
>    =20
> In order to keep I2C transaction operated with atomic, hardware lock
> (RIPC) is required.
>    =20
> This patch extends support for atomic operation by adding hardware lock s=
upport
> to the i2c-core.
>=20
> PATCH[1/3] : Core changes for hardware lock
> PATCH[2/3 & 3/3] : hardware lock support to i2c-pxa bus driver.

Why don't you use the hwspinlock subsystem?


--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLKZAAAoJEBQN5MwUoCm25GIP/2nS9QDrJS3uHfepXy7kTOx/
D4ExtjhULSy6lSdBA0DzsHrVta5buAEEFnFyJBSmBWrENE29C6YD43oPdrvZaREg
kHXVZMrAp0mooknTgP8FiVvnMwQC7Gru2jVl4WiHNAZGDNyG5iYQ/aKWXqwc7Jww
GkSQO/oaWwQVae+Zx+F5ec5c/z++mYx6/sbyA1x6TmaTopbpGbA968D1EU1fNKgj
lfUhI3jX+1WRS4YyPB33/vDSus04ygMkVDNWNhq5S2OTsPjSLDqiV0V1bdbEcJJe
d5l/O5kF9at0pe4RbqZvFBSM+ANHgJ31X9eCpcARwjKyfONt+F60wUZdPFh7f3gA
ctrOQTi5UM6T2BVQ3QfCym49LCO53nXBhNrXWOf+j6zQaPCorWEF8inbfxD6ZpwG
NNACjJhM6Bvd+fT+vv98ZccOSruCPtjWf6k7RJgkyKz3oa7VvsMvkuTDC4INnfQF
FOdlaXPoDhNShWpg8+zB3mtiSbNHXhfQ1QY93ob3kFC4n1inMMi53ab4QxhZ5gfS
rFO83QBlsbb77ltukyMYBWzq5QxxCsfmKqu6Y5fTdbPTrthndc6RA3LZb8KKJm/h
9c+PgatHbHEZ8YhlEZNmjFwBgTbNTAIqtMj9yz2MIsiuKXkSAu9BsJENeXRtp49x
d5D3JOZ+v3I8eRmHZrhD
=8w5p
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
