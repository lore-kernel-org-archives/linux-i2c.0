From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/2] dt-bindings: i2c: Update documentation for
 "mv78230-a0-i2c"
Date: Sun, 5 Nov 2017 13:54:19 +0100
Message-ID: <20171105125419.p2ce2yl4nfi6lfcl@ninjato>
References: <20170928213605.22874-1-kalyan.kinthada@alliedtelesis.co.nz>
 <20170928213605.22874-3-kalyan.kinthada@alliedtelesis.co.nz>
 <87k20dmxw0.fsf@free-electrons.com>
 <20171005110820.phcjh7dmygi43dhq@ninjato>
 <20171005232953.gsxs6ecp6kopolf2@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3327106388867601592=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171005232953.gsxs6ecp6kopolf2@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, andrew@lunn.ch, jason@lakedaemon.net, devicetree@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>, Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-i2c@vger.kernel.org, Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, sebastian.hesselbarth@gmail.com
List-Id: linux-i2c@vger.kernel.org


--===============3327106388867601592==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kw6qjoka6l62thny"
Content-Disposition: inline


--kw6qjoka6l62thny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:29:53PM -0500, Rob Herring wrote:
> On Thu, Oct 05, 2017 at 01:08:20PM +0200, Wolfram Sang wrote:
> > On Mon, Oct 02, 2017 at 04:23:43PM +0200, Gregory CLEMENT wrote:
> > > Hi Wolfram,
> > > =20
> > >  On ven., sept. 29 2017, Kalyan Kinthada <kalyan.kinthada@alliedteles=
is.co.nz> wrote:
> > >=20
> > > > This commit modifies the documentation for
> > > > "marvell,mv78230-a0-i2c" compatible string.
> > > >
> > > > The "marvell,mv78230-a0-i2c" compatible string enables the workarou=
nd
> > > > for an i2c repeated start timing violation, but unlike
> > > > "marvell,mv78230-i2c" it disables the i2c offload support. This is
> > > > applicable to a number of SoCs such as early revisions of the Armad=
a XP
> > > > and the Armada 38x.
> > > >
> > > > Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
> > >=20
> > >=20
> > > I applied the dt fix on my mvebu/fixes branch. Do you want to apply t=
his
> > > one on your branch, or do you prefer I take it. In this case an acked=
-by
> > > would be nice.
> >=20
> > I'd prefer to take it. What I'd really like to see here is an ack from
> > Rob because of the previous discussion of an earlier revision of this
> > patch.
>=20
> I'm confused how mv78230 relates to Armada XP or 38x... I don't really=20
> want to know either. If normal compatible string conventions were=20
> followed then I wouldn't have to.

Is this a NAK or "annoyed, but don't really care"? ;)


--kw6qjoka6l62thny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln/CfsACgkQFA3kzBSg
KbaJ4BAAg3wvWnZGXUtzTaaHoFBgetsLQ0uNEsl/EOeYZEMnDsM0D1+w2vmduPmo
U1/TbK2iHp07Zum569K6iSMHWtY6M0i1CFyo8354izZhrsymWiPJfs0bOBei/l2A
qiqSMaRpEZ6Y66d63+dF5FFdjxi/W/wJt0WwqsnVAtC0MhXlDZxrcsxxst7gKht0
M0mNYdX7yHr23p5gpGLmvwoY+c4aJqL7HstEJkdlBRlUPGAMpgiDFkXwWhy+O4pU
yF0t8skHWVRaqgGC7g28v1lk8jR5j/fQk6Vkg9yVshQV8u3O7uuYIDe2hcJj147l
b2tT2QW8feGEYhqmoCQoJyVAa2PVI0/9pDAZpDQB4u650RjFZQ+/1x9kJyxZN6G3
0n0lvOMzV9EQbxOoqlIlGQt5bPK5mVV4IjUmPhMH/CZMaYZD0Wm6iPfIitR3rkwA
YioqVXsPDRkNxpVI/R0EO1Dk9WsKzD3vxmPDcPPtGJuTwxDJKUWCEEkNSW8EQvbR
OLFVT+N6Bv1Ij9HUWo5svr+L8UUrgY+s6HZSJGOqMVnZoMNqtb2h8jTNnv9rb00b
9gJ6IYkDi0NiVmtTJMErG++1aJow+MvZqlflcDC0HNlAaaVpFPOQYqbGlUlgF8eB
1b8MYnf6IivInQmK2IB9gErE02F8R8FbmDfM30dWt5EW8twe3sE=
=VPiw
-----END PGP SIGNATURE-----

--kw6qjoka6l62thny--


--===============3327106388867601592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3327106388867601592==--
