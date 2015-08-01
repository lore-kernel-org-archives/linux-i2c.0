From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v3 2/8] eeprom: at24: use
 i2c_smbus_read_i2c_block_data_or_emulated
Date: Sat, 1 Aug 2015 21:57:56 +0200
Message-ID: <20150801195756.GB1590@katana>
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
 <1435916017-12859-3-git-send-email-irina.tirdea@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435916017-12859-3-git-send-email-irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +		if (at24->use_smbus) {
> +			status =
> +			    i2c_smbus_read_i2c_block_data_or_emulated(client,
> +								      offset,
> +								      count,
> +								      buf);

Please ignore checkpatch warnings for this one and find a nice readable
way to squeeze that into two lines.


--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvSTEAAoJEBQN5MwUoCm2/T4P/i6/AIs/wo0ZLNCEl5GKUDnv
/xSwVvJc25837a3HkhIPzlpu+mfoUAzX5VQBrnF+uKFZADr8F7n6wpeT53w5RCGJ
HaC6wpOpSQEN0IrB1V04f4Ek3dt2nUUEi+t1+fZhQn5uRG/k4YKnEx5zp+7K8NSO
/x6WsI3GEZWSTI7+gBfGf3d54pg5XJQAoYB5RnOXASP9Uh3WVqzNtfDRGfH3zzFD
Qb4YpQDrlaAZXo2ywa+zcACbDRQP5XnWxzc9s3apj1LImiym+6M/VXh4Gpr6kt/W
ohY4opxUNROCCeUkmbQDIK31XAbe37aOqacIttTlqbmigkJlACYOS2VaFW6x09Gk
Bq3DGt66loou7bVB79w1Ch06oVjs74x8suCTukMBAeemjHcdoV7gpCHRaui3HUNR
OaJgy3gUQFNJS3D3eiDLnVDPcS8KhMj3+oZMyS0rfUFfbwYYdHJTMboBGasAgmDI
t/x3l9RqEUSy/0ioGmLzXnxNC9Vwp68PWCmCkVIKHZFJl5siCpR740KhVhKZ3nz/
VV9s6R+Jah72Es9iV9Nprsyxth3jne3fdiTYxRT34ZPQTEettUzdjeXhlHmMHacS
dfZocPohWHoXTUM3Ly/sdjA+f7/Ms6SjrZo8ALoxMYo6Utu8mREAShxp0gRJNpzI
6tB8y+HFFcXH7OYMZttq
=2vqt
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
