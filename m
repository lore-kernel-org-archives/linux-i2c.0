From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 5/9] i2c: at91: add support for digital filtering
Date: Sat, 31 Aug 2019 14:13:08 +0200
Message-ID: <20190831121308.GB1032@ninjato>
References: <1562678049-17581-1-git-send-email-eugen.hristev@microchip.com>
 <1562678049-17581-6-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1735855435754395396=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1562678049-17581-6-git-send-email-eugen.hristev@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eugen.Hristev@microchip.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, pierre-yves.mordret@st.com, Ludovic.Desroches@microchip.com, robh+dt@kernel.org, linux-i2c@vger.kernel.org, peda@axentia.se, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--===============1735855435754395396==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
> index a663a7a..62610af 100644
> --- a/drivers/i2c/busses/i2c-at91-core.c
> +++ b/drivers/i2c/busses/i2c-at91-core.c
> @@ -68,6 +68,7 @@ static struct at91_twi_pdata at91rm9200_config = {
>  	.has_unre_flag = true,
>  	.has_alt_cmd = false,
>  	.has_hold_field = false,
> +	.has_dig_filtr = false,

Hmm, 'false' is the default. Maybe not for this series, but it might
make sense to clean up the driver afterwards removing the superfluous
'false'. The precedence will make adding new properties much simpler.


> +	dev->enable_dig_filt = of_property_read_bool(pdev->dev.of_node,
> +						     "i2c-dig-filter");
> +

What do you think of the idea to introduce 'flags' to struct i2c_timings
and parse the bindings in the core, too? Then you'd have sth like:

	if (t->flags & I2C_TIMINGS_ANALOG_FILTER)

Would that be useful for you?


--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl1qZFAACgkQFA3kzBSg
KbZy9Q/+INNWAz3JzNTnt9Wz4LY+CvF0A91qTijGhOFME8qnJRK/bGoupXNI66Nm
mhn3iko1RoOsrBzEI1U4bc86Y6O2dZZMscDU8Kn5GanaK9OzMf9WLnRlapIrKg35
HwC+M+XzDLTkwfFSGBAzA2m+Ud5bS9rzJ8svbrLBLov3x4dka8S+ZwLXH7mpW1b4
80vHk8nqtJ3CUI9wzfUSBqkPxoszergUiqXW39VI12UBmY0BWY7swIcVoehErLvh
o7hWyfuoKyhR+NQHkbcHfa4YAyzwILIzE+7OsYlyQXZvh4Wb2KgbMlyi3OldAvkw
8JFJRHEMAjH9HiLpUr1uV+yabhhi7AxWtx3WEFMc0+/QB4Ed4lSgWKNM9LJmUV4t
nJffamNfsMT6A9oNULQV3VaSYwM7G/f79h/SQLHIgmTjc9v4XXh9EOs5YhYEhfYE
8tWeTOG4Lzg1BCn2FcDBUIChJcp1YKD+e0nsskqt1Sk9GUE6MU64h075JqZ1iDYM
4wloxXGU09C6IahnAhx1HEFDi6Ym+oaWDGGhloqSh4cctuEOO75EaD0A01hEVgtk
o3Qf4dWCC72yeKC5zn7GwTkUTZc66G703dKCXUUnQJ1bljY/8Z4Js2YrDpizfbai
JmBYGOZw5ztqQt0x2N9QW78hvYoK3eotQ0bvwhHqPu59bbHVxbI=
=z8HE
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--


--===============1735855435754395396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1735855435754395396==--
