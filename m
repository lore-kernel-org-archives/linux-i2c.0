From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 03/15] i2c: octeon: Remove I2C_FUNC_SMBUS_QUICK support
Date: Tue, 26 Apr 2016 14:53:42 +0200
Message-ID: <20160426125342.GB23679@katana>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-4-git-send-email-jglauber@cavium.com>
 <20160425221621.GI1550@katana>
 <20160426055845.GB5758@hardcore>
 <20160426064242.GC5758@hardcore>
 <20160426073620.GA1543@katana>
 <20160426123444.GB9796@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50630 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbcDZMxt (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 08:53:49 -0400
Content-Disposition: inline
In-Reply-To: <20160426123444.GB9796@hardcore>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> OK, I'll do that. Should I rebase the remaining patches or would you
> like to review them first ? :)

Just resend this one, please. I probably pick up patches 8+9 for the
next cycle, but with the i2c-mux locking rework planned for 4.7, too, I
don't think I have the bandwidth to apply the rest for 4.7 as well.


--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXH2TWAAoJEBQN5MwUoCm27ZEQAKu2bL+1Wa4vVhkXvW0a2j2f
fSe/GL+faGnlGtWW2Xl/qd8JZNYCLKKpCo+G7GGQc32Vyc1O+kyz7eliscEZxl/U
xVgEDDDUk5Uk2QgN5Sc+2LRZlLOs6DHyW0ghGEIAljNzS0vdXK7kPK/Eu2yEiQcJ
Ybf67OIBfY+jagZNU5F6YfY3qD28LIxKjFgKRD/gADSPH4zNEnoZ/m7N7UyqE7yF
Ueqp196Zc0Uot7/cLPMh0JV1b08wmx4t1AXabPvQU77pNN/bO3b/r7gs6+B47yoS
1I259DiWDtX+vr7aMH2Wsrsn6KlSVxV8WInuig8jnG7J2KPjiFE5cfv4tr2/GjoC
DOOsiHtAIMtL/FLZuowfegc/sR9XSEywd61zwPWynzYNrQVdJ+GDUl8LpWLutuof
+iuTFI/u9qfoGrocWdx3TFuJeofggO84YwwrnwNKsnLIwMT0YTfbXESRA3ANFInk
fOgXNKie9Iu9M+khjYaINljdrWN+qjZZ3L4vQfdTSH+t2zo1IIH/ndQ+LQn5M9UB
Vh+LJfyLqLZceRBNp9ICkMQ+Wzz7mMW46goORISbvCDTHKs8o5mu+VhucPZiuCfc
ZyC1zrKhCbZso2m01J9nDmfd14vW4sZPTa8IPC7EDBbNXlMsofALRupqscwC6VQ9
pUyfYbDR2zljPio4CFAc
=LYer
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
