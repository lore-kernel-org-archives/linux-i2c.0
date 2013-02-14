From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: Active low GPIOs (was [PATCH v1 1/4] i2c: mux: Add
 i2c-arbitrator 'mux' driver)
Date: Thu, 14 Feb 2013 18:07:24 +0000
Message-ID: <20130214180724.GV13249@opensource.wolfsonmicro.com>
References: <CAD=FV=W7tBOHzwayT5kgtCGmvvGs8RoX7J3rTf2vHT69b4aj6g@mail.gmail.com>
 <511D237D.9000306@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2921320274253472052=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <511D237D.9000306-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
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
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Korsgaard <peter.korsgaard@barco.c>
List-Id: linux-i2c@vger.kernel.org


--===============2921320274253472052==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G9m07da55tKJni3T"
Content-Disposition: inline


--G9m07da55tKJni3T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 14, 2013 at 10:48:45AM -0700, Stephen Warren wrote:

> This is actually why I rather dislike the idea that device tree has an
> immutable bindings. To some exten, I imagine that much of
> Documentation/stable_api_nonsense.txt could apply against device tree!
> We can't fix problems like this by changing the definition of that
> binding to remove the cd-inverted property and rely solely on the GPIO
> specifier flags.

OTOH if you do that you've not really changed things from where we were
with platform data...

--G9m07da55tKJni3T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHSfTAAoJELSic+t+oim99oAQAIDumZMDJ3yyMijhxO7uYFyh
mQJfCA585114o/8kLfcuhLtNRIAYNwMRJv9qWn7zV/tjjp76AQIHdWiwo2OR0Lss
Khk7RtMWEADpLRhEs40SEe/9VfJhpSZeRtHGLYmchALZV9Q5WGsdfaaCZ26+ZHgW
mFmn6VT/LvQRq89KKy6+t05HLHIECH0zW5MQuct9CH8NkJ+hYWkUvneBajCw6sLo
Dyn94M2JSF1STQ9aMvJSuIvc+2Boo2qH4XC4a9ge5bSWYj8/e4KfChLvcunZAMDu
ye3p7XLKVctYD98KAfbjMRCIBEMvj3myFx9kGkF1yyjOIZWuSJOvCTcUd3wrKzqz
YGqNqENYf2vK5I6wM2JfCek5uxtDjshRrEuz7e6sQzf+2x8pZVazHT29Nzt+RDZ4
naGNTSCiuLcQt0JzkWlpx5SJO/zogfBfvfZYL6JeiGiBLCKCcNw0+XhTNO5Yx9XD
HzDJZm3VLTzniUaXezX/3pXwYqWVVjCOOzNy20qCpDXwa4eQgqDaFGFi+RZoe2eV
Lcaaxhs5oSruxhQDOGiLmksvMCCpsf8t0aLnFaIUQkT9DEfuSkVT0cXQBA6qouAQ
WLR1ZJtceqC4g+yzg+rvoCAfIgo1CAeW2dizIjiAovL/MU9kqwdhEMd+EW/+1WZS
a9YBMsvjw2KzFVAwB6bn
=sjyp
-----END PGP SIGNATURE-----

--G9m07da55tKJni3T--

--===============2921320274253472052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2921320274253472052==--
