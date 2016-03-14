From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: immediately mark ourselves as registered
Date: Mon, 14 Mar 2016 15:58:51 +0100
Message-ID: <20160314145850.GA15426@katana>
References: <1457949206-7226-1-git-send-email-wsa@the-dreams.de>
 <20160314141903.GB5699@sudip-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160314141903.GB5699@sudip-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-i2c@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> @@ -2128,6 +2130,7 @@ class_err:
>  bus_err:
>  #endif
>  	bus_unregister(&i2c_bus_type);
> +	is_registered = false;

Right. Fixed up locally, above the bus_unregister though. Thanks!

> Sorry again for the previous patch.

Things happen. Next time, just say it is untested, or better: Test
before sending. I'll pay more attention, too. Case closed.


--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW5tGqAAoJEBQN5MwUoCm2P34QAKHSI8HA4ID/wR5LKY/OvmdM
CxaEew5wN6xFYUJI7nLnyNsTz5ecsejbcW4cnjTIrlkwUu3qYZbO6VkX5g4QzM8n
FbraO/1S+nNbLBmD26Fn1uwmqzOkUurwQNRpOYmRVnhO67hznDRzTRqgk5I2DIrW
fezITYkgnMP48I2a1ooL2i4qrUc16mkDJ0TW+n4jsouSPPBoWeKQ4go8hM/sUK99
KzYJDzxKqLu1zsoj7MObANyAIq4LkDsd7/3tSJwLCeTTl55Zx8eJ9cZ9pNWlwwJg
i8MfIznO+8oyOt3IF8imRuVgoD7LNlQ5KQgUI56msE7r3ABvk+Zs0cuAqdKr0vaf
DOzZzNBMBX/AKvqEFWkR6P7bOMPfuBqYKPnRKeAEs7HHQ0lL8PBExkFoHmFoCD+F
tK01gKpbJFTsqEcA3Bq1jbFxGLA3rqJBzrgXSs+A3l0l3GnzpJzsT6aK9P7j6+NF
mOMPASAFJI+OOcvF4NGCCIqmCQMi5PwHzfQiVg9zLamUtqSNfwXdQyLKB3VpO0pn
S7cP7+ZZ76LoAPep5A5s4asbKMYHlAiW72zUfNime93hRKdjpDg4V22sQRN4Fnl5
JU5tpCx5lGnQtC0K5LuvtCJMXw8npIwlaDGYh/PYT5rNa+u2vXNYVJqhJQuuLK1I
BYMF1lyn8kaxWofXMO7X
=Ihwn
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
