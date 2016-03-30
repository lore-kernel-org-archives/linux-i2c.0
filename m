From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: prevent endless uevent loop with
 CONFIG_I2C_DEBUG_CORE
Date: Wed, 30 Mar 2016 14:23:01 +0200
Message-ID: <20160330122300.GB9329@katana>
References: <1458762422-30079-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43015 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbcC3MXG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 30 Mar 2016 08:23:06 -0400
Content-Disposition: inline
In-Reply-To: <1458762422-30079-1-git-send-email-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jan Glauber <jglauber@cavium.com>, Alexander Sverdlin <alexander.sverdlin@nokia.com>


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 23, 2016 at 08:47:02PM +0100, Wolfram Sang wrote:
> Jan reported this:
> =3D=3D=3D
> After enabling CONFIG_I2C_DEBUG_CORE my system was broken
> (no network, console login not possible). System log was
> flooded with the this message:
>=20
>  ...
> [  608.052077] rtc-ds1307 0-0068: uevent
> [  608.052500] rtc-ds1307 0-0068: uevent
> [  608.052925] rtc-ds1307 0-0068: uevent
>  ...
>=20
> The culprit is the dev_dbg printk in the i2c uevent handler.
> If this is activated (for instance by CONFIG_I2C_DEBUG_CORE)
> it results in an endless loop with systemd-journald.
>=20
> This happens if user-space scans the system log and reads the uevent
> file to get information about a newly created device, which seems fair
> use to me. Unfortunately reading the "uevent" file uses the same
> function that runs for creating the uevent for a new device,
> generating the next syslog entry.
>=20
> Ideally user-space would implement a recursion detection and
> after reading the same device file for the 1000th time call it a
> day, but nevertheless I think we should avoid this problem by
> removing the debug print completly or using another print variant.
>=20
> The same problem seems to be reported here:
> https://bugs.freedesktop.org/show_bug.cgi?id=3D76886
> =3D=3D=3D
>=20
> His patch converted the message to pr_debug, but I think the debug can
> simply go. We have other means to see code paths these days. This
> enables us to clean up the function some more while we are here.
>=20
> Reported-by: Jan Glauber <jglauber@cavium.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Tested-by: Jan Glauber <jglauber@cavium.com>

Applied to for-current, thanks!


--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW+8UkAAoJEBQN5MwUoCm2UucP+gJm9ABApsKoZG3FOwLjChU5
okmcQlLK+9LIb8MHpmqNqvtc0ngZMoFrP3vMzDTziKMTWWV7LcYaXPiKfsHj3TeD
mHgrudDWQobwwR/Dg1+nBU2Zxb78H1DkVyeNpFI1RCauFf2wKyYw1yqUucau6Ja9
pmaMemqszxjzNxWgIgKOYQ62UX6G9xopN7MyGzhhH2q/LtBusyheKS1BtoXJDzNr
L7gRiAFYxLSuz+Dq0afrs4nbhSwWBMRZ87qdvQExYGTflqMFkebbsQrrAMjio2ky
t/FeoDZ1EdpDgwbz3AqYGjuFbL1FxOzAlxjbanm4h9cEoNU8hdWe7sTLLDo7lB1V
yUutpqayYVK1E2Ul+zML+wsa5UIwmBp3wYbRQuuRR8zo0WFrWpvtjh6rrFMjjpZv
FncvZdF86NfpXnGiTRG/N0vqynxtFixSC3CSg1j/pEwdxMDo5EZtme3YClPhJG6s
3PrRNdjksMCBSHB6V+BcjQnZkAEIsQOnESdALhKpnqb3EEY0LHbOwSzfw11PrJJ7
ws6F3e0ngqvJcYvfAXTkIk3POFXhn4o7iUtkdQ6MGlsJFubTk2wI0bTPbAiYT8Kz
ciCsXDtIfPuKc71RsMqzjUnWsMZflXNzm3kJBlNaFg7Hx+6HIOaprss+KVkuHHT0
mu3d8Czd9K/3vwaCdYaW
=fthS
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
