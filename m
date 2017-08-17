From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i801: Allow ACPI SystemIO OpRegion to conflict
 harder
Date: Thu, 17 Aug 2017 21:48:58 +0200
Message-ID: <20170817194858.znjttvqq662agwk2@ninjato>
References: <20170626204009.32607-1-lyude@redhat.com>
 <20170812111507.rxc7lzc6f7uoqlt2@ninjato>
 <1502726770.489.0.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="agqwtvhk2v3qtsjr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502726770.489.0.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: intel-gfx@lists.freedesktop.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Benjamin Tissoires <btissoir@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jean Delvare <jdelvare@suse.de>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--agqwtvhk2v3qtsjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > Signed-off-by: Lyude <lyude@redhat.com>
> >=20
> > No full name? Or is it your full name?
> Looks like I forgot to change my desktop's S-B identity to full name,
> but it shouldn't be a big deal. I've got tons of other patches already
> upstream like this.

I'd much prefer a full name. But more importantly, what I definately
need is some review/ack/whatever because I don't know enough about this
stuff (other than knowing it is a fragile area).

Maybe you could resend with full name and the acpi list on CC?

Regards,

   Wolfram


--agqwtvhk2v3qtsjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmV8yoACgkQFA3kzBSg
KbYkAw/9FcC8NmQoweSRUsbAdL7qNlQy+9Y/4vqJojsn43o4Oay41F5NOJRxnMON
3Ky6yhmUOf3W8P+5TTqQ4P3dmEYnbJv5zmjX+6sVMFvkoi+ZQmnFw/tm7nRGGNxQ
nKj3ZQaM/3tHn6w0TypDCXge3Gshij87Mel9ks1bmZSRHVas9ki+hFsFOs1tRsGM
pONXiuWp+k/dcLVAOKMiS3Ieyl2i0+sHZIhgsS9DaY7lQbVCcgH//0+9M6vVYehb
fwr3n4WNs6IFYlrNdxQcXQqg5x/vg8w+L+xaYcLr+IcgNK/8/HcVQiNmyJMVxOTd
HaN9eKS1q1OahBQb6+YAW+ynJv+IMJ1xr7sifkDA0neYk0mwJGvP2Bu5yNIb/aQV
gOwyTevwsNeoq6vf2kGqw6U+bzGpplAYVmww1geTn7ilzdtGnEqoOza9yZvuxdV2
LykKgr93/9mmnh7Ksr5tPLWu+63O8bdNywvmDldfFDd3WFtck3WzcyrueO16AAiu
1XfyrJDA8Rp2oNuGtid9wwkkBHdSUh9njhLT7Z4Huh4Qm2eJaUWmdzqu5IyKeLTm
JqQB04t9fVQNk6UiCUE+ovrvpo7wQ8y1B9O3B6Dt2L6SajT9OYCxzs/q4qk3WX3x
iOALYzat7+fzeycdoRnSL+RS9QBCroEycVBE6FH/sLHgramBZW0=
=c5e0
-----END PGP SIGNATURE-----

--agqwtvhk2v3qtsjr--
