From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v4 0/2] iMC SMBUS and DIMM bus probing
Date: Thu, 15 Aug 2013 14:50:47 +0200
Message-ID: <20130815125047.GF17155@katana>
References: <cover.1374171757.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1374171757.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 18, 2013 at 11:36:52AM -0700, Andy Lutomirski wrote:
> Intel LGA2011 machines have dedicated SMBUS controllers for DIMM
> sockets.  Because they're dedicated, they can be safely and accurately
> probed, since all devices on them are known to be attached to DIMMs.
> The devices found are:
>  - SPD EEPROMs
>  - TSODs (Temperature Sensor on DIMMs)
>  - Other interesting things, with drivers hopefully to follow...

Just to let you know, I keep thinking about it now and then but have not
made up my mind yet... still at it.


--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSDM6nAAoJEBQN5MwUoCm2ugIP/29+5hGyz5IHf/UNK0u/duRr
40b1uhxMgh24QLyUBq+hnMcedwFx9W/+JiNPP9To0acjViTcqpu0OAZGchqSNF93
bF7yTswp4TSC35kTwSqjkkwMr8liN0+fy6RTc4WOHRDFAmKYhFyHMMiOv5UVyVe4
AAYLA/jlFZfkiew15NLxd6Q6iNnhI80SwivM/JChgcTORlUhgI3LdBwc3glTszV6
tVc8ibiSgwCk1e9MshvFAGu0lYyfbG2jYA/v5E2hbzxFuFfixRVl2cXcgqvxLohA
wqhgBSAod+SdK9nytWoKhZXVGr/iUE9SabhhIUUjGyzoE1fqEPzn69ebcYScWkl7
Kg1jnzVREndiqieDLxUkCTEA48z75feWEtdkARManShFQs9yTr90lwYALAhL4EQL
tyvWnaMW+vuP8qYVLQT3SQ9kPflq3rUw5LNu4pnLP53QQBxRbprzUEMKpaWZ08NQ
wALcE0ACk6h+0v0fy+YYvB18+REZhuQYoNB/bnSzZUQcMVvFSf9WeE2Brymaee2Y
VGmRMwqheoDBgL3D2dL5hkp8zP2kBRuOIXqPlaAYfnBimurQxLdtD7SpyQnfsucQ
BYUMyUUv/uPhDTVwkV8+FeevTPQMUtGREnndyxdNAR+zqw53iefkv4uO4vT+TgrU
KIq2D0TpMcoz5ZvljZRh
=gwc8
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
