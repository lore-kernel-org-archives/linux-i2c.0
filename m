From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PULL REQUEST] i2c for 4.12
Date: Mon, 22 May 2017 23:04:23 +0200
Message-ID: <20170522210423.rikepe5crem43wzp@ninjato>
References: <20170519204014.jumojwrdw6lfnycw@ninjato>
 <CA+55aFyzSD3Gt9JqGvfyyaujYnGi+kQz3vDho6LBZG+Xz2qqNA@mail.gmail.com>
 <20170522201421.zq6ao54uzubjfiiy@ninjato>
 <CA+55aFx2hDWoiQn2S=wHv7AQHvkq+D38EhVu67qbrHdhyGw6Mg@mail.gmail.com>
 <CA+55aFymRrdZO-ASyZSgq4Da28fGJOSd3R-idok_L7NJdTGa0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4yvh77u6pt3wvkdi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:59467 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933846AbdEVVEZ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 22 May 2017 17:04:25 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFymRrdZO-ASyZSgq4Da28fGJOSd3R-idok_L7NJdTGa0Q@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


--4yvh77u6pt3wvkdi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Confirmed. Initializing those fields to zero fixes it.

Thanks!


--4yvh77u6pt3wvkdi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkjUlMACgkQFA3kzBSg
KbbALw/9E5HWV304V6cHmXtuRFbFY8fKGCMKfSwzItSFzm122mibF/5aDzCGvd03
GEsaqRLdI0lIMIjlL6eJXbxPytlqXA/VNnDgW9BBQ/VzdcljREGtZkUNlClUvKof
EWKDyo7zPQg6mMZOyaCUl/Vw/zZEZAn1IMXqWWyavb0Cxf1/UhNdjR7S8EtBhi4I
feoYr7ENQK7JLquYKA3Em+Zik//lsjWkm5g3YyL6nHOV0rJuG6MRNcBeBUMiKlMX
qnPJDCqwm8zezUC/QnYT70J11aCXLzODe31XqGQIPaJNqllPaGIzs0q/i+ioO2np
hRdo3bfPhQAeZwLIOtSOQ8OEREc44fTtSygtmdQ87r7uJ0vlx2xuPOOkm/9xtvzw
vXFoGx2PRtpvvzhq9BjU4w8+IOiMDVAUQ30QaEmobt+Rw0AwLJdKCXiemqfqivQE
9eJ8bzuTjzVPFenaD9zeWtO8CwDClSoxAF9CSyyv4pYoYUMn0nECh/Q78h5dlq3Q
8KAL+MZicWRV08r+RECXlkaInmWXBiJ3eKk/VURZ4lG8xemoZKrnxxox8f5BHuKi
gaR+IxbesPRoMe8+Tzg3/1F5VmxeJlhuxgvkaC1nl50AMnOkM6OuO/Q9WQJiLf3n
q8fG8HjsV4UewxOLT0OAilxwyrljygoM0RuPpk3lbHlY7/fNIus=
=3t4c
-----END PGP SIGNATURE-----

--4yvh77u6pt3wvkdi--
