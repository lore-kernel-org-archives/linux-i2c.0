From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: interface to trigger a bus recovery sequence
Date: Mon, 19 Dec 2016 00:14:01 +0100
Message-ID: <20161218231401.GA1442@katana>
References: <9d29f4a6-50ae-2400-4a4d-79ba7ed48a53@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47138 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758213AbcLRXOF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 18 Dec 2016 18:14:05 -0500
Content-Disposition: inline
In-Reply-To: <9d29f4a6-50ae-2400-4a4d-79ba7ed48a53@linaro.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc: linux-i2c@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I was looking into the i2c bus recovery sequence and I was wondering why
> there doesn't seem to be an interface (ioctl/sysfs) that allows a user to
> trigger a recovery sequence.

I can't think of a reason why this should be possible. The I2C bus
driver should figure out when things go wrong and do the apropriate
actions. Also, the I2C specs have a clear definition when to use bus
recovery.


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYVxg5AAoJEBQN5MwUoCm2ZdMP/jKrt3WiKoHdkYgRgpP0kScl
HU8rAH6vmV6JDSjmIcsKvRepE976fOs6NDwPOPfakD/bVAZHTkbVPaX9LWH11kg1
K5UuCOqFxNWziS1EQYB9DqFEGHbT+dvkBUA3KmEb6KaTCVvsqwu0gbOSjjfO3mBV
D71sjCZ1ESdTjokN0+qhUCjIAy9G1qMYQK/YY51hIDbIIgLroPkyVAR3xTQ0Z/8E
NEbEwe4vVinlhzd/JtsVbswGITo7CKxbrLONxZGEaSfx/GAnQpc20sb1POdLv1ZC
0QdnIqcl6iDKQVNHxjkBYSpUVbgZU/QLlGnSVWp7LeGCtfGCB8QXawtFlpzuNZQV
tthKdPs95PCFK7pzzpss/GBB9aFShgk22y3Yf6DxkS3SlAsKVrEWBHYullTZ8nKY
KQVohcdH3oSr2WyxWOQthtWi0xMhxvCrDHAFSQsD15cU8ZcewZ59r/z6URLq/r+0
acM66zuWx8nX94hSI5zYpNBwSdRvSLQfCTlfUtgE37MksvXgKOFjthigETa91S72
RFUT9433iSBYBmFAV/fX/f5/AltYSJq4ugNJTWNl/Hz4V46CDlDY1uHDMqaat4ny
W9v9qzY+DirIW8mfgItsq1bdE5eQsNHhogvOBK63P47TxLZ7IWE6wH0ILJnxoLB3
vwUEia3xGlYBTVD3lB+s
=WXEE
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
