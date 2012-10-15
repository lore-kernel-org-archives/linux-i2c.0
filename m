From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-ocores: Use devm_request_and_ioremap()
Date: Mon, 15 Oct 2012 09:21:41 +0200
Message-ID: <20121015072141.GA18741@avionic-0098.mockup.avionic-design.de>
References: <1344408872-1051-1-git-send-email-thierry.reding@avionic-design.de>
 <20121015091015.2887fcb9@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121015091015.2887fcb9-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2012 at 09:10:15AM +0200, Jean Delvare wrote:
> Hi Thierry,
>=20
> On Wed,  8 Aug 2012 08:54:32 +0200, Thierry Reding wrote:
> > Replacing the devm_request_mem_region() and devm_ioremap_nocache() calls
> > by a single call to devm_request_and_ioremap() simplifies the code.
> >=20
> > Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-ocores.c | 15 +++------------
> >  1 file changed, 3 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-o=
cores.c
> > index bffd550..1fad4ae 100644
> > --- a/drivers/i2c/busses/i2c-ocores.c
> > +++ b/drivers/i2c/busses/i2c-ocores.c
> > @@ -283,18 +283,9 @@ static int __devinit ocores_i2c_probe(struct platf=
orm_device *pdev)
> >  	if (!i2c)
> >  		return -ENOMEM;
> > =20
> > -	if (!devm_request_mem_region(&pdev->dev, res->start,
> > -				     resource_size(res), pdev->name)) {
> > -		dev_err(&pdev->dev, "Memory region busy\n");
> > -		return -EBUSY;
> > -	}
> > -
> > -	i2c->base =3D devm_ioremap_nocache(&pdev->dev, res->start,
> > -					 resource_size(res));
> > -	if (!i2c->base) {
> > -		dev_err(&pdev->dev, "Unable to map registers\n");
> > -		return -EIO;
> > -	}
> > +	i2c->base =3D devm_request_and_ioremap(&pdev->dev, res);
> > +	if (!i2c->base)
> > +		return -EADDRNOTAVAIL;
>=20
> I would suggest sticking to -EBUSY, AFAIK EADDRNOTAVAIL is for network
> address errors.

Actually the kerneldoc comment for devm_request_and_ioremap()
(lib/devres.c) explicitly lists this as the error code to return on
failure. EBUSY could be misleading since the error could just as well
come from a failed ioremap().

Thierry

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQe7mFAAoJEN0jrNd/PrOhwDMP/iUp4S2g43iz5R9ijaKj0kIZ
7X39kbsp9FJTwokDYwb8Ej/rG1zCShtMVsvPDKhafvxEq2JBeH41gDtDnasQo8bd
iCZuF+7K03fAX50fng2+KZ4Dy8vTxq5WZU0/wQjt3r5Fs86QQi8sR2FqjcgGTjHk
LWAWFWrsZ4bDtgHqkRb3Qj+403nQBJ/ua1t0JNK+MGFKrLrc9H97J/sHks/UiyTA
5kWPSWMnS7nXRsA6kN8JPIteb1MjoDlut0GkmbcYK+XfBnkSiKE/eK/3OT+gikkG
ej+25+WaNiqfFo+3Eadh+K/9/Wy5C6OsVqpcl6Ox+sFiwQHmAs2PgmxaCHMGX1zU
esJHXA1kC1hCVTMWAey12Lh2qeSBmzSn2zjutkj6PfJxdGGrT73NaBbvZCI+f5GM
N4Tq7hHxMM6YbSXqENRgAduZvhK+H0Slneu35DhtUcqU6uH59WBOfGBjoFKLdDAV
mO5MmtawnemqiD3yhSQLSg86j7HPA/8Q7N1rAHbMISc7vTDnnURmF3z5ErL71YRj
aiSBmuaT5IXmQUnyRMao1wq212yzAQAgfIu4beiTmNciTTGSTSl/cZ82qax15pgd
eXmK6HiYjeJM56tIFjbrXO04UcJZFHmrux7VpYXAQaOUIq0I5lHrt9VqLKtxyJOE
oqFzK7UbTPdm4FlcTOBM
=vPTa
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
