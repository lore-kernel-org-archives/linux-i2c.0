From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/7 v3] I2C GPIO to use gpiolibs open drain
Date: Fri, 27 Oct 2017 15:49:19 +0200
Message-ID: <20171027134918.uclfmwgmukshwi5z@ninjato>
References: <20171005110310.5900-1-linus.walleij@linaro.org>
 <CACRpkdbjyDWFpb5p6kQTRm8Q=rM5L-Mhi4Q1rphEmOwgF6SHVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="m3afxiii2mhihuym"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34169 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750781AbdJ0NtW (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 27 Oct 2017 09:49:22 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdbjyDWFpb5p6kQTRm8Q=rM5L-Mhi4Q1rphEmOwgF6SHVg@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>


--m3afxiii2mhihuym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey Linus,

> Sorry to bother with this, it's fine if you don't have time
> to do the administration for this refactoring for v4.15.

So, I finally had a look at this series and it looks good to me.
I don't know about the missing ACKs, though. My experience is that we
don't get ACKs for Blackfin these days, but there is still some MIPS and
MFD ack missing? Can you ping them again?

> If you want I can merge it through the GPIO tree with
> your ACK if you need to get offloaded.

I prefer I2C if you don't mind.

Regards,

   Wolfram

--m3afxiii2mhihuym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnzOVkACgkQFA3kzBSg
KbZV8RAAsARwvS2feNtJOq+whJ0FqVRXmDcLbRM6YlsZ7SDaS+VLe/S/ppSolbD5
VFoYzi28lUGwbqQfL2fHg0Ywn7tVg60U6FZ1v6y73iHwJSFV7eUDLFo2yI/hU45G
6nGxsJErTEj+obNSOKqOwWgz4DJ9ZDqSNel2swx8K223Jor+gIzJvm3+jJ8KIYL7
P6hHyBxdcWn1XgoJOB011EanQCq/vzGLYspUVnwwSVcF7xNqxWm4LzJMqkhB0S/c
Cd7T7WrtJBNCYszhtVDsfHYn200iClOuQnfDGx9E4yvVF8KAXexrA123MrSQKRR+
IA2pKcVjSU13ExhcjNGVUsCjQNX8jAKDCdwPM7K/0esq2+lkRiN9mVQEFbq6w/T/
8+YStOvCz//3vcUra5YSaVcIqfZiKToF4rKb6w9wrs/2HhxTD2os3HowBUlzxP+e
35/gXXYIZVwC1+X9FrqNuYH+VKKNsOv0QAyxX9AFisLMHJMig0t29mmgDKmy/dRw
lIQm952D+pFqVVtcykzy806+zcbAE1lcI4ATZuzNVftYPn7MWUU22I2n9BCIroX4
ipRGx2X/KHTe5/c1gKDHYqTDKBWkCYnQiCPBwxbfVXpQfwy8ggb97XjUlLTzVj5h
/dzRYuCwGcAlF1UEVH1c86yYwYMktC+c5siJEGEg4h128+4jJoQ=
=ckGQ
-----END PGP SIGNATURE-----

--m3afxiii2mhihuym--
