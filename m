From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: core: add support for read commands longer than byte
Date: Mon, 10 Aug 2015 11:13:53 +0200
Message-ID: <20150810091352.GB4682@katana>
References: <1437744042-24471-1-git-send-email-cmo@melexis.com>
 <20150809074006.GC1526@katana>
 <CAKv63usiWb4QgV=pnwuqFJtTogRca7UjtmiSKV69OTM2h7LtHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKv63usiWb4QgV=pnwuqFJtTogRca7UjtmiSKV69OTM2h7LtHw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Crt Mori <cmo-fc6wVz46lShBDgjK7y7TUQ@public.gmane.org>
Cc: "Simon G. Vogl" <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> This debate is what I wanted to have. The new Melexis sensor will be
> using it and since I think some others might also be using it in
> future I would rather put it to i2c. It is more i2c command than
> sensor specific so I think it fits into i2c.

There is no thing as 'I2C command'. There are just I2C messages combined
into a transfer. I think you mix SMBus and I2C terminology here.

> Another gain is that when number of functions each device does increase, as
> well as ram/rom addressing read commands with longer than 8-bit register read
> commands will be needed. Especially since most sensors have digital design of
> i2c interface (not software) which means native access to registers is required,
> therefor 8bit read addressing (smbus) might not be suitable.

Adding a function to i2c-core will grow the kernel for everyone. So, it
really has to be justified. So, here is the deal: If you can send a
series which fixes existing drivers to use your new function and it
shows that it really saves code, we can add it. Otherwise "thinking it
might be useful in the future" is too vague for me in this case.

> I can fix the function name, but in core this is a master read command.

What "core" are you referring to?

You set up a write and a read message, no?


--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyGtQAAoJEBQN5MwUoCm2EeQP/1GTSRNdFF5ydXazXfQgUXqM
XS2BAWHhonPIOvMh1tM1kBuJhVDZ7QQc7ZrhjjJqrmQWgzsBWsEqS7jrN6nV/osK
x0vC0aj4CFMJlLEXpd99Ut9q1bM7yIohUFZNs32cCytFNBRr1waMjv0ScXhqHcDE
VztJYbrsrQfTyU6ZUVfhntrj4NL/4RMzWKG1jzvtabPx93OZKTitv5r9d6PS6j4P
5jP/mYcMS/QTf3WdKnCRtxSfuEAuArzn8sVQod6VreROPLSKkTM1S/oPSPP71luO
mZaZRQYZLR7kPyGTRO/5eXEtXyjfLSHlOg1ex+AqU45rtLBzUsv7AIL+K2i7z16y
ZrjOVCPmL4I9Qbs68KCHMmspbXZ4Latr7NUnzY4yfkmRRh13HM8dVXTq1a04sfEL
kJQADnX++sGZTJFSSTIt+kGXjVeiybEW4B10N73STtSO0dTyANfwMD70Sav1Kf2m
rxJ5PhkK4S2JDiwg5wGdukN31L35OrhcUQHFVomcphkvAnh6Ylnvs5pbPxa85m7b
lnd1HhNdzZNStM/2yDPJUTmTkE9J+Dlscn0ZlRDFKcPA9tmZU3ZI/kNXryLYhVmf
nbT/pRZq7KGs2y2o00JeyEApyByTkrdEqov9aOJoEWj/YNSlZvYWTYxThdWzzM3E
dpboq9IPKTnlWCvr+vTv
=+nIE
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
