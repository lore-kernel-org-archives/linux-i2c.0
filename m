From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2 2/2] drivers: i2c: qup: Fix error handling
Date: Fri, 13 May 2016 13:50:21 +0200
Message-ID: <20160513115021.GK1778@katana>
References: <1462534274-28925-1-git-send-email-sricharan@codeaurora.org>
 <1462534274-28925-3-git-send-email-sricharan@codeaurora.org>
 <20160513114823.GJ1778@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45wMVEkw4XUbiYON"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160513114823.GJ1778@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ntelkar-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nkaje-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--45wMVEkw4XUbiYON
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2016 at 01:48:23PM +0200, Wolfram Sang wrote:
> On Fri, May 06, 2016 at 05:01:14PM +0530, Sricharan R wrote:
> > Among the bus errors reported from the QUP_MASTER_STATUS register
> > only NACK is considered and transfer gets suspended, while
> > other errors are ignored. Correct this and suspend the transfer
> > for other errors as well. This avoids unnessecary 'timeouts' which
> > happens when waiting for events that would never happen when there
> > is already an error condition on the bus.
> >=20
> > Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > Reviewed-by: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> Please check Documentation/i2c/fault-codes for proper fault codes.

And while we are here: NACK is not an error but a valid response. Can
you remove the dev_err related to that? Otherwise tools like i2cdetect
will probably flood your log.


--45wMVEkw4XUbiYON
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNb99AAoJEBQN5MwUoCm2pNoQAKOgdymmdFmQxQ8QxAqoxj1G
uMdMDfVS563kCoqBBKjR7wxbWXcXaVNZ0WUNf5G5St5MmsxRfjquxBm+xmW5lx7D
3K+5x+Jgry1jGZ7QO5664CgksZJjrZbot1ZsW0vbTKfjaN6HCVawGjBrwpllyQmB
wRkt3hhORdPBAICPdins6Am0mCoqAUAuRf+dj1pRoWbdQE6enYrcA3Kkf0SbGzIv
5j+lucE1maj2XhTZzfsqb/rMbbJg9vmQaw4xK8LtH7k7VCRHbK0/Bm8pd4niSSYO
i3LwVogMDoUkMxe0Seirshqd9jPeZpVczPJqpcHrUqPl+ijSULClX6zdxtQeib1/
4D9F80NGJ6x2g7rgCRT8sv/PxCipM8+JJbkYfxxutixnoiPhwKy2StfeUDBkxvat
kVFJkfaolxrxQ2Mjo83hnneNBRkRh9giRuCh9VLmNfaZSbQDdHXopZN174HKn9uT
bjF4f0jImWqWdqd2v5+xply/Yb9qrXR5Lh/vZwqVpp0YcerQifxccQ6/K1RhBZ7S
R92tItR/iWoEAFm5gAWJ7w8+aSNjlD3SCjqoYmefjshH6xNHvv1+UUCPWH9/T2qN
Ey4/FCsauanzGVxn59qHaouytZwEB2RaMjBYgK9tYwmucLh8FOU+Or2wVQWOEpTz
11JlQbV8vspCtw9sUeNT
=l9K9
-----END PGP SIGNATURE-----

--45wMVEkw4XUbiYON--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
