From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv5 0/8] 2c: Relax mandatory I2C ID table passing
Date: Thu, 9 Jun 2016 22:04:05 +0200
Message-ID: <20160609200405.GE23522@katana>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <20160609191513.GB23522@katana>
 <adcdbb75-41ae-774e-21cb-c039e2f0686f@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34802 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbcFIUEN (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 9 Jun 2016 16:04:13 -0400
Content-Disposition: inline
In-Reply-To: <adcdbb75-41ae-774e-21cb-c039e2f0686f@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Kieran Bingham <kieran@ksquared.org.uk>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2016 at 03:45:52PM -0400, Javier Martinez Canillas wrote:
> Hello Wolfram,
>=20
> On 06/09/2016 03:15 PM, Wolfram Sang wrote:
> > Hi Kieran,
> >=20
> >> * Device Tree
> >>   I tested that the device would still register by adding a node in th=
e device
> >>   tree for the board, and testing with a built-in module.=20
> >>
> >>  - This worked fine.
> >>
> >> * Module Autoloading
> >>   With the device tree node in the board dts file, it wouldn't automat=
ically
> >>   load from the external module. This was due to the rtc-ds1307 module=
 not
> >>   exporting an of_match table, and not yet having Javier's "report OF =
style
> >>   modalias when probing using DT" [0]  patch applied

Let's call this a)

> >=20
> > What I didn't get here: did your version of the RTC driver use probe()
> > or probe_new() without i2c_device_id table or did you try both? I assume
> > module autoloading only fails with probe_new(), otherwise we would be in
> > serious trouble. But I'd wonder then that userspace instantiation works.
> >
>=20
> I can't answer for Kieran but you trimmed this last sentence from him:
>=20
> >  - With the module updated, and Javiers patch applied, the module autol=
oads

Let's call this b)

> >
>=20
> So my understanding is that by updated he meant a patched rtc-ds1307 driv=
er
> using a .probe_new, whose i2c_device_id table was removed and of_device_id
> table added (that's not present in the mainline driver).
>=20
> And that's why he needed my RFC patch to report a MODALIAS=3Dof:N*T*Cfoo,=
bar
> and match what's exported to the module using the of_device_id table.
>=20
> Because drivers that only use .probe and have an i2c_device_id table will
> continue to match and report MODALIAS=3Di2c:foo as before after this seri=
es.

Yes, this is my understanding and expectation, too. However, he wrote
that module loading fails on a) where he never wrote anything about an
updated module before. That comes only later with b). So what I would
have expected:

1) update the module (which is "b)" above)
2) autoloading fails (which is "a)" above)
3) applying your patch
4) everything works

which implies

0) nothing done, everything works

But I don't see this in the text, so I better ask. This also raises the
question open how userspace instantiation was tested. With or without
updating (ideally both).

Thanks,

   Wolfram


--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWcu1AAoJEBQN5MwUoCm2riAP/A9CTxMV6URpPBULChoHxJk6
ogfONoYEnUMMVKh4Ib3wWqZv8WTp9oMWgD41X7CrbZOntFqW6AYzEA/0DRoU/i9l
HY+QD4IHVxaxwrl4hc4kon1YNsPlrWl3jo4KX12ZrZ/cVXtJ3ooTBTLztPe/DZ5u
TmnEw4j5+8axL52nZhabRQj1s1UF6AmN4N48M/0ddtNEjBZyWFwQoeaOXEkooFXJ
3el4cy4sg7V1c7OCUDIStFzvjm+b+Ty0NzIt0wWwEDUhHSoXNrZp1abZwhfer4lS
ARp6k1PWMyAG5WOoBwWTBAGdKReWtQxL1gH20VEjRaVgKBk7ura/i0ssGVrPMlEA
lhKjWf5/fPB5D6rDIf1Cntx/9nVGwH3L+8TNYcjcKMqpPYrRU65BXDwGH84V14bI
xdKrbnRakkRBFiD1OuBbcToHGx7XY8BMg7iwqz+9Uuw2oogg+6bgXLu0gDoRKmMe
PPnDEH7aO4ksFNXhJ4JByjUe0UDGGsDeL6eQT/HIGlZqzQPRAXSI6IPIgx7kMI+V
jmyUKYj35/gLBsY+dOF4hwM0cvwCZxb7Fav4JOPPoj/bm7XkgQ5An4mQCrFaHOvH
GcQ/+jy+aHmxjA3LdkLsU8O8dS5Kk4VNbw+oMAPonNF+APJoyuLREe9A4P6qt5QN
JxSIBjWFQZwzR8xGLe8v
=IYFb
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
