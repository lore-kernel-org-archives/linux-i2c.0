From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/2] i2c: ismt: Fix length handling for SMBus block reads
Date: Tue, 29 Aug 2017 12:22:25 +0200
Message-ID: <20170829102225.7yjh52hivygbdbc7@ninjato>
References: <1502140260-13789-1-git-send-email-stephend@adiengineering.com>
 <20170814193105.cosdlbf5gypazlzn@ninjato>
 <f1d1d452-892a-82ff-c6a2-1e2512d9ed70@adiengineering.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ya73meqvsfqm7jaa"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43910 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751902AbdH2KW1 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 29 Aug 2017 06:22:27 -0400
Content-Disposition: inline
In-Reply-To: <f1d1d452-892a-82ff-c6a2-1e2512d9ed70@adiengineering.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Stephen Douthit <stephend@adiengineering.com>
Cc: seth.heasley@intel.com, nhorman@tuxdriver.com, danp@adiengineering.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--ya73meqvsfqm7jaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> So basically the byte count already precedes the data in the dma_buffe=
r,
> >> then the driver sticks desc->rxbytes in front of this resulting in the
> >> trace above.
> >>
> >> The first patch tackles this.
> >>
> >> The second patch in the series adds a sanity check on the byte count
> >> supplied by the slave device.  This might be a nice to have, but is
> >> probably less critical.
> >=20
> > Both patches look good to me. Seth, Neil, do you agree?
> >=20
>=20
> Ping.
>=20
> Not sure what the usual review time is, let me know if this is premature.

I applied both patches to for-next (v4.14) now to get a broader
audience. for-current (v4.13) might have been also applicable, but I
don't want to apply the patches there without the driver maintainer
acks. I hope this works for you.


--ya73meqvsfqm7jaa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmlQGEACgkQFA3kzBSg
KbYGYg//aLV/dmr2xWgYu7NNROI0issj/8g84eczRuSWmItQQ+mUuKW3Al5AzUC+
lqYVfSW+V+1MfD47IVSN1XdLkpfLOc3Pzp6m6Ud8uc9LpqXri2x7OlrtWAcKNWZm
yA5fKaW3aExCKyfEVZqhPEksPMoF0UtS2HPPIjWtkIJITO88EjCe8rgswvIPGZgw
EfsQ3qGU5w62rM3O8sHLY3Xj2GDiwGTRxB6zFnE8r5+8Af7U/0Qti/AstPBOS07Y
FewaWTYgCfPUn3umkETNH0GlDr/Ce/WdFqA1kDOZYgTUgIvbIwPebXpM6O5REg2B
B/+w1CFQsS4hfpsH2G64VVly/9Vt0AD6JLhH7xS/PRBxkj4EQxRFJVcqHShdGYKz
+QvF6unRgyXTnLJPlr0M3gg/MTTVwJk+fttUeK8K5k+QgH3OqXU1IosSubq2cfSJ
MMJF4M6CSYPvjs62RlDh4mti5KtlllH+uvmFGC0W/OZ3ze4NUFUril9OvgOv4d9M
/XnWK/cRBoFdJWTTOFRnVv4enr2HsPcbYQBXt2+oxo60f/hotvMTR8gJUxdajD8d
JdFwyruL0/I7DYdESlmddlNBka9hCCZ/tXIRfArxAGn9wvyxc0y7IObXj35SvV5t
OLDq0ztgHVcX8V1pVns8/Jo/s2OjvYCCfkRDi+WX+MtTPnnGBTc=
=I2gM
-----END PGP SIGNATURE-----

--ya73meqvsfqm7jaa--
