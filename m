From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v1 2/5] i2c-designware-baytrail: fix typo in error path
Date: Mon, 23 Feb 2015 19:42:23 +0100
Message-ID: <20150223184223.GA14109@katana>
References: <1423587970-19136-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1423587970-19136-2-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150211164611.GA2712@katana>
 <1424696051.14897.13.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424696051.14897.13.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Box <david.e.box-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Shouldn't the latter be a dev_dbg?
>=20
> Wolfram, do we agree on this as states in the patch? Maybe you have more
> comments, questions?

Yes, it is fine this way.

> Otherwise, should I rebase this on top of 4.0-rc1 or you will be okay
> with current version?

Well, if it needs rebasing, please do. If not, please say so, too :)


--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU63SPAAoJEBQN5MwUoCm2oHUQAIlALh7uSzf9iJlZ7CSbSmRK
9h3wW/YngN6+eRMac4cazh9kgKou3AG7BrODwLE2fDat/j91/ljvyfeD5XZZibKG
1ADAppakjNIgztKCbA6AYWqlYvZylkG6CYDLpIgwhfkTw0Se+CdG4tirPEkzEJr7
W4yzbBUbHr0hDysDS8/wPzfiORSSifPvou0Hjy72wHCoYBK4mOWSYExMzd+e++Jq
BNqo/tMI464/qXAa/njVGitDBybF4pw1C1Dee6dOM8vvqGQ4+fAnVB86LnjwJi6w
J+/epoElL1nd5gPoscKXzbChwmtX5RBQoWXE6GHIch7Ll3/qob9hnBxUOfAwcJqP
nj39ze879q2avuEvT5afgXN+1OGmF185M4cqx+B1t2g+NNpO2zfBShZ8x/juk7h7
0IZaSj6WQA/HyTJGtdtpfpdTYSjPtkq8WHnQM/WU+S5FQokgzDiYIB51AbXt/Xin
O5UaerhfQ53pasgynGFxrnr1YySQ0ArLXmhp5wu38XBeBMfLCouVkmG6pYKJAsyQ
v8I3p+m3iMje29b1ZZ0rCcZFiKe2chvUKpzaoWM5WTyRORU15hKV6zqCvgii/huy
KgEsxw6i5G4iEJzXgUldrmCvX1+MCbYtHJYOoDYhFgP9vvoP7ucmQiQND2/8Xaib
u0ARKOTcKAwzRuVAH1Aa
=sOfV
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
