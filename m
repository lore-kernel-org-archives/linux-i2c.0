From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v6 07/19] i2c: octeon: Use i2c recovery framework
Date: Thu, 21 Apr 2016 15:54:50 +0200
Message-ID: <20160421135450.GA5566@katana>
References: <cover.1460387640.git.jglauber@cavium.com>
 <ab24627b5928f23967633243639b431d2113dbe1.1460387640.git.jglauber@cavium.com>
 <20160420213121.GC1546@katana>
 <20160421130835.GA2623@hardcore>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49345 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752059AbcDUNzF (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Apr 2016 09:55:05 -0400
Content-Disposition: inline
In-Reply-To: <20160421130835.GA2623@hardcore>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I assumed this check was bogus and there are no valid 0-length
> messages...

They are valid (check SMBUS_QUICK), but not every controller can handle
them correctly. Your driver has SMBUS_QUICK enabled, so this is a
contradiction to the check above where it rejects it.

So, it looks like it needs to be tested again (and documented this
time). If the HW can't do it, the FUNC bit for QUICK needs to be masked
out. If it can do SMBUS_QUICK, the check can probably go away.


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXGNuqAAoJEBQN5MwUoCm2/c4QAJcYSByQUuiELEyUgON3RAOv
yLlIECFGXnESCHu4uS25lT/3FdvNNfUBZEYR5fvTnmFQYUwXlagHWncOtu9a7R6q
s3MUiGTWlBIRqlfbnOyvzQ/SGPdFFlogd57lxWXl3GWfizCoxb9yNjtX+BKT/Pa7
qEXz6kzu5soKi7kkpweckayV9XqoRS2XVjnhWLlWmV221k/sFT5QfI2FOjGt3coU
5SA8mV8kAphKdajSQ+ShG+Oakoma+G7TpCquBMbUYpDcfVPFMWb0r8vEPwYCpYR6
8SGdcKuc6TiLm5dtnAXHEvJ4mEuLbnFBVUDjr/8oVEVFr3P3pQayjV+ZdOefxwmt
CXMAAUTThuKPcRE6yek4O/lUq1exwzDAzWk3QrmKXYUHBDjkxYUbd92qebWFRevb
UFsi59h+2jKLLzdiDhS3hQtSiXxDVQwAJl32OoKw/iNkZFYv76a2SUtVQl4lZuMX
flpbiplUnrIkVuUV9zRmw/8krT8lj7TPiRf+uLdzBYCI3mH3xdGwTXaoWhXENayr
FDft5kaGV9AtUJ6MbxHw8OBj9C1qLoAtMdKVMbLIj2yn8aYcOcQgZrHzfb4w21EB
WVhxZLFfQ1xFHXbdaJsd3ELlfnhAR8NJedueMBf1SfVD522RmtBFHd+a9zz8865Q
9R0btRjCc02986ubw9sw
=ppxT
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
