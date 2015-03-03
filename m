From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: designware: Suppress error message if
 platform_get_irq() returns -EPROBE_DEFER
Date: Tue, 3 Mar 2015 18:21:45 +0100
Message-ID: <20150303172145.GA7076@katana>
References: <1425396456-10633-1-git-send-email-abrodkin@synopsys.com>
 <54F5E120.3090705@alitech.com>
 <1425400650.17965.53.camel@synopsys.com>
 <OF441D1D4D.39476C28-ONC1257DFD.005BE73C-C1257DFD.005C7908@alitech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <OF441D1D4D.39476C28-ONC1257DFD.005BE73C-C1257DFD.005C7908@alitech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: christian.ruppert@alitech.com
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>, "christian.ruppert@abilis.com" <christian.ruppert@abilis.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>
List-Id: linux-i2c@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> which omit this type of messages completely. Andy's proposal of
> centralising this looks like a very good solution here (and on top of
> that removes many useless strings from the kernel binary).

I am all for centralizing printouts. I recommended this at my ELCE talk
last year, too. However, you need to keep in mind that irqs are
sometimes optional and you don't want error messages for those irqs.
IMO worthwhile, but not a low hanging fruit...


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9e2pAAoJEBQN5MwUoCm2j0cP/RxFMIXisiW4p/z3KgNd0mM+
dyl05C+iXhfbUZUzpasE44W+C1OMjYb0JrW1Gehb7UXcDrkWFTo6UlU+eTeoXyuK
VLGLbSca+2f5jun3uJwJ1LrgURFr9cmBSSdY2zLMjTOtMfEuKIcqVRyeVKTO4ne2
5WjnNBHw8cLlRgBs5CE/7OyjDk8atTs6KGLyPVQ4uykiZJyuOx/MsPO5AHmFLV8m
Tk6yYr4S8sEvWYaNZiXu3gs2bYuw3ODHKLfyLVBdRLzet7vkVq9H3t/GAs3jRGud
TPAtQbDVtn34pz/CpxcsYunwmtcwQoLJEAKqEIHazI74W/Jk7UzIqRAzB0rFC2TG
/XRzf0zqFiTWd6uW1MzASkDZoSYebKHvABk5b/XG2j8D9nB7Xyw4XtMe68TmIdgl
T738/OKjWCF13aX83DWCl7kZzOmHELMsdOd90/C+jEDgKollebSf6Lc7NtAXkFEP
JL8pn+6qGbEYmOL1FYd/QcoJTyjq571iR7hO5hyx88fkpYVy5l0zbwn4SJ6NAoKk
A8DfeFWKfOw4ROCnYZyPaDrDEj7/F7YtIDF7lJKrIpruZOwJQbokJQK5n+WfWoA/
Olv/cDVnnCMGNVToRpi3/DFiL23Uqpda10xDzofNQGaRiw8LZ/q4A2DxCw89e+/S
+DgqlBb/VNjSAewL9J2E
=mq9o
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
