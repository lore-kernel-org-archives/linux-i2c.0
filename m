From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 3/4] Device bindings documentation updated
 ACPI-enabled platforms not currently supported
Date: Fri, 14 Oct 2016 20:20:45 +0200
Message-ID: <20161014182045.GA1509@katana>
References: <cover.1476462204.git.lolivei@synopsys.com>
 <36f4b1736e36b039af15b13645df0de492f1b6e1.1476462204.git.lolivei@synopsys.com>
 <20161014173014.GA26269@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161014173014.GA26269@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 14, 2016 at 06:30:15PM +0100, Mark Rutland wrote:
> On Fri, Oct 14, 2016 at 05:52:50PM +0100, Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org wrot=
e:
> > -		is_slave =3D device_property_read_bool(&pdev->dev, "isslave");
>=20
> Which tree is this based on? I cant see the existing isslave property in
> mainline HEAD (commit 29fbff8698fc0ac1).

Same surprise here. Because I likely would have NAKed the binding.

Why is it needed? Doesn't the driver allow to be master/slave on the
same bus?


--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYASH8AAoJEBQN5MwUoCm2s/4P/RCzhVR/d3oNeEBshuOomATt
N2FEaR0NS6w/cul5Hb2XB49tGojckoUgmu0a9O/v9mWyavwANIQMQ3YfCSCnPTuu
Mx9YLBfB10VtuMBhGCaSG+TEEu7Aq6fYS1Jirs9bPYEv9F4zvFNB/hV4BQ6D7anS
0p/62cvtFiQmEMAKd3TEauWj6f3qnosZOhDc/4jkd7mrYGaXsz+edAuxA2Gg6n9r
jGlC8BvWSTMf/w+j++q+6A8/xjNYBRfMJ9YOmwdGFSYil2Ll0N1Z05U3nVMWsSqP
qhU0hWdpHM87vdTHIRln21bWmKq+t+KCF6NUYcqsRKi2PagzajtkcPcSAXixfL7N
FPWtnQJayffD+IwJoL0GTbK/3ihdb87YyE8fhFaLBIdprzgR9czj3AatGqn77x0l
xlfD65czke5q20Riacluqk8nEdF2ulkYO1nhgFYXd10161lBOk6lxzMxMAUNKjGH
0E7lMvsMfhoW7kyD7rEoeE7HXGb2+GVWwRVWq/XRZLU8mJ173sN1h17NqoRS+SwS
Tm2LR5lf2nFxclKYwUjKImSSdIkHnbBqo3XHoJcRFqTlB3kFVnhuJqkCHvgJhh0H
wSOhF8uHEEJvQop6zarxQbkZBQnPXNujK2RlvXqyLwKFGo4BpT61qpP7YFE7GFt4
ZO/otbgt32asZQ5jS9uX
=JA8r
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
