From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3] i2c: return probe deferred status on
 dev_pm_domain_attach
Date: Thu, 15 Oct 2015 13:36:47 +0200
Message-ID: <20151015113647.GA1546@katana>
References: <1444683283-32460-1-git-send-email-kieranbingham@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:38143 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752600AbbJOLgy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 15 Oct 2015 07:36:54 -0400
Content-Disposition: inline
In-Reply-To: <1444683283-32460-1-git-send-email-kieranbingham@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieranbingham@gmail.com>
Cc: linux-i2c@vger.kernel.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2015 at 09:54:43PM +0100, Kieran Bingham wrote:
> A change of return status was introduced in commit 3fffd1283927
> ("i2c: allow specifying separate wakeup interrupt in device tree")
>=20
> The commit prevents the defer status being passed up the call stack
> appropriately when dev_pm_domain_attach returns -EPROBE_DEFER.
>=20
> Catch the PROBE_DEFER and clear up the IRQ wakeup status
>=20
> Signed-off-by: Kieran Bingham <kieranbingham@gmail.com>
> Fixes: 3fffd1283927 ("i2c: allow specifying separate wakeup
> interrupt in device tree")
>=20

Applied to for-current, thanks!


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWH4/PAAoJEBQN5MwUoCm25qsP/iUgOY9ZNXRlUjLsQ4p/l0fL
cdCK3XA2jkyXREyW6voKVByM3bKIf1snnfIqGrrESMF41iXoFzoB4I0AcW8l2Wtx
cGbPl6VKwNGCgXArjXLYAlcQiG/sVsh+vZpInngoAivYG0xsNRtycS1ZPsMD0joP
TApbqccRvWs2hIzv00hJhsar+3BhXwy8dUJ4V6Ad39YMHI9KmTA6Q0jWB+lfGPqE
U8C01uxYua8iI4mishg5YkxVC3l/yh2x9flkr9P8ol69shxGwKYKXNwSyQyHcJPS
wEAlgITcq2Cw25CvmNQb3KWyGZXs3XTl+UT+vT+Hyfvt2KxJHsDymXgeRkaB4w76
3O4oDCsM3S+7dSMygzyN+ihtM/Y57JcDzEq6XP2JCAIDp3OZCeaI+f0vra9SF9yX
noaHRSspswjqMtM45aOuSf1dEt9oF1d9XlQbno009CVDDqXdXEstmWpU8rcgq40g
mea5BxLqvq597/v4fygLuRKLZkTom0nxy5p/2+g/85kFCJ2CMyXL1PTqrkYIfNWy
VJi3kCCFKE6Wpvm6fi6BApYQuSKvWrGx7xC45Ji//qyVUldV7UZQGyjawhobR4nI
QPpU+1G19aS+cOB8ja8+SygK6smSlagE86ka7IfcOeMePVSKf+p5qcFwpXBuIEe9
ppYKf51rRyYj/2zLEsDj
=6cz4
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
