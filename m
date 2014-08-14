From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: i2c access from kernel
Date: Thu, 14 Aug 2014 04:35:18 -0500
Message-ID: <20140814093518.GA2824@katana>
References: <CAJ2oMhK_pz4uM5BipEmajtQT1Q-BvVX0+-98ceb5nbPBuqKq3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ2oMhK_pz4uM5BipEmajtQT1Q-BvVX0+-98ceb5nbPBuqKq3g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ran Shalit <ranshalit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> The first argument to i2c_transfer is pointer to struct i2c_adapter,
> which is very complex struct to fill !!

You should never fill it yourself. This is the job of the i2c-core.

> If I know, for example, the exact bus number, is there some way I can
> get the i2c_adapter pointer to that bus ?

i2c_get_adapter(bus_number);

Regards,

   Wolfram


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT7ILVAAoJEBQN5MwUoCm2eH8QAJi+2p+vsgJaFW63u2HC8A3L
nswEuEwmYpr7eQ9HBIQ5BmXeuFOxvh9RTQCTlpJqu7QYd1YURPaR8Ywpg9Lbj41V
p/iuzZIiDxIe0M7Oc/Zk7TQhzSBZ36AmyHrlhosMY1q/7+dwPvUKgWYzYRUFyVtP
jikwNT6lkiUCywacBrzTG9MS4ao3aWoME4qxjxsfERlTqs7G0FWbdVYcL0E2B8RQ
rN2P+Gl49jHHBwiIR/wQH8Qvol+szG/+FZykQJ5DlBrgXmjjV9CRhDpy0hDLCvLq
JjAE0fLiamse2OyQmhVF8seB78gSFEgpsX+1JwCftxHC9wws6taQ14rcKFWJXQz3
10Rjof2qXVMy8LZyObgFZzvX1+WKwhStozfJMgnERAz13pVm+GiEWC5wh7P8eZG0
c82mZTP1Eb4ztlDwFH6NFH5WIwpNZXEmI4494d4/vxuwL+vd30VDrQ3fyPKq7RSf
/xlW7A/qVe7+6x2B7cNTlTLGj3iviIAe+HWZL7Lfc6plxOW9AQSfgu9sJUAmIaYt
CZ07E+Q9Muuw7fw9F5YN58qwAV+hSScrzv/Q0fsXOtNljrNrOpbb0RNBiC37Ye1l
uo0Q413mzdh6CLax919c8VinBkaoybVY5yn3c+/3CC/fSKFEThfN/RjijNIiHu4g
bMBbkCcesSUjaddQ22tl
=P6jv
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
