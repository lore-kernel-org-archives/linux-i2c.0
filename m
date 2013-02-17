From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator 'mux' driver
Date: Sun, 17 Feb 2013 16:03:40 +0000
Message-ID: <20130217160338.GA1583@opensource.wolfsonmicro.com>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org>
 <511BFF77.2090202@wwwdotorg.org>
 <CAD=FV=XUEcUx3NGCm+KijRGujECVTSJ9X5fY=arq-4U_RUdxCQ@mail.gmail.com>
 <511C32B5.20600@wwwdotorg.org>
 <CAD=FV=X=BPQo245kAtPvNUgKjypOYnheYJWcBkq6AA19z99V0w@mail.gmail.com>
 <CAD=FV=UYEqreNbUAxHydmWH+66pOORMB_uFokivLitsavzTcsQ@mail.gmail.com>
 <20130215102420.GA22283@opensource.wolfsonmicro.com>
 <CACRpkdav8WO5yOSLPLtpUCeM41nttrbspRb7YrsqGXJ01ebMhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2705750534424647607=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACRpkdav8WO5yOSLPLtpUCeM41nttrbspRb7YrsqGXJ01ebMhw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Yuvaraj Kumar <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--===============2705750534424647607==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2013 at 08:56:42PM +0100, Linus Walleij wrote:

> Hm, totally unrelated but Mark, should we consider marking the
> kernel tainted when the dummy regulators are in use?
> (And likewise for the dummy pinctrl I guess.)

It's not a bad idea, though since it tends not to result in kernel
crashes we wouldn't see the taint report as often as we'd like.

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRIP9UAAoJELSic+t+oim94UoP/3yq8CkcnDXHN3u/ZZjHBOLO
Gwm0vvpxgnmm1dxJF6DoBzQbWZ6TRTYnQq06TONH/YSIejnr44ehbgbcG9ZfF8Sm
qHx1XL0S6KjYkXTbUaq6cGO2RufIiZUD1J5Ps0jHNBRvKJOW+wiVGpB671hc9zQ9
v6FcK1WbqohsOW8r0fTftSuxlZoTojm0jSLzSR8ZtsM4P02BI5CSuHXkVlXdXlZu
d0ygFxCr7hGQyKOw3x7PKn9jmrHJzfti4k8T6zIy4GcBpROVwXOLgNk8KxWZ7/TH
SFF4cLFJfLWJEJ655ZBqw44RdHO9Q68OSUYt36SXHoLNsj9bPO4qLBGZ+v4nlUN9
MHZ9ex4cWckNsadpMI13Wb72SjISFZWMl+SjfneoyQbIw8l/7fl4sxCZwtjaHIok
7dy7GYOW18w/3r4kfFbvc1/N5sDf7c3A1D8g16R6ncC+zH4P/6b1+2XT5/GVsLUl
AD4foxDFrJMeeo/lvho0dgwflO5z5RHr7ZVomKqFF84j+oiUkXk0svwOpUky7dG6
jsDXt0vPoAlvzDBGyDXHtCz/VaUSHnC1ffsgvVI25WwLl6tna+Yt2oQBlLV0QlMR
UTy0Btqzyi07mHPzhSmHi/lFGnFvCHBdZ1lc9DlqvXauFLeqPZ6DGmSpdrG43s4F
vwytciuaunvXz9EfCqiK
=RzbB
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

--===============2705750534424647607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2705750534424647607==--
