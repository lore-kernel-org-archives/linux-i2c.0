From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [v5] i2c: i801: Allow ACPI SystemIO OpRegion to conflict with PCI BAR
Date: Tue, 5 Jul 2016 14:00:58 +0200
Message-ID: <201607051400.58881@pali>
References: <1463990658-53854-1-git-send-email-mika.westerberg@linux.intel.com> <20160705115142.GO23527@lahna.fi.intel.com> <201607051356.58794@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1909955.LTGQxUU7rS";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38204 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226AbcGEMBB (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 5 Jul 2016 08:01:01 -0400
In-Reply-To: <201607051356.58794@pali>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jean Delvare <jdelvare@suse.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Matt Fleming <matt@codeblueprint.co.uk>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org

--nextPart1909955.LTGQxUU7rS
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 05 July 2016 13:56:58 Pali Roh=C3=A1r wrote:
> On Tuesday 05 July 2016 13:51:42 Mika Westerberg wrote:
> > So are you able to test what happens when you unload the driver?
>=20
> As I wrote in previous email, I do not own these EliteBooks anymore,
> so cannot test it. Just have DSDT dump...

What about contacting last contributors to hp_accel.c driver? They=20
probably could test i801 changes if accelerometer still works.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1909955.LTGQxUU7rS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAld7oXoACgkQi/DJPQPkQ1I5PgCfSoSZe3Wvpxghss8D5v8UBUnf
k0kAoImwocIdWeKWmi0/spLXVDB+nUAJ
=lDIV
-----END PGP SIGNATURE-----

--nextPart1909955.LTGQxUU7rS--
