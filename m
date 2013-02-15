From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v1 1/4] i2c: mux: Add i2c-arbitrator 'mux' driver
Date: Fri, 15 Feb 2013 10:26:55 +0000
Message-ID: <20130215102655.GB22283@opensource.wolfsonmicro.com>
References: <CAD=FV=USf_YSzW1ZN2NWZKnLk_LPpnFpxRy=AGVyn_YHjRpKyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9006810516952537219=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAD=FV=USf_YSzW1ZN2NWZKnLk_LPpnFpxRy=AGVyn_YHjRpKyw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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


--===============9006810516952537219==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 14, 2013 at 05:14:35PM -0800, Doug Anderson wrote:

> The regulator_get() calls are before regulator_init_complete() by
> quite a margin.  The regulator_init_complete() is a late_initcall, so
> that's not too surprising.  Are we not supposed to access regulators
> until after late_init()?  That seems like quite a limitation...

No, they should work fine at all points (the worst that'll happen is
that you might get a few extra deferrals).

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRHg1RAAoJELSic+t+oim9/BoQAIGC528aqY932jSquKnvxZT5
zJmZhIrlggtR7bRZx4mgtCBEoMM2aDFN/iUzMW5dVi2Ck5Bs3G7QFSAbhDhUHAMV
9fZ34GkMrf9lveh3xiTUFNvDAAE9O+Wob+ZO3JoldWlMYV/QQvfnZFenyA8ck9go
A7UIAGh/7UWE8eZ+TYBvAE0KO/jTb1Qq8Tb5JkxT8UTI6gvb/omN5PZXeUmplOex
uxmKMPIKkVAWpEgJtb52HNzpjJl1t8us3j4CclLMgcvrUfLoysBuXym+qgF1EonH
WMXgFUf1/ffUj4FsluNsP7XC5g6osU69lbfO/Zmea7ncWp/F55QpUgkOwohiBw0o
Tfq/U/YnP8EOGShvHFBzRUkr1A3F/3k/f1DjCOakz0n7CDgft3bnhW8qKPKQ9h8x
/QsoL+T6v2VaHsovOAL25kE3zcbFAoiPyxIXXfvdP+cm5JVzvQwJElcHGZRLYWH+
FZovd2y9abiuKxVe1hHxulQPPfOhcG9O+S5evRGIgTYUJAYc2qv5aSbkMhJd9fC3
fSPcNNzgjr1bOSnQXqJNKu8JgiEHTmiNBnEMhZ+DiOfv9RORH1km82ZmELEOqQTa
eN9THFcVQxZwyPjbYcps5WJSW8FpuwtlOYQsQTuR6TBpVDBsbAmGBUkrRjGHDzo0
0YErr3rTcZ+icGxKNR3U
=w9aG
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--

--===============9006810516952537219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============9006810516952537219==--
