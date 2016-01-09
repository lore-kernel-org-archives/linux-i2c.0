From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RESEND PATCH v2 0/9] eeprom: at24: at24cs series serial number
 read
Date: Sat, 9 Jan 2016 22:09:47 +0100
Message-ID: <20160109210946.GA1526@katana>
References: <1449051926-21918-1-git-send-email-bgolaszewski@baylibre.com>
 <20151211120831.GA2742@katana>
 <CAMpxmJVag2E4GFSUW10vqCS32cCg0ymqkz=BOE1XS_qo655vBQ@mail.gmail.com>
 <20160102205041.GC1589@katana>
 <CAMpxmJWmgk+9oJXZnRFRzidLaasoMyuDuZmVWWrs6dwNM=+k6Q@mail.gmail.com>
 <20160105185853.GB1743@katana>
 <CAMpxmJWy3Rx_mY92wQ8+OkAEwHiJYL=n5LNDpaf6u-Ogjiw=NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:59988 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755713AbcAIVJw (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Sat, 9 Jan 2016 16:09:52 -0500
Content-Disposition: inline
In-Reply-To: <CAMpxmJWy3Rx_mY92wQ8+OkAEwHiJYL=n5LNDpaf6u-Ogjiw=NA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> If that's correct, then is there any need to have an additional mutex
> >> for at24_data?
> >
> > I can't see a need, yes.
>=20
> Then I'll see if it can be safely removed in the next iteration.

That would be great, thanks!

> > Yes, a seperate driver for the second address is what I meant to suggest
> > in the above paragraph. Only that the data should probably be exported
> > via the NVMEM framework, not directly via sysfs. We have patches pending
> > doing that for at24.
>=20
> Right, but then these patches keep the driver backwards compatible in
> that they keep the 'eeprom' sysfs attribute, so it's still a viable
> option.

Yes, they do it for backwards compatibility. If you do something new,
you can't really claim that ;)

> > What happens if you assign another at24 instance (read-only) to the
> > second address? I mean, there is not only the serial number, but also a
> > MAC address IIRC.
>=20
> Nothing - it can't be read with the regular driver. Its protocol
> requires certain bits set just like in the function from patch 4/9 in
> this series.

Maybe it might work if you seek to the right offset and read the right
number of bytes, but this is clumsy, I agree.

> As for the MAC address - I can't find anything in the datasheet, and
> haven't heard about it.

http://www.atmel.com/images/atmel-8807-seeprom-at24mac402-602-datasheet.pdf

That was the first data sheet I found when looking for documentation.
So, we should keep in mind that there might be more than a serial number
in this extra memory space.

Thanks,

   Wolfram


--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWkXcaAAoJEBQN5MwUoCm2BM0QAK22Waar8g+YUGQhEz5vGmVE
DTYOlySxaSmnJWLTb/PwANlO4CPXXl5WJ/UZd3B0G66eCm/eWiLL1aQtlBjzUvzB
cluC1DtE226kj72xw4dC02ZBXSx4pOsA3i/cCEy0vsYcJjsInZWqpgg7elKEytPg
OF07FNxxTGxWP6+TLazTXCSuwNkEkHVVmkrCba3DyRyikrUsxF5JPq+j4TOwtjBI
t4KskyH8aydatxVPfLSMDDAaC1BW+iFtSOzTvMArhuPCA929HOEMCMFIfpW3syc2
1LpZWXEuxP9iI5hZCRV2PDabpBBvHpLbPlmEbqiylRzryRxAyrDhzb5gPdH5gwbH
Cqa8X896es/SCGDlXASy3TTNmrT7CtFD+fWsS1KcxaBS5la+pFFy7VlyCysWQ6Gf
pEHi4qtH5dSo1+3ZZYT/chDYtfEVUVjviQm59XEFqSI3vYRn4Z5NUJ9IdF2apGvV
UFzXZQ91v4wn8CIY/eCsrb6rO+SXWJYcu2+iR+TQDoRhIvmkcAddf+UiMf0FuHCe
zzYkdv3BR4Fh9fvs911I6VOHayFD/ary4kZzYRc2SS1onQc0TP19L8ZCRu2n3HGU
77r0VixpH1rsuVUBiKD1URXU8g6KB2x256VCM45jjhHusckbQVEQY6/gmbnR52qs
ypypYs85ORPKeeHw3nih
=pjU6
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
