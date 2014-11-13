From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: mux: create "channel-n" symlinks for child segments
Date: Thu, 13 Nov 2014 14:41:28 +0100
Message-ID: <20141113134128.GB8025@katana>
References: <1415363764-10821-1-git-send-email-wsa@the-dreams.de>
 <CAAVjN7dR0DYmuGOeMtVzsf-K7zsxXEY=jrGg_+V4XuyZhcyfiQ@mail.gmail.com>
 <20141108175117.GB4900@katana>
 <CAAVjN7fJ0d2-Rp_9poPxMbrCVmz9be7-yZCE-Z7Vr=E4L8rpAg@mail.gmail.com>
 <20141112124231.GA1289@katana>
 <CAAVjN7eG1D2fmu0gBqR8bwuo1i6e0XWju02JwVaO45YAr5qNkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAAVjN7eG1D2fmu0gBqR8bwuo1i6e0XWju02JwVaO45YAr5qNkA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danielle Costantino <danielle.costantino-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gerlando Falauto <gerlando.falauto-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Martin Belanger <martin.belanger-Ir6+u9MVKBtBDgjK7y7TUQ@public.gmane.org>, Rodolfo Giometti <giometti-AVVDYK/kqiJWk0Htik3J/w@public.gmane.org>, Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>, Jeroen De Wachter <jeroen.de.wachter-CNXmb7IdZIWZIoH1IeqzKA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2014 at 06:15:10AM -0800, Danielle Costantino wrote:
> Well the patch works (and is cleaner and uses slightly less resources
> and is how it should have been done originally)...but it breaks my
> current API (the path parsing will need to be modified) (parsing the
> parent device name (old fromat "i2c-%d" new "i2c-%d/%d-%04x" id to
> determine the parent adapter id). I can modify lsi2c to work with this
> new API, and it shouldn't be too difficult. But I cant update the tool
> until this is committed.

I've sent a V3 of the whole series a second ago. This one doesn't break
the ABI and should still help. Please let me know what you think by
replying to those patches, not here.


--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZLUIAAoJEBQN5MwUoCm2IhMP/0vUx6bbf7YJvoOzZCYH/+H2
2u4gpbtkbdrz35U7+dYWBl1peudyjNsUZbu2XM31nVfEEqnM0a3PaLEnLSy5Uaj9
jZeMBGsjaz3Oabto51aKhiQF77H4RTyrOLWRi6UovVVFJrtBaKkZhlTcMUvU0h3T
9+bhxyIN0aodDhvEXCXHChu0dJDoMWWtf6iTtrXKIZUJV6dQdqQGLzn4t2M/O7TT
UWqG2e3UnUTzPTar4IYGWFcIKFbYvHLmJlClUu0ltzy2x8ZXgfdHlrkwjbqKxd8P
95Ukp8jeYCwW65ibc9KiOzs4G33XHSDCebAtwnnMBSVmq6mxrBmV5D8kIYo60sCE
Wcmo+8YeC06lbLioDisvnG/pZjjfAFoUfcebkOsUM9J0aDSC3fKCjyp9o9+QGreu
CqX4cQUkHbFXiyJsbW7PWLOrnhoRH5lNsDS5Um550lcon1KafD8NwgMJYU1Tcqn8
v19oglkhbIzBXVVmgv5CbpIfqYu7ylfEYz4YuB+fJkaD0lzJfzh+90U++pNt/6K7
GiS6HZWbgUcrBmDyYAPws/pMq1z5PGfK78sA6MW5RMIVtekm1mvAvITeSy8n0HUW
wgVgiHaGuTsNWu6fkQIitj8MCM0mFr6zCv+g3MZ0RpfdNj9oWd+D9Dsc1FkKJHBx
GzEyyC+QsOV55h4Il3s/
=R7u2
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
