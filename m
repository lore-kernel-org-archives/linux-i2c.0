From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-eg20t: use dynamically registered adapter number
Date: Sun, 18 Sep 2016 21:22:50 +0200
Message-ID: <20160918192250.GA1415@katana>
References: <1471943158-21377-1-git-send-email-yadi.hu@windriver.com>
 <20160826173019.1f939ce5@endymion>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33889 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757876AbcIRTXA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 18 Sep 2016 15:23:00 -0400
Content-Disposition: inline
In-Reply-To: <20160826173019.1f939ce5@endymion>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Yadi Hu <yadi.hu@windriver.com>, linux-i2c@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> If not, it may make sense to add a helper function exposing
> __i2c_first_dynamic_bus_num to drivers (something like
> i2c_is_dynamic_bus_num().) After all, i2c_add_numbered_adapter() mostly
> makes sense if static i2c device definitions exist. If not,
> i2c_add_adapter() is just as good. So something like:
>=20
> 	if (i2c_is_dynamic_bus_num(i))
> 		ret =3D i2c_add_adapter(pch_adap);
> 	else {
> 		pch_adap->nr =3D i;
> 		ret =3D i2c_add_numbered_adapter(pch_adap);
> 	}
>=20
> may make sense. Unless someone has a better idea.

PASEMI does:

        smbus->adapter.nr =3D PCI_FUNC(dev->devfn);

I am unsure if there is any guarantee in what order PCI_FUNCs are
probed, yet I have the feeling we could try a little harder to get the
numbered adapter. What about this (untested, just to get the idea)?

static inline int i2c_add_adapter_try_numbered(struct i2c_adapter *new_adap)
{
	int ret;
	struct i2c_adapter *old_adap =3D i2c_get_adapter(new_adap->nr);

	if (old_adap && new_adap->nr >=3D __i2c_first_dynamic_bus_num) {
		i2c_put_adapter(old_adap);
		dev_dbg(&new_adap->dev, "Static bus number occupied, trying dynamic numbe=
r\n");
		ret =3D i2c_add_adapter(new_adap);
	} else {
		ret =3D i2c_add_numbered_adapter(new_adap);
	}

	return ret;
}

I used 'static inline' because I think the drivers needing this should
carry the extra weight. But no major objection to put sth like this also
into the core. The documentation for this function should carry a big
note that this is only a workaround and it should not be used directly.

Thoughts?

   Wolfram


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX3umKAAoJEBQN5MwUoCm22OMP/3l+aEOc9su+Rj/ssjBggCnO
Cui9NrjafOY1nLWGdsOvKgJQxynKDyuIWqT0C0+VjwMeW/pgnYQVI6s+vOd/uA6s
w4ttZgoW5Fha8HzU0PCd+7qnC6DnGZlVLFim6t6doCktKnhWtroS3FUjLzGYFg3B
2xxSMQRp+kGeJiHZNdeOnh/G0q3LYYTcDctp7b7EO6V14by4mNvJY7Xy4Pp8XBuJ
Gg2IyQQBa9Rer+Pd78LRIlJd4cOZHflWHcH/yyBWe2RhVAo6FVqPBx5W5C3beSI4
gW5A0cuSvJx6udmZgB59vufTfFAvlyXgvcrNGIHs35wmqbajZkCxt0RRdiCm0XQp
/7A3yffe0d9XMPMFx3gLGfVANujh2N0xMToibLecJVpeOJTORcJCK2WxQiFNglLd
SPryTiGAUYGRdpQgE40gfKwkZvrLYhuqgaKYj70hasttM4Ox19SQpjrE+5WjHuiY
eBRA/y30BezF3FyjpKNQ6lkN8N5ia6a3LaFhJQnBTJqlHXNJs16GFQj8UCWkF3vA
io0Jj33gCntqoA1rg5e55qMCqJawcxiY+UyFZjCud9VHbfY+B+3Gh//of2ITS3VK
AG6ME4dvcoNi7reyBUSjzXCIjUNxmL2rHEO/ZDV4B8p24pgYdNYCD/Q5QyK2X282
E/XXkCjYWutmAkInhT7F
=AgqC
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
