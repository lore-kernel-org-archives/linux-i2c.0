From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] driver core: introduce helper macro initcall_driver()
Date: Mon, 30 Sep 2013 10:16:23 +0100
Message-ID: <20130930091622.GW19304@sirena.org.uk>
References: <1380518035-5319-1-git-send-email-hanjun.guo@linaro.org>
 <1380518035-5319-2-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DLfA7Wi+Vmsdqq5j"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380518035-5319-2-git-send-email-hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fabio Porcedda <fabio.porcedda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-acpi-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--DLfA7Wi+Vmsdqq5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 30, 2013 at 01:13:52PM +0800, Hanjun Guo wrote:
> For some devices especially on platform/I2C/SPI bus, they want to
> be initialized earlier than other devices, so the driver use initcall
> such as subsys_initcall to make this device initialize earlier.

We're trying to move away from needing to do this and to using deferred
probing to resolve init ordering issues.  Should we not be able to
convert the drivers to module_X_driver()?

--DLfA7Wi+Vmsdqq5j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSSUFjAAoJELSic+t+oim9+lMP/3nb/zrTbqdioZC48mvq2kO+
4EwbBpjnMjB0JrbnIM6J/h5I6HGKz9P+1wxYsv5Nu2Teh12cyx12PO27RJSesGHf
d+R9EEdmqy0ytwkEydJGjksSJ0P52l7TimRhOeCcJCzDxojTqyii2ZJVLgDFvzqS
JpsItNUBVa0mI+DNG1fK9b2f8Wfo0vIJ3UTooykynOglvB65uTu1+YtEDOoN6Z+F
5l8NcbotLAuP+hRZsksK9CSyegtuaWb8iSAnsa/84AqxsNLElNRt12q7V7BN6JuM
HQvUAj9XRz3P7ZhsJ1RWrl5H/htZAOXynwCLDlK8LoniXUBBLKpUVVAGpI343/RK
jSsGYaLSHA0CVHEDsBqxaXLNBBSlCqNblGroeUUsSi6dYBDuIv6UcXixvYNirDw1
ljF/PhZTW82mW43S+ZfYF8GQxYpEOd8zHHykdqzEWIrXFlNqTILlkKADzGxpN+Ap
twtw0MpcFGRJQACc1Ri2YF/5XoadC11auHN540snLJial7e9czEx+Sd7SERNQ4Ic
IWXiPbf0l+1vxh52SWG4h+jPM9iU5SBeBdVn9HPQEi/hBpA2KK6mZPo5nWgEtnrv
H4tWehrnxea2s2L0VT73EjDCSUNUPvmJxju+JAXnFdHc0rdnTfM+Oa4siDE0oBbr
d7r9quujl2EJoGRuOPLI
=togJ
-----END PGP SIGNATURE-----

--DLfA7Wi+Vmsdqq5j--
