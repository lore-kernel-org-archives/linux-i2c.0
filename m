From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] of: i2c: Add idle-disconnect DT property to PCA954x
 mux driver
Date: Thu, 15 Jan 2015 13:32:37 +0100
Message-ID: <20150115123237.GC2549@katana>
References: <5494599A.8050803@nsn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5494599A.8050803-OYasijW0DpE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Cc: jdelvare-l3A5Bk7waGM@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Lawnick Michael 61283229 <michael.lawnick-OYasijW0DpE@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2014 at 06:00:10PM +0100, Alexander Sverdlin wrote:
> of: i2c: Add idle-disconnect DT property to PCA954x mux driver
>=20
> Add idle-disconnect device tree property to PCA954x mux driver. The new p=
roperty
> forces the multiplexer to disconnect child buses in idle state. This is u=
sed, for
> example, when there are several multiplexers on the same bus and the devi=
ces on
> the underlying buses might have same I2C addresses.

Basically OK. Question to DT maintainers: "idle-disconnect",
"i2c-mux-idle-disconnect", or is there another existing binding we could
use?

> At the same time old (and not used in the tree) platform data binding
> deselect_on_exit is removed to simplify the implementation. Old binding h=
as
> different (per-channel) semantics and doesn't fit well in the new concept.

I'd prefer to keep it. It should be only one || more. It is not really
in the way IMO.

Thanks,

   Wolfram


--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUt7NlAAoJEBQN5MwUoCm20wIP/0tKzVdSapjhtMaEhGLsWYMc
4HnwjuSNlWFZnOaRkJG4nQkH12NHcR/tU9YxS44N32np7hd9mLOIHfp8ZydBiEd5
4SfMJzl7PmPVkFOg5d5BiGkxOhk4TWsZDw8laNs/DhyeQ32nN85kcK4abQYe/Jf6
AJe0YefBaK2FTkGDKsZkxnWSVQjcNsL0PiV0IbYzq7EcACVczKCIIzWYrexzvizQ
j/ljL7TYkOGTWH22f8P+VHyFLiNkcSs/ZCUSwcMf40jw2xm6gEZTdb5QM/KPoS9D
fri7Mp1bzqRmjOIJV0VWwCEhTSqCxtN9Zq5mTS9a7pJp/OU7pbzp8k0ObNXh28Bn
gdZJjBRApJlQOkk0duyqnB0hxa+pgovdm8ZW2v5peitCfuXWNTpG9uT/GAa8Zf8Y
14RIufjOXjsMz14uCXLC919YuZ4ItOHLS76Yo+2/Z1kaV4Y6cwVIiCbnMQoDpDpA
AxZrjvJmrNYb7UKDBHv8vpiBxM9kfDFTXMVGnlLuTaF3QueT58GpEEc4CDyDsbCi
rMU98ulNqoo9d1mFbMJQW53jMSagLO/8NzpDJX69am0PM3w4eP8cowpeewk5mxt+
gdZsbET+I8JIhfZcIRZ8w3i6AbDj7BVjVBCxzAdV6OTUH33nFkCHWGRCj5zgL+Kf
YJlGeVG4tm3rL/mRVQpI
=0zMi
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
