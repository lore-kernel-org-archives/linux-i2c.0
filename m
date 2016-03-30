From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Linux-kernel] [PATCH] i2c: mux: demux-pinctrl: Fix reading the
 "master" attribute
Date: Wed, 30 Mar 2016 22:56:33 +0200
Message-ID: <20160330205633.GA1386@katana>
References: <1459355236.27975.5.camel@codethink.co.uk>
 <56FC01F7.1060503@codethink.co.uk>
 <1459356327.27975.7.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45243 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbcC3U4k (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 30 Mar 2016 16:56:40 -0400
Content-Disposition: inline
In-Reply-To: <1459356327.27975.7.camel@codethink.co.uk>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, CT kernel <linux-kernel@lists.codethink.co.uk>, linux-i2c@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 05:45:27PM +0100, Ben Hutchings wrote:
> On Wed, 2016-03-30 at 17:42 +0100, Ben Dooks wrote:
> > On 30/03/16 17:27, Ben Hutchings wrote:
> > > sysfs attributes should use the same format for reads and writes,
> > > rather than pretty-printing on read.
> > >=20
> > > Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
> > > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> >=20
> > should that be moved to a debugfs entry or a read-only sysfs?
>=20
> Probably another read-only attribute (like "scaling_governor" vs
> "scaling_available_governors" in cpufreq).

I agree. "current_master" and "available_masters" is probably the way to
go. Can you do it or shall I?


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/D2BAAoJEBQN5MwUoCm2bksP/iQtJT0lwSvXnwh4CckgJ3MY
SoYARWcs5L8bymxsAaafvZf1yAfggSGGHNoio751pzD3NKI67EM+Maa52jKe8Qmf
TpQqPxYAoxsRPQQxqik+eNKgJO5hyow6qaFf2CrJNa3swYYS+JrmajO6bsPpRHuM
rJBWtZ2gufH2Vp/U/RYUSOOqutIkvE2SER3TQxx+e6+YeYcsEqGgJkb8XqTHB0VI
04dYbFGakmZIusL4dRIZhzIw0NHNmNiDxB1vO19SDyZ8embwiD4QRkFAo5WvDHMu
AHXGGLwau6tvjjS6xpHHzwkuHOCKTN1jU339Uxxsl+aNTdYbPp/T3rFQybUNJZbA
0MQfS7C0gc1TREz/2qR/tEkCXPCFtSXFS9cyQ0Dx1pd9tM45LAawJVCZ9xh69CqT
a493x0Wn31SgyecFaSh2aWTKhpOHhWBnTZrEthNxF/vIPzfUWghPJS3ZUJHQc47q
hTFoAqE3rABsXsejUFF41twqDybfLLu+7pK4n6fSRo++BDVHbggIlQvaVIIpqkin
o/wh30JZnVOyj6nQCXGEgyNOnBz4/EPlKxmuv9wpIZE0T+qW7LS75FET1/Lhkbm+
jAvlsHf0Whb1eMSJdcohokkLwB/LFAIR2t8pqKKJrTGRpeqdTzFqFGgo174IH2hO
wVSJlnWrZm0tIkaKaHY0
=B+M7
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
