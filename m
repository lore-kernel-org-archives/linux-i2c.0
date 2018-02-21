From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/4] dt-bindings: at24: sort manufacturers alphabetically
Date: Wed, 21 Feb 2018 10:11:30 +0100
Message-ID: <20180221091130.4sdfnalrng4sd77i@ninjato>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-2-peda@axentia.se>
 <20180129161727.g4kdrr5sih22vs5a@rob-hp-laptop>
 <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4320651002899549681=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAMRc=Mcqj36KP7dG71dzSn_7cxw-Tru5kNtXdr5-SiH=jbCfMA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, devicetree <devicetree@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-i2c <linux-i2c@vger.kernel.org>, Peter Rosin <peda@axentia.se>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org


--===============4320651002899549681==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="r2eb7okx7lhiwtec"
Content-Disposition: inline


--r2eb7okx7lhiwtec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 05:56:52PM +0100, Bartosz Golaszewski wrote:
> 2018-01-29 17:17 GMT+01:00 Rob Herring <robh@kernel.org>:
> > On Tue, Jan 16, 2018 at 05:06:15PM +0100, Peter Rosin wrote:
> >> Makes them easier to find.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>
> >> ---
> >>  Documentation/devicetree/bindings/eeprom/at24.txt | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > This one should go into 4.16. I can apply after rc1 or apply to tree
> > with at24.txt changes queued.
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> >
> > Rob
>=20
> Wolfram,
>=20
> can you take this via the i2c tree for 4.16?

I missed this mail because I leave at24 patches to you now.
Please send pull requests for patches I shall take. Least room for
confusion (I hope).


--r2eb7okx7lhiwtec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqNN8IACgkQFA3kzBSg
KbYBFxAAms4N9T01ToIDTtK0i0l6S21CWRH9VsyfnUKa3QVG8p2ggl5+TVixMFNm
aQk0C91VQIo0WqHRYCudv26GstuO29dycaF8lwrgKtAiFGTTVSEqIGJqpQdRH+vo
f/qsdCtTBsM7lBLL1pnUr/m7rOivS21Xsi2lhG0WxS3zFSWYSiyRlVtSCq7UPADY
/D/PObzpndnOxwLZT9ra5yoELn15YZM69G82x0f9yRsBAj7h8d0ZphIJby7AA05r
uLkOmiQqaH31oa2HPbt268NH9TLvE4oBDptCqKDnxoi6S5Qtk7n8sIZPrh0SPFfD
nPdW3ZySuOwIUMIzmL4mhjoZ0VfgESF6gZbc7VG00rMB4CORmDbvXkKcrkphU85k
+MXK9q6O1dTJNFWxsYzrcLVFMwHf0InLH2wlX/+lbh32HBIuECQlZih2NaANLJ1k
3W5STVUmhHDtaT6pGnF5dH5dOzPUbdvH9ins52GWYoWhzZqefpSbUTMxqGyKhQ85
kYD72/y5EoPSaMYu0s6zSHH7qsUY+r3Zb8rGpwTd5xM8GnGGUuLj+4cFbnoIZ82m
P6nDFQqSmHCdhFFMP2e2pvsaI4xAA/CzOmlC3F6NnWO3BITKMN561s9eT8Q3aazt
Bu5PjGV9v6B7gvpl7hAMcwzBcDWaoQaPfhTiDwJ+li7ucnyHt/w=
=mnhA
-----END PGP SIGNATURE-----

--r2eb7okx7lhiwtec--


--===============4320651002899549681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4320651002899549681==--
