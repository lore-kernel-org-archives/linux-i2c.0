From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c: core: make it possible to match a pure device
 tree driver
Date: Mon, 10 Jun 2013 15:40:14 +0200
Message-ID: <20130610134013.GA2987@katana>
References: <1368476301-10495-1-git-send-email-linus.walleij@linaro.org>
 <20130607213241.GB3047@katana>
 <CACRpkdbBsXB+9wN0oshfZB8Xady9G_wu9d8UkgA-bYqQe=8Mpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbBsXB+9wN0oshfZB8Xady9G_wu9d8UkgA-bYqQe=8Mpw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2013 at 02:18:17PM +0200, Linus Walleij wrote:
> On Fri, Jun 7, 2013 at 11:32 PM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrote:
> > ...
> >> I2C devices probed from device tree should subsequently be
> >> fixed to handle the case where of_match_table() is
> >> used (I think none of them do that today), and platforms should
> >> fix their device trees to use compatible strings for I2C devices
> >> instead of setting the name to Linux device driver names as is
> >> done in multiple cases today.
> >
> > I guess your solution is the least intrusive one. Still, it could happen
> > that of_match_table is scanned three times (by driver core, i2c layer,
> > and i2c driver) which is IMO an indication to look for a more elegant
> > solution tp find out what really matched?
>=20
> I think that is a generic problem with the device tree
> being completely stateless, and rather a comment on the
> of_match_device() intrinsics being inelegant than on this
> patch?

Yes.

> Do you see it as a blocker for the patch?

No blocker. Yet, I was hoping for somebody perhaps having a good idea.
Platform devices have 'id_entry', for example. Sadly, I don't have the
resources to pick up a similar idea.


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRtdc9AAoJEBQN5MwUoCm2YNsP/1JbiJ/MvBCUE4y9DqURDsum
breTPSrxmwtVhvdWBTOCDo3jMZ3LSW3GBpJ1mXvIkiyyWACHiwUyHXdAZs6u/VpO
f8cz1qguLgALIFYt0lOgOfpYJHP0UHCh+EmDUNq5Pp5FVojDDIabS5RIsAYRPOFj
sbvhB+mnsbV37WN7p36Y22HWv6bQcN0P+TBW22KIiWHwM6lTEmS06Xq/3dexyVQM
5UoUcWg1A76S9XjtqLR8pcVR7Nl/UlfoEIXb9UwVrA+ApqvdQObPkl1V0BB4At3S
qvye5dT35u1p0WbripY+WCCI3qZ3Ceee424Tx2zXMGZoJ1+RsH6o4XpF0aI/mDYC
QQ+inv1nlh/2s41CNfGSa342W0shKtD1OAlnnbYQRJinmCuhUvqr6TFUacyGZqPW
s9NBA0J6a3B2fqjehaOZYSdLNVpmMKvj4FcgScVnUuHtKiF1U8HFLVRW4CZZKg7P
EyH+Izq0uF394UMH4JHbXEGKiEuRxIda8N64esDrbdEr9W4xgItZP9k9XwVg7hzr
TJAuHrMOq4sgSesBEP3aA2fXTFI23xhzEiluEvRdGv9s4acwDYzrsPI/qKMc/gce
oo3pTS2xLOGbcwnSMs0M8/dmyHvPFxZB36aDaGORa53Q+kbfWNHBh3+MLyV7/0QW
YIKA4j5xgnJgriVdcxEc
=qy0D
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
