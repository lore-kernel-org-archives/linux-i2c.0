From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [patch v8 1/1] i2c: add master driver for mellanox systems
Date: Sat, 19 Nov 2016 22:04:44 +0100
Message-ID: <20161119210444.GB2856@katana>
References: <1479455458-157627-1-git-send-email-vadimp@mellanox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1479455458-157627-1-git-send-email-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vadimp@mellanox.com
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@resnulli.us, Michael Shych <michaelsh@mellanox.com>
List-Id: linux-i2c@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

looks mostly good. I just found this comment which needs clarification:

> +	/*
> +	 * All upper layers currently are never use transfer with more than
> +	 * 2 messages.

Have you really checked ALL of the upper layers? And even if so, there
is the dev-interface to userspace which allows for arbitrary I2C
transfers using I2C_RDWR.

>  Actually, it's also not so relevant in Mellanox systems
> +	 * because of HW limitation.

What kind of HW limitation do you mean here? Can Mellanox send more than
two messages?

> Max size of transfer is o more than 20B

"is o more"? Typo?

> +	 * in current x86 LPCI2C bridge.

What does that mean in result?

Regards,

   Wolfram


--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYML5sAAoJEBQN5MwUoCm2sUQP/3Q0yjkFplU6rsCyMTu5TRhg
GWBK8xG25S82FJUUNiDG69j8akffMyGqMoCjFQ0fu5pDMZS9GEfVqEsBt9BsFn8b
I/7eBmEPg3eg23qxhqjTAxTspgB8e2g6s+1WWEzrbrLig0PLoh6OyxL/56Padjc/
TkWqCpGcGy9vjWgXsaWVl7LavA0HwIRDMQnygcH++PDXH5t9m6H8wn+LTks6A5Zc
DR5K+xB7a1Oedd1HsFK2V344VWqJ8vp8ocLLQof/HOfOacr29d6fyYsL7GIRr31a
tTsg9ebbMjb3Qscd6+jhMBV7K4boK2YK9WEuJJbfgV+GL751JxOGBpyAwLffpq4V
tZTUIFWAyn4POHxwjWMvwPh9mqxV/hCiKteIF2NoeOPaezUkkGmYp8zxqEHAAdqT
kTN1k79ieynUnKlrKquPNCjv7Z3Cw7VtyLghLIlg5WHT29eWM6zN2fTGjKShVc2+
ehoKt9aZJmtlwjFIPvKsMUchIH50lg0osjyRMwqr1rQ5xoj3RCkMoVq/6TS4nx5D
iixYMvpNSYaTB0rDt1+ZQptQSI2/fH0Z0N4ZY91rYGY4rRPXxkILP2c4oLPwHGIo
hwdWw/ACda9HrS5wKdYjwRdab+hKV4al4sIPHOS7Dh5lQs9bogeKHtZtzLWIe5/Z
Vt2Gjn44Wvc2synRo+lZ
=aFLf
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
