From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Date: Tue, 22 Apr 2008 16:11:56 +0200
Message-ID: <200804221612.06745.laurentp@cse-semaphore.com>
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<20080419162358.746b714c@hyperion.delvare>
	<480A2117.7020502@scram.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1769331478=="
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <480A2117.7020502@scram.de>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Mime-version: 1.0
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alessandro Zummo <alessandro.zummo@towertech.it>, rtc-linux@googlegroups.com, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

--===============1769331478==
Content-Type: multipart/signed;
  boundary="nextPart22813803.oepq2cn4Ao";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart22813803.oepq2cn4Ao
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jean,

On Saturday 19 April 2008 18:43, Jochen Friedrich wrote:
> Jean Delvare wrote:
> > On Sat, 19 Apr 2008 15:09:55 +0200, Jochen Friedrich wrote:
> >> Hi Jean,
> >>
> >>>>> Is the new-style driver conversion patch in 2.6.25-rc8-mm2 scheduled
> >>>>> for 2.6.26 ?
> >>>>  hope so! :)
> >>> Note that this patch depends on i2c patches which aren't upstream yet.
> >> Is there any chance they will got to 2.6.26?
> >=20
> > I'm not sure. I didn't have the time to look at it myself, but I am
> > under the impression that the powerpc folks are tired of having to wait
> > for me and may push it to Linus through their tree? That would be fine
> > with me, as I don't want to be the one delaying something many
> > developers want (but I also can't sign patches I've not even read.)
>=20
> The required patches are:
>=20
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D17833
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D17834
>=20
> which are just the forward ported patches you sent to the poweprc mailing
> list some time ago:=20
>=20
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D16282
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D16283

Given that the required patches are just forward-ported versions of patches=
=20
you sent (and thus probably reviewed as well :-)), what's the best way to g=
et=20
them in 2.6.26 (if at all possible) ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart22813803.oepq2cn4Ao
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIDfI28y9gWxC9vpcRAtfwAJwOmE1mpU/4Au0hU+65yO7bNacEYwCgpRtx
r4nrrYL/G06uKy++uyRK70E=
=4Lrd
-----END PGP SIGNATURE-----

--nextPart22813803.oepq2cn4Ao--

--===============1769331478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
--===============1769331478==--
