From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] i2c-designware: add optional regulator support
Date: Tue, 20 Mar 2012 15:16:36 +0000
Message-ID: <20120320151634.GA3445@opensource.wolfsonmicro.com>
References: <1332161180-32502-1-git-send-email-mika.westerberg@linux.intel.com>
 <20120319142807.GA9334@sirena.org.uk>
 <20120319154130.GX32276@intel.com>
 <20120319162434.GC5132@opensource.wolfsonmicro.com>
 <20120320084619.GZ32276@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120320084619.GZ32276-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Jani Nikula <jani.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kirill A. Shutemov" <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2012 at 10:46:19AM +0200, Mika Westerberg wrote:

> We already have the panel driver to manage its regulator and it works as
> should. The problem is that when we blank the display and switch off the
> panel power, it drives the whole I2C bus to low (due to HW bug in the
> panel). This effectively prevents any other driver to talk to their device
> on the same bus :-/

> This is the reason we shared the same panel regulator with I2C controller -
> power is only cut off when both drivers do regulator_disable().

Right, but the more normal thing here would be to add support to the
other client drivers rather than the controller (though there is no harm
at all in adding support to the controller, it's just a little odd
rather than wrong).  Like I say as far as the controller is concerned
you can generally turn the buffer voltage off whenever you're not
actually doing an I2C transaction which probably isn't what you want.

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaJ9MAAoJEBus8iNuMP3d2v8P/1hLwLcnA6cYz/EV/G4pBegZ
0T94GM4NqqW2mqnG+zQYXlA1xP6zBXUv/4jXclkFpKy/MWA1/rpCsYtQwaGCze12
Al6zHTnARD5eU1p38hNh2f7+zWF2tGp7x/brbN/vt1OtCtGJBe8Rt1Mq2OhjEH6B
uE+sKAjWexRLupFzRbQiKzXzpw4ivwu7ZSTZ9M5JBzeKLqljtVpZ6CjKqIIM7ClL
jNGRNSjL4egP5RHXViYPhgz7X1G0xlfL7wNaa5vMvlzk7uNvsZAM3AaytX0XCbgi
MiUmehLs0ldHvqTGfzQwq4kp8porDx9YRmguO3XcqPuqIXF7wWTBtpyFf+m8hnh2
GFSVhPCHh24g0KUgVaCuOVuxOdXrAwGG8amr+tRik2hKRkqWy4C/R922P6TxbFPs
ySOo73IyVwPxtFeG80dCV1K1TKOmzjnzJ+3E5u6zpPXuJdsKB33k7f7flJZJqfSM
54d/5PhujA4vYqQpH57tMJmUgpWq9pdZOXk2i6+zrfcHjGZyTe3XRJo1QuUJoqpN
Eo8WfsznFTGY3r7dtNYgXonKBvh01QmqypChtLDdtLUDtlVE7wUNg9VWtbRBD7OU
qpKgy+cDZasdOX1tKmFujrrKaJAlLyTiaeX28cswCVoZjHRuiop/77tfd9tDNKvX
2Z4SnC/S2U+7kGnIbpwj
=NyuY
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
