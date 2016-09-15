From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 0/3] LEGO MINDSTORMS I2C support
Date: Thu, 15 Sep 2016 22:00:46 +0200
Message-ID: <20160915200045.GE7863@katana>
References: <1473108014-30787-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+SfteS7bOf3dGlBC"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50156 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755954AbcIOUAt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 15 Sep 2016 16:00:49 -0400
Content-Disposition: inline
In-Reply-To: <1473108014-30787-1-git-send-email-david@lechnology.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org


--+SfteS7bOf3dGlBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2016 at 03:40:11PM -0500, David Lechner wrote:
> I'm working on getting LEGO MINDSTORMS[1] support in the Linux kernel.
>=20
> They have a system of modular sensors that are hot-plugable, some of whic=
h use
> I2C communications. Unfortunately, these don't necessary follow standard =
I2C
> conventions, but they do have a well-defined register layout, so they are
> easy to detect.
>=20
> This set of patches addresses the hot-plugability of the sensors.
>=20
> [1]: http://mindstorms.lego.com

Thanks!

For a review, I'd need users of this functionality. In this case, a
master driver and probably a sensor driver. Can any regular I2C master
talk to these devices if they support talking to addresses 0x00-0x7f? My
first impression is that using a class is not the proper approach
because classes were used to limit access to devices, not to extend.
However, I'd need to see more code to check if that holds true.

Thanks,

   Wolfram


--+SfteS7bOf3dGlBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX2v3tAAoJEBQN5MwUoCm2I5IQAKpT3jFu9KG8yBk23yCY/Dot
dXEYlriEfIULpv8tNhBu0LVwsFatDijYqVYju5iotdWqj3cDFaWbPQDC5DFctsJz
IBcM2E136MwE6EoxFNNCnV7k73N5KWJwMrvqSeOaufHPZtuS9DCbELOxnwQvqrno
CFK+QMsJk2oYzSEgdUMUTfTAUOTW/sFkHESN8KVBQ3A5Kd8CfkEKjdgLQ+mvb3Ze
zaD01HYAdFu3g7X2Xwux3BXu7W+FIjG+uuiPJgVko5XSg19l/3l6498WlWNiIs1h
/N4bFHGXeraqIT7ppcsklRfsLBAtgHUpZdOTUPYqYdQFqfiQ0uAILysnQbR/fuCb
X9m4apShTDhEOmGwrNcdXUiFB7hlAjRFGSdNN0LMGee5Z5LYV6EyI3KHj6NvoSth
I2fdj+rZBF+4k0dMQ6qmbZ7z8Y42zdmRGMpomTZ18AEAAP9ZHzHesdwyMxVsVDTX
hQFVaPeMF/DLcEnJveXJemkGUcOW/5pruG7XTrLXS19GI6b91fJMJGMpMLO6UjIj
D14bYiIpJXNn7jJq0NUlTCu9ctUbSTvMsI53W6QZG3e3MH9lsBw9TebEq9bx6JD4
UDhwhJmbWPAs99U8ZawCPb7hnykSekr66IudFEj6ozLJoOB8VlPIUfJNNBntmnXB
+g/kDvfyTUY71lJmgJNK
=+gN9
-----END PGP SIGNATURE-----

--+SfteS7bOf3dGlBC--
