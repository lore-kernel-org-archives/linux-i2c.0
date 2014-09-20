From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-ismt: use correct length when copy buffer
Date: Sat, 20 Sep 2014 14:58:42 +0200
Message-ID: <20140920125840.GH3850@katana>
References: <1410859264-7118-1-git-send-email-fan.du@intel.com>
 <1410859264-7118-3-git-send-email-fan.du@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtJ+CqYNzKB4ukR4"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410859264-7118-3-git-send-email-fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org, fengyuleidian0615-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--vtJ+CqYNzKB4ukR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2014 at 05:21:04PM +0800, Fan Du wrote:
> In block write mode, when encapsulating dma_buffer, first element is
> 'command', the rest is data buffer, so only copy actual data buffer
> starting from block[1] with the size indicating by block[0].
>=20
> Signed-off-by: Fan Du <fan.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Applied to for-current and added stable, thanks!


--vtJ+CqYNzKB4ukR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUHXn/AAoJEBQN5MwUoCm262QQALTAZRpteucnobAZDUWPF6Ab
KM40Wlby4xn61+wZUEZIUj5uO8tAiY8mSUvtSOAaIlTJPu0L2DYwwcmvKdWRynSp
VCktOGOfkZCGXvvLbvRouxeDvoEevwK38Dmnfjvyo5QKqO2MtYjx4iOu2HLEieFC
a2ZJktv+DeIyBuFjvh/h6t10VSlZxZM5KR2zaGyO6YORZRtxa2n1DG521veMgdWI
1IS7F+yHCqb6ZUhJMWwvaV+IB7/gFMV4ywOMHyJeTYAaXML8lAg4vqs2QBZNm6Fh
/xf6OxzAlURaePzcQlcIBWu8P3M+SL+pRqeh3NV8h/zV3xDj3fQcBS/9xWwgnbGJ
hQHXu+D0hPbEVLr8WI+OLqmOk7Q8HgzUd1j+BKaG9/XZ0pIAILzSdbPPHmEJ6cEK
9UwbI1Uf3GFu/b9dw7Eu613aWD3KaCbyLXWrh9XKqtUIaAqjEbBD3DbPliZo1M9x
FZxFbQzuCnC+L4NaMfxLVqDs4O+z4/IqoPkZDtTM7k3vr0prVbyi2cfaKfhhHKwq
m6/GQRwq27LAte15NdGz9348MIlqmOIFBpGhXjWUIkplVEEotCXpFkr64YxHlsXz
trnjeEKWQM7nEhTh56Ey7OtuXASrRXktYJ3k6NulUxe/5LLVmnJH7dQFf+ApYrvA
1yC/vbK4hz5UIX0qxvwU
=5piI
-----END PGP SIGNATURE-----

--vtJ+CqYNzKB4ukR4--
