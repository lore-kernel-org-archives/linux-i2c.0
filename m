From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH V2 2/2] drivers: i2c: qup: Fix error handling
Date: Fri, 13 May 2016 13:48:23 +0200
Message-ID: <20160513114823.GJ1778@katana>
References: <1462534274-28925-1-git-send-email-sricharan@codeaurora.org>
 <1462534274-28925-3-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I/5syFLg1Ed7r+1G"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1462534274-28925-3-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ntelkar-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org, agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nkaje-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 06, 2016 at 05:01:14PM +0530, Sricharan R wrote:
> Among the bus errors reported from the QUP_MASTER_STATUS register
> only NACK is considered and transfer gets suspended, while
> other errors are ignored. Correct this and suspend the transfer
> for other errors as well. This avoids unnessecary 'timeouts' which
> happens when waiting for events that would never happen when there
> is already an error condition on the bus.
>=20
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Reviewed-by: Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Please check Documentation/i2c/fault-codes for proper fault codes.


--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNb8HAAoJEBQN5MwUoCm2QWkQALX3j1KTC5jchAVQrvQvkPnh
5PFyEz81lmtHo8mEknp2GFi9xjFI9rFDLLAK7kOJUqgiA02/t7Wg8F8QLdjV7HK4
0hWs4hOsUP9ZRdbN92fWJp1PPODTgE+PBobKs1amTC45z8NNFX7AFiIc7V34RoWh
37FsAcNlZ4WhERZY5ZzrxFAH6mbK4ZnRDKWrXDQ8axL9RaWgJUcOL7Q+BK2jK4eq
44Iw2gcbO+7K1ccxeB5R8/mIdf0FvfVJ6J68lbAeRSEkRcM2o2wQyXIYCXr1njXH
Tm5gea8G10ClMl8E4pxWvq+s2GK1TDyjg2t+kjaYym8xagcJ2n0xBRMCPf8rpoMQ
mlWmNVJ5xpcVeEyzj2LW8GGT6eRbFLa00F7sphC7dZxrDC62Jz2iTSeBrx+X3tXN
28JThoREHmVODGm4q+CbatPa7BsV+zlUTJ6NvESf2fkr36pUFX6tjJR9XCnTIcrM
+u7SHARTU0VHWtFYSn0gbGnP1oWGejFX2yrATBJTBjPe6xJydNnclDCndCUlhfFq
iI8nhOvl4wTuUkFmtGZmk7xmI/M7k7C0lIRzj7X8s8qgOtewU78gLKhvwD8G1ruC
R4ExVKZtIZuTlAQA5fGMrVnLZ1BdNo+dQ4uxpXS0O4MEj7bxea2Sz4hC4AJSAVnD
PNlBm3cWBMI4XBFU0riv
=e+uD
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
