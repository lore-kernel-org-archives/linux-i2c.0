From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: Issues with touchpad / touchscreen on yoga 900
Date: Thu, 29 Oct 2015 19:30:33 +0100
Message-ID: <20151029183032.GA8992@katana>
References: <20151029112913.1036f00b@voldemort.scrye.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52144 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbbJ2Sak (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 29 Oct 2015 14:30:40 -0400
Content-Disposition: inline
In-Reply-To: <20151029112913.1036f00b@voldemort.scrye.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kevin Fenzi <kevin@scrye.com>
Cc: linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2015 at 11:29:13AM -0600, Kevin Fenzi wrote:
> Greetings.=20
>=20
> I'm having problems with a lenovo yoga 900 not seeing it's touchscreen
> or touchpad.=20
>=20
> Downstream bug:=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1275718
>=20
> The problem parts of dmesg seem to be:=20
>=20
> Oct 26 15:20:08 localhost kernel: i2c_designware i2c_designware.1: i2c_dw=
_handle_tx_abort: lost arbitration
> Oct 26 15:20:08 localhost kernel: i2c_hid i2c-SYNA2B29:00: hid_descr_cmd =
failed
> Oct 26 15:20:08 localhost kernel: i2c_designware i2c_designware.2: i2c_dw=
_handle_tx_abort: lost arbitration
> Oct 26 15:20:08 localhost kernel: i2c_hid i2c-ELAN21EF:00:
> hid_descr_cmd failed
>=20
> This is with 4.3.0-0.rc7.git1.1.fc24.x86_64 (post rc7 4.3.0).
>=20
> Happy to gather further info or try patches. ;)=20

Ccing more people...


--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWMmXIAAoJEBQN5MwUoCm2xRgP/Rmbg05l15eT5AfIb+kjsHIm
hZvVlMiGF47Jqtg9FMyp+KheQ/3DT2zeqiBEK1jDpdIK3tWZjXYK68odri2S0nMj
l/MhlOwgAPRoiVtj/cXhQIUANxnn2kZET6C/+E50mxJN0UOafVI54GBBfXn7Da1n
qMINn+voSTsyV1Vv+fcrmhnK7zlSwGi4ArZ8MLGXry/Zo8yUzPXijTdiuVdHSuE4
8oPIo5NmBZO31CNfCUrEU1+HoAmOJIEIZ9PQf/OUYR2OBn2uvnIio+PxfxlPTePT
k7BCw7gI4WATdfjoGlHUPVNTsW23LfWeZw4O0dXE2VgLSb1EZ7ndQAVApHBQqINO
ivvidWGvQAwStbAi6MmaxtDILyGTGNjbmpgTLZNCJRVeyPQlRI4cej31MYZlERqa
+7hPk+OWcRNjTldlmBbhBAPNY3pq0tXnqBqz3Nui6e9tv9Z/gd5XN9GIzT7C/mhP
dMnJV+lxTzQkp2iQyQbtHvExGudztoQttN+kt/9eKpm3ayGPrduIClUfaWMXoWOm
N/3M02uVLDRmx6LIiGEA+FXRxWdZn1FVb0FDRU7vdsWSmcBk+v4EKb7zTIHcmChK
m6K1/Tx5O5BmmqGy+1fvQQQcMKtvEPOYUwbjT0GrfqXzujTbqAgBMy3QFlQMlCxU
uzOZKTXoRzXGWzEwo1OR
=a57O
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
