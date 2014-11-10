From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6] i2c: rk3x: adjust the LOW divison based on
 characteristics of SCL
Date: Mon, 10 Nov 2014 15:58:52 +0100
Message-ID: <20141110145852.GD10422@katana>
References: <1413168244-3553-1-git-send-email-addy.ke@rock-chips.com>
 <1413266961-3859-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1413266961-3859-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 02:09:21PM +0800, Addy Ke wrote:
> As show in I2C specification:
> - Standard-mode: the minimum HIGH period of the scl clock is 4.0us
>                  the minimum LOW period of the scl clock is 4.7us
> - Fast-mode: the minimum HIGH period of the scl clock is 0.6us
>              the minimum LOW period of the scl clock is 1.3us
>=20
> I have measured i2c SCL waveforms in fast-mode by oscilloscope
> on rk3288-pinky board. the LOW period of the scl clock is 1.3us.
> It is so critical that we must adjust LOW division to increase
> the LOW period of the scl clock.
>=20
> Thanks Doug for the suggestion about division formulas.
>=20
> Tested-by: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
> Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Tested-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Applied to for-next, thanks!


--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUYNKrAAoJEBQN5MwUoCm2JxgP/RQ0ca7fvIybu+DF9BRhWKct
ZqrnidDANnw/hRQiyIs7ueuNRGnZrRgSva2MzJzLpzWgfpzcALehXZvSE8XzAN1T
EBckkq+FUiAAVkYREsUIGYmVhYOjcjQIDW9seDXAdXncWtPvI1U+31dIH7phCy3O
Id3XgdqzoXbuzVzmBXSK95WXCeQUeuFXz/Iwj3mnhhA2iKRx3Szzj5XHll+l1oRv
N/aNWjLuXo8AMpfGiT1LfHcF5FMG5HdM8EqkMiowz22v5ClYBuAcg7ietYkuGqyC
DNHoZKniswntUuqcKNId2fz2xwj+XLGtPH0S2x7YDUH8Te5te0bR+vMzQAwvcWFL
KFnHhVQbuSj9/MJEZCGEyWcNxqDNRMgqqb8Un5AooYeN7ZH6RIgfKH5G+s50ON/d
JFCS9VSpePKAGgjHpxt4aEUHXx0ux1XDWRQwTGFTTR5xzoGeHXNOA2r+pjfaAj8b
F+deNxOpL5QNGj+sdtTnH4FtGWHGSYc2T05+YHYC4mZOjVpgdBUAtcquh14RrYrB
dq2Gvzjkrf+AnqXkde1JR6l8tvtKpBPwTSswk9c6nlLUGYN05U/GRjMuizZA8Xys
hfhJKADBII6hFRAqJY5EufocpI8LtCWPfgGQ+IqaaWNSFtYAvYhynGWFhi/YMG2q
NUMZuJ56Ut9NGbIq9Ekd
=5uV4
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
