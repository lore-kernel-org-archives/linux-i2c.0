From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: i2c slave support =?utf-8?B?ZsO8?= =?utf-8?Q?r?= i.mx6
Date: Tue, 10 Nov 2015 09:59:55 +0100
Message-ID: <20151110085955.GA1532@katana>
References: <CAH-Fpeogk6kFAX9NtE3kJvi97ag9utMhUe+S0-mSJBm3eQCpxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36276 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbbKJJAC (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 10 Nov 2015 04:00:02 -0500
Content-Disposition: inline
In-Reply-To: <CAH-Fpeogk6kFAX9NtE3kJvi97ag9utMhUe+S0-mSJBm3eQCpxw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Michael Bachmeier <michael.bachmeier.linux@gmail.com>
Cc: linux-i2c@vger.kernel.org, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Michael,

> Do I understand it right, I can set the Master in slave mode and the
> new slave get his own i2c-adresse?

Yes, you can have your own address then. Note that I recently gave a
talk about the slave framework. You can find the slides here:

http://elinux.org/ELCE_2015_Presentations

Search for my name there. And if you wait some more, the video will be
there, too, which will be much more helpful than the slides only. And
there is the regular documentation:

Documentation/i2c/slave-interface

> Say that, I can connect a Master from the outside, without this
> leading to problems?
> If the master switch to slave, then stops SCL? Or how does it work?

I suggest getting the I2C specifications from the web and read about
"multi master" and "bus arbitration" to understand how it works. Please
note that true multi-master busses can in practice be tricky. Shall your
mx6 also be master, or slave only?

> Is the EEPROM simulator only available if I rewrote "i2c-IMX" drivers
> to the slave support?

Yes.

> Does anyone know if anyone is working on this driver?

I don't know of; but I put some more people on CC who regularly work on
Freescale SoCs.

> Would it theoretically be enough to write 0x80 in the "I2Cx_I2CR"
> register to set MSTA Bit to
> slave mode. "Changing MSTA from 1 to 0 generates a Stop and selects Slave mode."
> Or then disturbs the old driver?

You need more to do this. You need to handle slave interrupts. See the
documentation.

Good luck,

   Wolfram


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWQbILAAoJEBQN5MwUoCm2swIQALEHue4W14J5WnQUWwv8Q1gX
7+2tCD49oQTiOv6OddZn1wgD/z2a+YVrMXmCFdC4ZVFysi32lJPLEvuEwGZU5fBO
M/hdZh3x6Ppt96kDe24jNgctWxGma7z92P7PjySBoo8HRwvydn6j3iOIa5y2SXEN
6StYEacph9K2WJZvApekKfrUvLLhXUUzyBPFyk7kaW5gIEcZ31on5K2bX67A2D9H
gi3fvXoFsyGzb0h4ZcfXOt9OD/nPNiDqZNEJ10N8japZ0tRW6oTyBgzfVZo+uqk0
Furz4+X7JOcfQKagjpCcZNquL6LSaz+YN+z2B32dKedvAPfIJjGP0/+XLi0DT7sL
xHnnmzLb3yMENffYhGDYfBDL598MrRJC4KQA0rr4+b5uUQKjlgVnLp5eOyOLBz15
QXNMSjYLRKRe2E0EAgpfedDRSiLrR64EKJ3zQgG7VlAX1RPnx5EkgcWHw0AQ86bq
rMS64PeSjptIMpszgetLQaRwQpN7Mk8Av9OQ/VaOlPWZrw0NHSDzKEqBXCLou5Ub
Ua1i7jSIDlWAOTTxytEzS9ZmMMcyZ6i4oTszv353ArIq0wrPhOvo8aIz+omK7J23
Lh3/nMjvKly0fTEGeCypPlPdtIugy7SsGgmXdwR1SqnniJ94+pRcV6rkaHlEEHqW
ohEcnGky4ZpKQFIk5gZJ
=MCZz
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
