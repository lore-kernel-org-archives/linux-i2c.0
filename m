From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv7 00/11] i2c: Relax mandatory I2C ID table passing
Date: Sun, 13 Nov 2016 19:26:45 +0100
Message-ID: <20161113182645.GA6719@katana>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46768 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932502AbcKMS1J (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 13 Nov 2016 13:27:09 -0500
Content-Disposition: inline
In-Reply-To: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2016 at 12:47:35PM +0000, Kieran Bingham wrote:
> Version 7 of this patchset performs a rebase to linux-4.9-rc4 and adjust
> the usage of strncasecmps to sysfs_streq. I have also renamed the
> function i2c_of_match_device_strip_vendor to i2c_of_match_device_sysfs
> which feels more appropriate now.
>=20
> Retested with successful usage of full compatible strings, and shortened
> device id's based on the vendor prefix being stripped.
>=20
> Wolfram, for your convenience this series is available as a tagged commit
> at: https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/linux.git=20
> i2c-dt/v4.9-rc4-probe-conversion-v7, though this includes the TESTPATCH so
> it is not by itself suitable for a merge.

To keep you updated: this series passed my first test. If nothing bad
happens tomorrow, I'll push it out.

Thanks!


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYKLBlAAoJEBQN5MwUoCm2yC8P/1ApmgupbLxPhCbywaXuqnkM
eE0vxMwv1rfGKdpHztX62UeJALo8L4XaaA4blSMm2+Sos5fmGNLQ5J/UeR4zqtGb
I9cUWLNLO57+2BBWmhbFg864YqJLUYwIYUaaCblqY2cqdFiJZogfJLla+pUYcPxx
NFcXt5O84BziiWJ1jqQCqXdGvcMvaJ1c+17dIVh5R+R3t6SFD3RBKrrcb4ymfrBN
NGq7Ph3UUEcjIQAXAP4rjD7Q4Gy08796GbKV9jylOjIKN0KDb8VOsA6YqtD+O6xr
Nb8J0npK5NIeNSotssjtJrwf3SQKu7oeilyBs8uTxCmJ1WKEjURi8GumxN9zutgk
YKdKFXRFHxw46tuB+YyzG2QbVZc+6LM47EIEOGsomDjBBuzT087Tk8k+YlIIVjKB
D6vVSEX04nR5hxo+OXqPLiQycfeHaGFkCu7nuE1wj5KkWLQVNzXiQRSszfjlMD5J
byEMZ707svcSiUFjj+nkJI6IO3gQjchkk8v/qnAZ6FZ3KNMiUv5J53FJk/6tAYWp
B4O/5lCYr742DqQIxFsOiHJguMIteQj6fzANiNAF8FMDnwm1LVpEp4BUYNy5Pyvl
Hu3kvXCdaBwwz4BW3X4C5HDRFwreTgo7lGMEpGx1/BtWjuwR2aJ0u7K8mboEe4g8
0rhPQkX58CJvhwMUrLaG
=WIu3
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
