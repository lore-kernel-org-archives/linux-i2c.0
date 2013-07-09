From: Mark Brown <broonie@kernel.org>
Subject: Re: MTD EEPROM support and driver integration
Date: Tue, 9 Jul 2013 15:55:10 +0100
Message-ID: <20130709145510.GZ27646@sirena.org.uk>
References: <20130705201118.GM2959@lukather> <5811519.oHVuMujf0I@wuerfel>
 <20130706120112.GA11069@lukather> <8997501.Dchyii8uWX@wuerfel>
 <20130708083426.GO27646@sirena.org.uk>
 <20130708202538.GK11243@lukather>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5621913671310221085=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130708202538.GK11243@lukather>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Artem Bityutskiy <dedekind1@gmail.com>, oliver@schinagl.nl, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Shawn Guo <shawn.guo@linaro.org>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============5621913671310221085==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3aDtFGIaURYlkDgg"
Content-Disposition: inline


--3aDtFGIaURYlkDgg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2013 at 10:25:38PM +0200, Maxime Ripard wrote:
> On Mon, Jul 08, 2013 at 09:34:26AM +0100, Mark Brown wrote:

> > I'd really like to see more discussion of this "DT parsing code for
> > regmap" idea...  I've missed almost all the context here.

> The context was that I found we lack a way to simply express the need
> for one driver to get a value from an EEPROM-like device, for example to
> get a MAC Address, or a serial number, in a generic way, without having
> to poke directly with some custom function that would be exported by the
> EEPROM driver.

This sort of information is often stored in places like flash partitions
too.  Are we sure that regmap is a good place to be hooking in here?
The use case is sane, and being able to use regmap to do some of it
seems sensible (I've seen people use OTP in PMICs for similar purposes)
but perhaps an additional layer of abstraction on top makes sense.

> What we've been discussing so far is that:
>   - To have a common framework we could base our work on, we could move
>     the EEPROM drivers from drivers/misc/eeprom to MTD
>   - To declare the ranges that needed to be used by a driver that was
>     needing a value from one of those MTD drivers, we would use regmap
>     with a MTD backend
>   - And since we actually need to declare which ranges and in which
>     device one driver would have to retrieve this value from, we were
>     actually in need of DT bindings.

> This is pretty much the only context involved, and we are at the early
> stage of the discussion, so any comment is very welcome :)

If this stuff is being represented in MTD doesn't MTD already have
adequate abstractions for saying "this region in flash".  But otherwise
this seems fine, it's not a generic regmap DT binding but instead rather
more specific than that.

--3aDtFGIaURYlkDgg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR3CRLAAoJELSic+t+oim9/fkQAIfgoN5SRhyj8ZAbGa4b4Ulm
JzOoeIMuSKHxri5+dpG4mpCtORIrDq+dThd+c6plhBVBLZlJ2UoCT7NatfGB6jqM
PFmZQ43nOZVcWwR291arCyG8b6gpd2c1AzrO3Ofufw0dlm3GgPKs4EuEZszPunoy
Mkad+y8z0iGOvHEzXm0fAs4zC5tjHEVkgLToHxogZ6McF9OrIMrLey2BeUwvQJIY
GQppcVJagLrRAROKECWfmdjlJSmkr3QqyZMMG/uaQovSVuJOPyDOBysE5i8XsBWY
7nnH14YXykmw6oUzH45E9ZBpI0R51VVhvMIdvIJMxqsclTd6M1y2JJxJV8AxhnJt
odb7sMGEbEV2yUO7sSBFPLoAuPrT8GIO5IvNuJE0JP9b04O2Dvq/NDl8puhVw5Jo
o+k3+y5WI3+PJDVrxKlp+w7Vuu6C0EOomQHYaEq8xhhkwwehIdtUMHXiPPU06ztm
vXfzCVWWbaiEDHXX14tGP4Y+s14+3Tv/R6X+1+uyCyDflCJ+gIDq87uLLB9wnfpL
V02xc/brP8Hu+cnedVgnzPx4NlzqHDhgNFifwpejx72zBJHDtW4w3TrxjaPvLw5a
WVirvW65t8rHgxgA4Nw+p3ven3rEKfkW7Cn9mMVnJycFcrDO/NunI71tu1Oxr18A
Q9Xq6ZRpziwfbvLdqhBj
=OEHm
-----END PGP SIGNATURE-----

--3aDtFGIaURYlkDgg--


--===============5621913671310221085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5621913671310221085==--
