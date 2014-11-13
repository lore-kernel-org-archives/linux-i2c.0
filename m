From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] at24: extend driver to allow writing via
 i2c_smbus_write_byte_data
Date: Thu, 13 Nov 2014 01:16:28 +0100
Message-ID: <20141113001628.GA2062@katana>
References: <1412845678-18933-1-git-send-email-christian.gmeiner@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412845678-18933-1-git-send-email-christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2014 at 11:07:58AM +0200, Christian Gmeiner wrote:
> I have a at24 EEPROM connected via i2c bus provided by ISCH i2c
> bus driver. This bus driver does not support
> I2C_FUNC_SMBUS_WRITE_I2C_BLOCK and so I was looking for a way
> to be able to write the eeprom. This patch adds support for
> I2C_SMBUS_BYTE_DATA writing via i2c_smbus_write_byte_data.
> It is quite slow, but it works.
>=20
> Signed-off-by: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks!


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUY/hcAAoJEBQN5MwUoCm2ewEP/0RrowN+aaGawFSe2diNsK50
QdRw+AZ2/y6+nXA0OOhS7dZVrASgF14EJZqkZW+21uXwLxPL3csTMTWdbq5JmBr7
EfyFKlvqGGJNvvu2E87qJ3BDwllJW0spk+mZ8jssGDVaD9wh84GVsUyLdq2wOW5h
RiD39d1FWxmFZvUE0FUn2IH4ROGQS/Vw2uuHijQFE18wKcIdHbenfc6X8Phc40gS
wen5eC3NtfLjaALb19EtM4W32ZQa9XVoo6pWe42J19t0kMb4z2Lnah8kIoFvK3X+
fsvmIsrJB6CLZvkbSirVrB7ipS5Ln+b3trpzq5yDTe81vU7tPX1D/7vrtcvqyRia
B/krVVrMRiv68/srTYEPFRATyrz4z85dtIJYfFfP5Mxs13SOwj5h6+NHke5+awwQ
6RtY08nDcATzcO4tuTNIPzsXr/OQ3fqLTplan3WUBzaL1jD+nyFvCWYoVGo6DlPj
l3/RBixs7v330bbBVLUg5UDbrvlwKKS9ii5h/Kr01JDNXJOzMUUjif9KhauLo/rw
MEjrLMSJPD/D1hsV79TzSo+o2DNqNpUHZ9TpPVJpHTyYF17zhVVRP8sbXQxjyOWT
1DOvKPMIJoutbqr53ZIqGzEQHwUyRUpmLohlPQXVWuavQUnDbQrQnzHzlHp5Yrcu
VZgNedEK4t4CGGX8JDns
=jBhc
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
