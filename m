From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
Date: Fri, 18 Oct 2013 08:32:10 +0100
Message-ID: <20131018073210.GA3059@katana>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
 <20130828095706.GH4086@katana>
 <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
 <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
 <20130830054858.GR7656@atomide.com>
 <CAMj5BkiDExikXi3JcVhO7RN8_82eGYhq3i6oPf5Wbipy=N+iHQ@mail.gmail.com>
 <20130830082712.GT7656@atomide.com>
 <20131008205304.GA29121@katana>
 <20131008221056.GW8313@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131008221056.GW8313-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: zhangfei gao <zhangfei.gao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



> Well it should be pretty trivial to update drivers to use deferred
> probing. Maybe some spatch to check for that in driver probes would
> help getting an idea how many might be affected?

That's what I am trying to say. It surely is easy to fix the drivers,
once we know there is something in need of fixing. My question was if
there is common sense to simply risk breaking things and fix them later
(then I'd apply patches switching from subsys_initcall to module_init
right away), or if we can gather ideas how to minimize the impact of
regressions (before applying such patches).


--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSYOP6AAoJEBQN5MwUoCm2l/0P/3JGDetqhSLUtGqf14VWfqp8
c8AUu21PAoP909opAgqysMjLK5D9Jua/+rljnJfDBxehUCO6nQZpMX3PpXfLSNTb
9jOqOBaP+ENoeqOdIKMS/ozuIFjQf+MVg7lRdpprenlPUUkHrd+89IptQqh7xodR
W8ycjpuRzerFO1Lv6gkhi6eS1PQsE1AUPt+2wNkaUX0bB/TyY5X7VrHcjihdawyO
4qW5Yig3abFdVscQ4wIeNyvtNyUKhb6ErHbm7Qy5CDGJl2aolKKgPJwn59fP6p25
+NH3bnjJEG2JMkp+dsBFAuCsPx8EZkogIdPVqAbtETAnsm3Fld1bDdxSLeuCQdl8
6WGpCIeLGi05FYPB4VAqppzBxT9Dzw/YiiD1dILw95Q/4h4Y+gXOmzllwXeWQZfR
nhuEHubIx8H0pGNjFFnB95EY+g9aBH0VzppT2Gb0vKEgr5Ls9j8o7xGLjWLDizIR
sD3IPZ2pFyzD4U1Qh2IEFaiBvX/AL80bcjaWogx3PhZypnIVeGZMe/40344rwryw
JEO4jIkluMO6eE9e5sQemprqk10onljBSaOBlCnBBLUJZeQ2VWFFnajGBXi2NyBJ
PKBPcY8K5zSzsjZSQPYm67CNEIs9X8quKuEp+g347asROIRfiq/PEyIXQFQeuZoe
i/XEWbm0pleW9Cfx8X2d
=I7Rr
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
