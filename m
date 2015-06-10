From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: I2C slave support on Xilinx Zybo
Date: Wed, 10 Jun 2015 23:38:02 +0900
Message-ID: <20150610143801.GB21540@katana>
References: <CAMQCnXF47Kr3x3yeqba-me+N8rQ-vDJ6ziho5107qcckDbT0mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMQCnXF47Kr3x3yeqba-me+N8rQ-vDJ6ziho5107qcckDbT0mQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Bakker <bakkert-Lqq7FYbpbC48+Wv5JVE8qw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> I am currently working on getting slave support for the Xilinx Zybo platf=
orm
> with kernel version 3.19.0.

Cool! Any code you can show for the xilinx driver?

> These are the steps I have taken so far in userspace:
>=20
> # echo eeprom 0x28 > /sys/bus/i2c/devices/i2c-1/new_device
> # i2c i2c-1: new_device: Instantiated device eeprom at 0x29

Ehrm, no, you need to use the slave eeprom driver here. Gosh, did I
paste the wrong shell command into the docs? How emberrasing...

> I am new to asking question within the kernel emailing list, so I hope I =
do not
> offend anybody and I am certainly not trying.=C2=A0

No worries, you came to the right place.

   Wolfram


--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVeEvJAAoJEBQN5MwUoCm2Rr0P/RbVv2WFy5l/Vdfwgd6kWgOw
BkWdlPY7Kj88eTx9jGdjzyrgzuQFbJtM5O9To3vCqus+JJErOli0iSorGZOWF4oD
zEBRQXl8ax5+jAviHQpx0GqI8EyHm4A/k8IgTQoO/Hf+rPT37tyiOzCh9S+/tm5i
OyH7R8uyu7QUhtlYMQjhXzsI6f51wQOD3R4O6/M+L+y1jtpepTIyGkKpA4mU43F6
YR+g2lROttWAnhCU/7kQMS3kB2KtWPpMuM6B6NHaFObaGAAcrWnuKz3QT0P0duhO
WActRfOz7UgBftcb6XUI+ryMK7D+NMrcoFXHqWXUzgppxo6VbMRUejrbe7LygQqr
UGaC98zlzYk3tSur6tCZ61MKBPcE8YpRXMmDcQcluCWVQLfBTX8qM7fONzRNdeLD
NxQilhvfiPyuKKcISmcpNnAPYUtB6FvqOZP9fG7Mo59/fml4E7ZeCB53ShtQSI/+
89TnAcxTItLTn6IMWSc5k6cLpe5bRARcamu0UQOpSxUzc5cjkfR1nXE/Ju76KC9y
ofm0v/sxLyeTYjfoCnk/WX8KkK+AZkcB0lxsJVU+M3JRkvm6SwYVhZ99wvfWRQuM
RRbgiECAu7cNYcz1lpe8njaQx8HyopIAjfB23dAoSVOvy7vOQNkc81UBJzyfZpPB
zZkvICRbe1BRX3QB+J57
=wf0n
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
