From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [BUG] mv64xxx i2c bus lock w/ commit eda6bee6c7
Date: Mon, 24 Jun 2013 20:30:07 +0200
Message-ID: <20130624183006.GA3129@katana>
References: <87a9mkttxr.fsf@natisbad.org>
 <20130623153931.GD7626@kw.sim.vm.gnt>
 <20130623160659.GB17536@roeck-us.net>
 <87fvw8ehne.fsf@natisbad.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87fvw8ehne.fsf-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Ebalard <arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>
Cc: Rodolfo Giometti <giometti-k2GhghHVRtY@public.gmane.org>, "Mark A. Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Mauro Barella <mbarella-RSoB1PSltFvQT0dZR+AlfA@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Simon Guinot <simon.guinot-jKBdWWKqtFpg9hUCZPvPmw@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> does nothing fancy either. While debugging I ended up on Debian bug
> #622325 (http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D622325) which
> made the driver a little less suspect when a revert of commit eda6bee6c7
> fixed the issue for me.

Either wait for 3.11 or pick 4243fa0bad551b8c8d4ff7104e8fd557ae848845
"(I2C: mv64xxx: fix race between FSM/interrupt and process context")
=66rom my for-next branch. (Note the other patches from Russell, probably
all worth to pick). Would be nice if you could pass the info to the
Debian bug as well.

Thanks,

   Wolfram


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRyJAuAAoJEBQN5MwUoCm2eOsQAKjCn6CFcfK9E9sIVe8d3OOg
1rCM2ifERrcG5GjntXmQNRClZWAAOZngRl57KVOIX/3fSTlRRyMuvXR4ttQbs0fT
gr4DP9kcmk4/BPbh7KHN+aC15oJ0tH9c+iJ3TKhtdg2MaD9R5kF844Pr8NjKzZKe
MBkixVYmTV2DWHmhN86dv3ll9AfjYPxCnDr+2IW8tKKEs5VU2ZBuUaFGE+TcpYfq
psX6NalSBVqd9Ef123atmVkpqa7VIYzLvZuo/xRCfOetbgzH6BIQCAdvdkUQqR3j
Sdz3KOo+ERRxxpe4ob5jDNVRP57CCZfRvh2hF4h/1+jEnaGQpvnsh6eymhEGmSvN
PMUKlTok9ShH/70fB6uk/JTRgLuXEpIbs/V30IH2LuUYWY6EEnKNjiceYjab69xJ
AdFyQ21n0Rf5acjBKECHEmk5ysZiWTiWXcS3UZ7ej1/aYCjm6JkdptFpW6zK/Z7V
F03Edlru7FXddPRrGCPyjZbTUUKVf1fmdnjvBR5alLAtr2BEZSeAsOGLtCHdPqoD
EWFpt58NG2CERBBhqLZ7Ix9kr1yLbjp9dC5W0wKM17TscJtVi4YE4nc9SkLXzW2l
6h9TwJ4+0fO42z6UEgxHO1p4fnvSr7ilYEhKxcM7l+rTynXIw2YVNNYLolMXKgk2
mPxnUXYoctPYiJLLFmbu
=62WN
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
