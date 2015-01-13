From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V3 1/2] i2c-designware: Add i2c bus locking support
Date: Tue, 13 Jan 2015 10:48:33 +0100
Message-ID: <20150113094833.GB1059@katana>
References: <1411497626-7984-1-git-send-email-david.e.box@linux.intel.com>
 <1417478973-25522-1-git-send-email-david.e.box@linux.intel.com>
 <1417478973-25522-2-git-send-email-david.e.box@linux.intel.com>
 <5480144F.2040506@linux.intel.com>
 <20141204184210.GA1530@pathfinder>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141204184210.GA1530@pathfinder>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "David E. Box" <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, jdelvare-l3A5Bk7waGM@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Romain.Baeriswyl-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, wenkai.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chiau.ee.chew-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

> Timely reply. Around i2c_dw_init(), yes. I just discovered this as the source
> of a recent hang that's occuring in the loop in __i2c_dw_enable().
> The hange occurs very infrequently and only, so far, when not built in. A
> block around i2c_dw_disable_int() would make sense as well as a precaution.

Any news on this or on a V4 of this series?

Thanks,

   Wolfram


--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtOnxAAoJEBQN5MwUoCm2FvEQAJdwWfyiLhh6NOlOoFcdIjZ+
/ihzfEPjwYAiczC5et9PsSWxc41KglB0qHjNxX5IAsyu/nMw/DHZnmpm9rKrlZsI
jJtBOSO/sdxBuybKfVp2pyTGBO2WAZsSPi5iswporHzF8mDRKJClXu+F1lin1HAt
ISWHu40eEwC4Dh435S21JxY298GeA61AlvjY5+CRXUZJPR6Blea8Dwh4EgR0wUkE
X78Bo3MZhGwP72rfCKYjGl1CP2UBph9ec/gQeadbXm6I6iJRlZOKDMZqKLCt0Lsy
c/OJu9pxWtRRru4wCXJqoUhWlEQIr4Ivd7tjW9LT/zCEe/vYZjLLob6dFAdRtIDP
aVeYgg3MY+ZzaxOOa089yHdrRbmobyf8RrnlkRTA0/I4OkH6H0P3r02S9RN88sWG
zueMo8KipK18dIdGrndsJeiNU0GRSCEHv264KrcwdXe21fAcZehvhKSzKycMkChb
c6qs3vtoDOLcp0j7eWGDhRA0ruYV6Xr1LjhvwIl6m+3FxuuBThCxa6p2cacQ371e
nLCL0THpgdVjojOnyQFFBqAkjTr+8Y+rwmqwGWrFkManwckt0WahojnRA6OL1iO3
8gGdr/S0Gb7bv3WjLuTuQAA93mx6WMapsBEcZW1MsB/a9S4nLDK+Y0NSOdSttitg
h9U/j1kEq0bYKNPoy7Z+
=ForJ
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
