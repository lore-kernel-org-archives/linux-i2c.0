From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: core: add support for read commands longer than byte
Date: Mon, 10 Aug 2015 12:34:05 +0200
Message-ID: <20150810103405.GA5698@katana>
References: <1437744042-24471-1-git-send-email-cmo@melexis.com>
 <20150809074006.GC1526@katana>
 <CAKv63usiWb4QgV=pnwuqFJtTogRca7UjtmiSKV69OTM2h7LtHw@mail.gmail.com>
 <20150810091352.GB4682@katana>
 <CAKv63usQZBqjcAWFEpFvkRuGLd7JXcJh=5aKmd8B94A68dsZ7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKv63usQZBqjcAWFEpFvkRuGLd7JXcJh=5aKmd8B94A68dsZ7w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
Cc: "Simon G. Vogl" <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2015 at 12:06:07PM +0200, Crt Mori wrote:
> On 10 August 2015 at 11:13, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> >
> >
> > > This debate is what I wanted to have. The new Melexis sensor will be
> > > using it and since I think some others might also be using it in
> > > future I would rather put it to i2c. It is more i2c command than
> > > sensor specific so I think it fits into i2c.
> >
> > There is no thing as 'I2C command'. There are just I2C messages combined
> > into a transfer. I think you mix SMBus and I2C terminology here.
> >
> This is true, but write/read sequence can also be a request/reply
> which is basically a command for reading.

This interpretation is already a layer above. In I2C, you send a message
and then you receive one.

> Same function as my exists in: ./drivers/base/regmap/regmap-i2c.c ,
> maybe it is better just to use that?

Yes! Should have thought of that. Plus, you get more benefits like
caching if you want.

Case closed, thanks!


--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyH4dAAoJEBQN5MwUoCm2HD0QAKt0SROfSkP8CgLOltWUK8uz
iPmwvCQJbMgm04/gHFkCEvvHdU7i5VS9q1kscxit3/7JLd61IeE1fjL6ilDItL00
MP4h0fbzVHLhVltNyHctlpIaz+kj6ELb6llMW/r6bLFJDkW2fkDEzJCX8PBb9WWT
Yq+V2Fm6qledvw2zmEpgLb7aXxWyW9kQTJJxs8+OQjiaa4bsPcf/Z+M9hCODWhUh
eyg4ChhxJbPlHTQCIhH+SX9A0lRNe5Njn5ytU5kGg0/2+Gajs8DkX0lC9yt+rccj
f4WDgIVC876QSAur2trr8Jbua7xj+5lSMPxFuMA2F/CVzDbNwkJS/LnReFNSOGgv
h0t6dhpDefsLVtQsrM84A3l5gAc4+Rof8OAoih0lpKLM54SHOWZFJOeZY5T05ves
1SB0jIIS/E3mAWr8aYcJqVzM4sH/35c4+daz9/clo9SffiO0JxZ0QBSXfuNMOVh6
H8lBiLlLwNzKBhmq8xvfn5Zg8V2M5VWRN4v1oFRsiHHQVLsIYLFw8qcReJeeoCFy
Xv6l4QKAGCwWMbaOfG6G0bc2uf/gjxbzxtKIcteO/hAKIB5kEPT3+uwIn/QXeZKn
3Ld3nmQkC/in/6rWUHSj1/kQ3ViZIssR+X5y2EjSNSvR19FVF4xdp9rp6SU+0hko
3CiV7lf8hNi15OT49uPX
=KOD6
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
