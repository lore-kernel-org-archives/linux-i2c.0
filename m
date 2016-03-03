From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-smbus: Don't report duplicate alerts
Date: Thu, 3 Mar 2016 21:57:54 +0100
Message-ID: <20160303205754.GE1711@katana>
References: <1453222848-20457-1-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N1GIdlSm9i+YlY4t"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45027 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbcCCVAU (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 3 Mar 2016 16:00:20 -0500
Content-Disposition: inline
In-Reply-To: <1453222848-20457-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: minyard@acm.org, Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, Corey Minyard <cminyard@mvista.com>


--N1GIdlSm9i+YlY4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2016 at 11:00:48AM -0600, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> Getting the same alert twice in a row is legal and normal,
> especially on a fast device (like running in qemu).  Kind of
> like interrupts.  So don't report duplicate alerts, and deliver
> them normally.
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Looks plausible to me, but I never used SMBALERT myself. Any chance this
can cause a regression? Jean, what do you think?

> ---
>  drivers/i2c/i2c-smbus.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> index 94765a8..cecd423 100644
> --- a/drivers/i2c/i2c-smbus.c
> +++ b/drivers/i2c/i2c-smbus.c
> @@ -75,7 +75,6 @@ static void smbus_alert(struct work_struct *work)
>  {
>  	struct i2c_smbus_alert *alert;
>  	struct i2c_client *ara;
> -	unsigned short prev_addr =3D 0;	/* Not a valid address */
> =20
>  	alert =3D container_of(work, struct i2c_smbus_alert, alert);
>  	ara =3D alert->ara;
> @@ -99,18 +98,12 @@ static void smbus_alert(struct work_struct *work)
>  		data.flag =3D status & 1;
>  		data.addr =3D status >> 1;
> =20
> -		if (data.addr =3D=3D prev_addr) {
> -			dev_warn(&ara->dev, "Duplicate SMBALERT# from dev "
> -				"0x%02x, skipping\n", data.addr);
> -			break;
> -		}
>  		dev_dbg(&ara->dev, "SMBALERT# from dev 0x%02x, flag %d\n",
>  			data.addr, data.flag);
> =20
>  		/* Notify driver for the device which issued the alert */
>  		device_for_each_child(&ara->adapter->dev, &data,
>  				      smbus_do_alert);
> -		prev_addr =3D data.addr;
>  	}
> =20
>  	/* We handled all alerts; re-enable level-triggered IRQs */
> --=20
> 2.5.0
>=20

--N1GIdlSm9i+YlY4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2KVSAAoJEBQN5MwUoCm2kNYP/Ru4LoIDOH4qRgF4LEiIM+Gn
DaPW4m8j9ohfF2GVmTEsOOcVFJhSCruWXN5q4p6qaWQ3ks8vDBDrevj5vnh9bObk
9WOFgL1Hl+7ocP6YwSYFdor6R60P9GwQSuMKLK9H9c0d7iHwExm6HaYWHm1F56k0
bgPGFFIb6+c+6mZb1nGW+IaT1FveM+/zZURkm+u5x0g3cPmAAjDRC79OVB7XM32T
3SyL0GAMJCW9s/tKHBnbviRh4vwbzX+aQjb4sDhRkxvTZoktndytgQ+KyvSNndAa
83YFLU01KGcz0oSlONH1wO/gOuvMbQXpfflarDDKutEck/CD3ufJjFaenF6akCyc
/gGJPA7/54yj0GQh2VMYNwF3WGJZ1f6R3SdNRvf3vZkoQOfxFXdi7pPYAkeSbVnS
gPU1MYNfDYph5b6fh45k/ZrcRLbbrvhvZ1eAUDKRoVlKEmgZiNhLNft7RhEQTQXj
CpeA1wzwHpqatBFtG/FvMe88mGob+TYDCUaw87Q8JK9ll4TMtOsQCOrjbHN65QqU
cGtsPt1h0v6H+VhglMm6b6z+ynqRkFgLMgM/6mEiLr9sGK55rDssoNGica3BEQWA
rkhodqOH6+7cmwXTUWLyTMRCpGZ1MvwY7pQG9GSkECfytq+x12RC31I4kRImXhA7
wix4lAfw0Dy9SuVKO6iT
=uEeT
-----END PGP SIGNATURE-----

--N1GIdlSm9i+YlY4t--
