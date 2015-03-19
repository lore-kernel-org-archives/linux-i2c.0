From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Thu, 19 Mar 2015 22:39:37 +0100
Message-ID: <20150319213937.GA899@katana>
References: <20150205002630.GA396@roeck-us.net>
 <20150205144028.GA4865@katana>
 <20150205175326.GA26691@roeck-us.net>
 <20150212040126.GA1691@roeck-us.net>
 <20150216120951.GA2840@katana>
 <20150317042049.GA6765@roeck-us.net>
 <20150318132707.GD3580@katana>
 <550A4162.8000009@roeck-us.net>
 <20150319081612.GA900@katana>
 <20150319174314.GA17329@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150319174314.GA17329@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Turns out this is really easy to reproduce. One process reads
> the eeprom over and over again, another runs i2cdump in a loop,
> and voila ... lots of corruptions. Scary, especially considering
> how wide-spread this kind of i2c access is in the kernel.

A coccinelle script should at least be able to find vulnerable code
paths, maybe even fix it. But not today for me... Thanks for testing and
sharing the results!


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVC0IZAAoJEBQN5MwUoCm2SzEP/jdZmk/LWBJQv1NgX37v7hss
bjDqDnuVzdY5rFM0wmGr3VnedgD5QUzvbDzc1Ik24CITqayOyrsryuy85zAqZ5Qm
nGcuRsjBFGM1Io4VnQ6NXznsTjIRowNw65t5XIH3Ek9MLvjBaEtgIP16paeRrnPk
Z+4BgILmobeSEnmbKm2d+fK2abJn57MNgzL1oCO66WLaJZPGItNbw6K5U5crss4q
QKHOJQnGZHfXJEtZcYyb1rzj3aD2P8LAcOMTysO/j/UpDH0RDOFY2gmNmwtqoH2J
l29BIjPatAGRkalWW7TUKKaaHEIXXjYedb6hSwZ8KpRyMLw7BmNGb9P/1PdvZ96V
mK6GGoNKBPM0Dm1wGgDmOqGiLWtLVZgmIgMB26i1sQd6mY93hbxBnQg8DLm0Ycqs
GvzNl5SqXZLYV9ACkevNvJuNPovucSWGrC2id2Q3JOulhoyPQejzNzV28NKWih38
JdNVesvhTyXs0LFt0atrMgpyDrj7wnGAluLBTQvrZ1MwGvzc8HonIBjcI0WWePnT
uzN/tTu8zCj2ImqkT9i6S951H9NfbWjUhqHu07Na6zGzCt/uF1rjGzcY0W2w3N5D
R0TNrYeQlMax/86mFcwhvWd8IMnGteT0nATOdmtfalJ/iyBlhSe8/5WMgDhVpD1e
90ZC9QYrKQdXcxV8gW/x
=4Hzl
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
