From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 00/13] coordinate cht i2c-pmic and i915-punit accesses
Date: Wed, 25 Jan 2017 21:18:27 +0100
Message-ID: <20170125201827.b62oukjbrmvoup3s@ninjato>
References: <20170123210958.18410-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sinojexjuqo2e236"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38588 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbdAYUSc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 25 Jan 2017 15:18:32 -0500
Content-Disposition: inline
In-Reply-To: <20170123210958.18410-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org


--sinojexjuqo2e236
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> So the plan (again with Wolfram's ack) is for all these patches
> including the i2c-designware ones to go upstream through the drm-intel
> tree, to avoid an intermediate state were things don't work.

Yes. I'd just like to pull in an immutable branch into my i2c/for-next
once this series is accepted.


--sinojexjuqo2e236
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliJCAQACgkQFA3kzBSg
KbYlfQ/+MxrrDqSselibXLjiEi0KHJrt90celf7V94Cek2ZBfdEmyoWRX7y+I4p+
QNRoc8SAScW7OfnFsaQM+S8i8Fgl71q0kPcUUPvgm/61X5gQNv3TYHjUdC4iB6i0
f1jnEW9ApbymonfR/y15rJb4Vv/Oz0FlQ6KRJHjC0id/P0wP6GNHQwx81AyI8Vns
z5kqn7T6PLBL+CrWAZfFknipS5OiDZwHCyhbn99tjWL2AYLQrsvVTrhD38iOImXA
3UPNyW6QP+Tcw1U/H72Q2tcBsW+xQ8VKCNZ3vFUJ3OZ2v9LwryqNj7hQxoXhEWiq
tVFjCwzToHyzt49YKbevZNeR0Fx7CwjZ6x/Mk8QHdtkRjvmSny4MU3+s6IdHvH54
N+UDvMe8r2mLyr9rk1jE08a/O5LXFwc3gzqmJXm7rd7QxjsuOzMrx+kuomqn9hkK
daME7JrjSQLYVQ1O8pdQY6k7UsqfGiwkqwDMzZIt3J9No/DjSOFLbnvZmv4b+xe+
JAQzDQK8b7WHD/RS5Pa9OUg4ky8aUxAwCvsAPIJovc/Wt/Tug08hBWz0vpDjD+5V
f3Q61yYdiC6Xl/uyiVQWjQXLesPxUFdnvBtlZxVnTsyxtc0LXt9/Zela+lw0lgMF
qoQZ2HBs2n5YukvBbGmsDVuPCQd0OXXuD0xw95bgUnq9z4J67m8=
=Y5R5
-----END PGP SIGNATURE-----

--sinojexjuqo2e236--
