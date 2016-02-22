From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: brcmstb: allocate correct amount of memory for
 regmap
Date: Mon, 22 Feb 2016 09:05:22 +0100
Message-ID: <20160222080522.GB1389@katana>
References: <1456064238-6294-1-git-send-email-wsa@the-dreams.de>
 <CADtm3G7ZHfVyoEcAcFGC4oPX=XHyedSWDMvg6nKPLQ5_is=ZiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60799 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705AbcBVIF0 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Mon, 22 Feb 2016 03:05:26 -0500
Content-Disposition: inline
In-Reply-To: <CADtm3G7ZHfVyoEcAcFGC4oPX=XHyedSWDMvg6nKPLQ5_is=ZiQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gregory Fong <gregory.0xf0@gmail.com>
Cc: linux-i2c@vger.kernel.org, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 21, 2016 at 10:33:14PM -0800, Gregory Fong wrote:
> On Sun, Feb 21, 2016 at 6:16 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > We want the size of the struct, not of a pointer to it. To be future
> > proof, just dereference the pointer to get the desired type.
>=20
> This looks like it fixes like a fairly serious issue: before this
> change, the driver may modify memory that wasn't allocated for this
> struct.  Shouldn't this also have Cc: stable?

Surely. I usually add the tag when committing, not when sending out.

> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>

Thanks.


--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWysFCAAoJEBQN5MwUoCm2rtYP/0wNKF02RuLb1K0DFwbvD6PV
Yf4kFBVxfJor7pC8aUPR7JQUYkhSjZUiLTghSn7nWN6d45sVcNyyitIPh4/gcAZk
C1vGgnaEX++GvZUqCMlbGLETh1FWqYqcYfFSNeZwuMQb4sf6DsxPk1LuPGe5QiT+
yCsyC1KPXN4+LfJLiEMw4CUan3UhiothzsnomhjbbF12XxYye3nChEq2c7OPmcQa
AiYPmIQVK4btBmjeT2JNmphIbT1r0qR5Ki+VANWTafXSWgPaAtX+CbqTJVt3kYmX
I9V6C016vJfR2bfzM3eMdIuA16G/2KJK8Q3ZBB8Hqt2MYAh+A8J5G1AOeReAZ7bp
eAQ3eQuyZopPgbGUVzKngyqpklrnbA/DJ2OPRhepBU00ofmay1Z695XScv4gdUpr
ELirokN4Dn816qDxLC70pY4U0Q3HPSwgpDynI6oA0lvcd4HbGfLRf5FFKcNo7xHP
TYUc/mYsN9Ork4r7xwW8WJJuJXQjHbg1TmnhMqp8WBC9558z3wsqm0W5B7DEu4p6
yj6NNl1TNRszVcCLaEG6OU/tS0/duydH/Em57lmNmCWiUhhhH0XmnWRpdjsBF9cZ
bcoEAyoyJjHMYHWqXT5dQV8UJzHSeY5sueBINdqw9EbWavgYvJ5sjBSlloGPXA9i
v/X3pt+HHW8U7UupMiu7
=jjym
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
