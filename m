From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v2] i2c: i2c-mux-gpio: update mux with
 gpiod_set_array_value_cansleep
Date: Thu, 24 Nov 2016 20:52:30 +0100
Message-ID: <20161124195230.GA1666@katana>
References: <1479908035-18284-1-git-send-email-peda@axentia.se>
 <20161124151420.GF4271@katana>
 <46be889f-a558-0174-f638-c685b23c8ed9@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39464 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941134AbcKXTwe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 24 Nov 2016 14:52:34 -0500
Content-Disposition: inline
In-Reply-To: <46be889f-a558-0174-f638-c685b23c8ed9@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Yes, I never liked that include, but I don't know how to get
> from struct gpio_desc * to the relevant struct device *
> without it...

Looks to me like we should ask the GPIO maintainers if they are willing
to export this value? I am probably not as good as you in explaining the
details why, though...


--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYN0T+AAoJEBQN5MwUoCm2WPoQAKbMGZEziYpp/bQnLEALFcU6
WpHTmQxJo5SQ/gQMmUbMtpUhFqVDpn5IBZ/gjgKUZxR0zOV+QGtlOsgg/X7ooHfw
ed4D2lX7xOa8QIe5qaF4ohASFogqg/4JW2iwYYgAvETz3w19I2Yht2Zdd3Y7FlDh
z1Ti3XvHeTqyyUdIbkS9AsxqZAqdOWnZuBi1IdzWm+OINQ7zNtMfTJUHvGRLWPjQ
WqpVOjq86ZM89N0DHj262uAdAuTIy0OSUECEU9qalzNkwxR0MHSaCg0SbbY5QA/w
CBvAMAvbJpd7XygUqoJ1mwAff27bIyjqnzsz4GzQX7qix1akyiyNdyeOqZONM5XB
LP4yd03zOZ/wOlzeSFoPG0qgewVYE2D28N0rhiI2li7971m+/D/St7nH+OQWpa52
7Opt3kEnL7ngjXydB4SMnuLUOMslFxjPAC3JLwfqgguWeaIlIcCka+JxHkGH1m8w
U4jIIzNTvPC/G2W/HIXb6cY2tDjCFFIn+f4j7uCdQT0LfD3mnEeDg0CgDEVeKr8t
nhvvDI7mGQOeX35x60DSO/8sRsav3T3n/F+KcJqSWjNDewGAgUxJCaYa4w5o9fG3
rx1cRr9T7ai38TYy876vbFDTXe1up/nuE+B3nZSnG4rnTLlGw/fApaVcZhWUxVqk
bwpSMJSZKzvkuwD/Qhc5
=f8My
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
