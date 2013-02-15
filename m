From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator 'mux' driver
Date: Fri, 15 Feb 2013 10:24:21 +0000
Message-ID: <20130215102420.GA22283@opensource.wolfsonmicro.com>
References: <1360778532-7480-1-git-send-email-dianders@chromium.org>
 <511BFF77.2090202@wwwdotorg.org>
 <CAD=FV=XUEcUx3NGCm+KijRGujECVTSJ9X5fY=arq-4U_RUdxCQ@mail.gmail.com>
 <511C32B5.20600@wwwdotorg.org>
 <CAD=FV=X=BPQo245kAtPvNUgKjypOYnheYJWcBkq6AA19z99V0w@mail.gmail.com>
 <CAD=FV=UYEqreNbUAxHydmWH+66pOORMB_uFokivLitsavzTcsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5228924042296232678=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAD=FV=UYEqreNbUAxHydmWH+66pOORMB_uFokivLitsavzTcsQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wolfram-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Girish Shivananjappa <girish.shivananjappa-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "bhushan.r" <bhushan.r-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Naveen Krishna Chatradhi <ch.naveen-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "sreekumar.c" <sreekumar.c-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Yuvaraj Kumar <yuvaraj.cd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--===============5228924042296232678==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 14, 2013 at 01:40:49PM -0800, Doug Anderson wrote:
> On Wed, Feb 13, 2013 at 4:54 PM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:

> ...but when I moved to module_platform_driver() then things still broke.

> [    1.510000] platform-lcd supply lcd_vdd not found, using dummy regulator

> I was sorta hoping that there would be some magic where
> regulator_get() would find the device tree node for the regulator and
> then resolve the chain.  ...but maybe that's a pipe dream.

You shouldn't have dummy regulators enabled at all, that'll break a
bunch of stuff including dependency resolution.  They're a crutch to
help get things booting not something you should be using in production.
If they're not enabled regulator_get() will defer the probe.

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHgzJAAoJELSic+t+oim96coP+wW2L5skeQe3KWD9LgTbaUdb
99oC8BR3Dns9JbLL/7wA3psJex1TUvBhGrSXNxxYoPiZjuMMRmwmIG75A88L4XZo
WwR9adX5EN3EnnvrXWf7Xci3zyyHKnQ+9Ydij9XkPL2+lQvl/cHcoUepxBkVExW/
j77cDY2SnBUTh6VYjy4scra4X9940rLdtoixQm4WTRAST1frNPvqoRFXLt47xH9z
qlxOZUrUQ/YrEfxTjKCDUWm4vIHyhNwRdjsep8NvxGrznavXjmYhGNEb7AhGFX3t
5YkOLxfewjT3t+F6udyCuN5dth4OpjjTq5ZHWnEywlppj4RwYSrXTGFKoczYO9+z
NBq92W9IIXY/NctGcP2wxbBlt2KEwLkitXNAnDXZEL3a/pfnpcBk79VgtoGU/z5Z
xe9v8NvdTFUT6j1fSQrA0C13gabojsVrwuSq3OyHo1HJlcVUSmlIbjJcq62Pkt/K
vwjebmlI9Qzi9q0ojdM2yMlRGuLXVQ7RKL55L0xLzcrJus9EHZr40Y+XUxCQEr6M
OkHiWFyg9R7EfgOQv8QgPdqL5EJ0/Z1wGUaCUv9xCDoJr15/kc0HkBdwO2SyHhXW
KS9DzyV+Gljda/66sSxgOLl+6vAvC16LvGr6/ODEEKxf9KcU4JMzy1QmT20Z51az
yBN4Phq8XD02g7C0UEWS
=U2FK
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

--===============5228924042296232678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============5228924042296232678==--
