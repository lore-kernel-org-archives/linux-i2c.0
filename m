From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH V4 3/3] i2c: qup: Fix error handling
Date: Sat, 18 Jun 2016 18:25:48 +0200
Message-ID: <20160618162548.GD3017@tetsubishi>
References: <1465582101-19391-1-git-send-email-sricharan@codeaurora.org>
 <1465582101-19391-4-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465582101-19391-4-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sricharan R <sricharan@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, ntelkar@codeaurora.org, galak@codeaurora.org, linux-kernel@vger.kernel.org, andy.gross@linaro.org, linux-i2c@vger.kernel.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org, nkaje@codeaurora.org, absahu@codeaurora.org
List-Id: linux-i2c@vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2016 at 11:38:21PM +0530, Sricharan R wrote:
> Among the bus errors reported from the QUP_MASTER_STATUS register
> only NACK is considered and transfer gets suspended, while
> other errors are ignored. Correct this and suspend the transfer
> for other errors as well. This avoids unnecessary 'timeouts' which
> happens when waiting for events that would never happen when there
> is already an error condition on the bus. Also the error handling
> procedure should be the same for both NACK and other bus errors in
> case of dma mode. So correct that as well.
>=20
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Applied to for-next, thanks!


--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXZXYMAAoJEBQN5MwUoCm2yrgQAJlBYCkXq47fcbBUw6Wo1duP
2tXhEdz9h183Ye5lJZjD7uEIPgo+jhEu4CFc09RvVkb5YycGZI8zot+ozbPaMLFy
DDNsasEMT0XLd4Zw3Gi142YYQ3MGWQbO71qJ8UjVqNHLJQPCScICggyuoLeQKuiM
W5WQsldCjOVly6X0ag/CHZZLxVSVBhxCSkgQD6tvcyEFALGxscbwVALjGwMC25YO
DoSkYwIioAdstqZ7Cg44Vze/Tw3hctB4hVoQ9UsbjW6SxPhBStcl3OwFqtzgmip+
nvVqemykO2KPBMSsloVVRKfJwCPQ4BeXqPCwj9MVr/HehwpyipPIV+9xaX5NIBwH
YE4HW7l9KpCQyrf81+SD9VsrA9w/zSalDRB6vYv5RXNWykvPF0rlKzO+iJFqiWw+
pRDsgaaoKCvqk3piyKQQWbP23eNcGAGjEbWizRLc2kmTRoh/pFoxxqT63lN/QtW6
vSoy+lDAjC6dCtWVPYLHnp9RY4NgzPK+WOy9j/rvInalDUhkDH8xonlBcOeYBbAM
BRp6aQ+8OaSRi2prWQnM3zj3PooMgs3HXMIy8wrKcBLG4yKQOR0QLzhS8kaU/DCr
PhtIfh0IuBTh6GsP+nTKJLySelkCVh75uhIuuru0EWmg2xexW2TMvFuTesqLA9ZJ
Amk9ow7Wka9cx6qF0TQK
=RVHX
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
