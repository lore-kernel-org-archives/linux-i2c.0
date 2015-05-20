From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/6] i2c-parport: define ports to connect
Date: Wed, 20 May 2015 17:46:28 +0200
Message-ID: <20150520154628.GA2001@katana>
References: <1432135622-8288-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1432135622-8288-4-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4438387648331746409=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1432135622-8288-4-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Tim Waugh <tim@cyberelk.net>, Willy Tarreau <willy@meta-x.org>, Jean Delvare <jdelvare@suse.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--===============4438387648331746409==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 08:56:59PM +0530, Sudip Mukherjee wrote:
> As of now i2c-parport was connecting to all the available parallel
> ports. Lets limit that to maximum of 4 instances and at the same time
> define which instance connects to which parallel port.
>=20
> Tested-by: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

I assume this goes in as one series:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVXKxUAAoJEBQN5MwUoCm2ndAP+wdd/R/1gRBgKRm0cfotVCYD
/jnUql94tDbchirZoJJJUyKpY6phuH2O+2KOnYSxKtDsnOob+GcRwLQUPvnwZMBS
A+rQAyug/toQ9uQuCNlA7rFghbPJ0xm7WKg957nB3am871LXPkzhorUShj+yfvA9
Hfwu3o5mOGjrt0Dy74qDO6oF7X2OOxaMmAJ9efmKjKK+N95in9AXbw0+xFBmtrwG
x9n02MflJEBV5Hh6Kg2MaY9XplT07s+aWriYyoFpfLREBgUuV3biT0f9yUZ6cFl5
10TKqbzNSApSMzN7Kg5Qqbt5ylxB0oBZa7WjLHVIN24taoHyAFnd+4HmxnN1k8gV
sfiMSwlS2MVq1/1mAM1gqS6cCFwyj/u32Ylef7g6efGowuYxTrsPK6IEQWMeInV/
soEsYM4cqkhEQtYbqk+YCg6zQapYr/uIIeJTMmJsDUrQviD8ZU5XUQxX2cT69XWe
+GcJbvKRK7MSiWRVcHV4agnNvvoxohZFmomNmYham4CC8sU6krXQqix+XFl7ndYk
/+R/jCj6w4vEkT31My8eQ2F52Q73zZT+s+GE73gltTxMB/37Q7oHm8q4JNgr33DC
iCvBJVjtFaFRwcanHVucZKfPpZP0Jwd4fU1Dj4JHeiA5suZUuT0OJzz2SCZvqe9z
pmEa6N4/IrJuSym8kyqh
=ZdD2
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--===============4438387648331746409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============4438387648331746409==--
