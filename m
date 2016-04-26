From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 08/15] i2c: octeon: Improve performance if interrupt
 is early
Date: Tue, 26 Apr 2016 23:19:02 +0200
Message-ID: <20160426211902.GE4587@katana>
References: <1461594824-7215-1-git-send-email-jglauber@cavium.com>
 <1461594824-7215-9-git-send-email-jglauber@cavium.com>
 <20160426211038.GC4587@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426211038.GC4587@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, David Daney <ddaney@caviumnetworks.com>, Peter Swain <pswain@cavium.com>
List-Id: linux-i2c@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Assigned 'true' instead of '1' to bool...

To save you from annoying rebasing, I reverted my change. But it would
be nice if it could be fixed somewhen later.


--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXH9tGAAoJEBQN5MwUoCm2+NcP/1J6czRYa6RszjPrYRX7Y9Mj
QTQ15wJeWCq9SyieYCxd3M2rOanL//rJOcvi/JfmBw/NIcn4D/jg3YZMfHmTtis6
dP9MseyKxaT8GiIrgVgBf1loJz5LEnF1mDpPrtFs2tTREQqCCNOCRay254wZ1nLh
wL3CCej5aWoMcJZ0giV6JptodIVkbBmPLkuxkRaW9x29+Mv/etz210VUG2cb1MQq
+yvuWQtcykGUY1yI28eqVjxGDq5/zirPeo6uH/+XV3E63ZIEGsoV0RvlinNqJ9Fk
Pen/xoMFvNPs6jJOAnhKSmzXgfpA+1+OoogEjxB3O0MNeSKd65kza3IGUgjvb7Br
EesNJ1XoNYEf00CwxjUuvQ7jZfAQ6TtjGb8HQjQV/nzetcn8Y8zX1yYaj5OM3YXI
2H0etOdsvPiUTchL8joLJ9UDENeUgkTfZ5pKXOYaVBBGTOh8x9x6wL1ymLk1rRB6
9uqV/DBFHD/n44PFMRRn5wpN7hFlwEYV7Us4RjluY0DIdt1U4jjgKPoMDA/7KVuO
9pAsR6yPX85+2Euu/f7ywHMjsA88Wq8nRpaGici2hJdfdIWKu0Gixa+1mKqQsoxC
srPJNewgQWaMZoCSNnyvbil82+DutF4yyg3F0bOe3imKLhoIMbfIUDd+A6I6qBiF
Odgl8wtNK7yJxY6GGGxb
=iMAr
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
