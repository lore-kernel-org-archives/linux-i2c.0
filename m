From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: rk3x: fix bug that cause transfer fails in master
 receive mode
Date: Thu, 21 Aug 2014 15:12:46 -0500
Message-ID: <20140821201246.GB1443@katana>
References: <1408643457-7126-1-git-send-email-addy.ke@rock-chips.com>
 <53F634AF.1010303@cogentembedded.com>
 <20140821181738.GA1443@katana>
 <5150326.5TB64kCfF4@typ>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5150326.5TB64kCfF4@typ>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Schwarz <max.schwarz-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>
Cc: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhengsq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Actually, reads with >32 bytes of data are possible with the controller. =
The=20
> hw returns the data in 32 byte chunks. Our chunk handling code is just bu=
ggy.=20

Understood. Then, I'd prefer 'chunk' in the commit message instead of
'transaction'.


--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT9lK9AAoJEBQN5MwUoCm2kKMP/iFe9IoYBubgYLiwvIsXFwDX
isEjEACKJgZZyDXtDXIXa/4augAAWf/KmVWc7GRnsakWmUK1dDaPEeBnkfm6Jrzi
Knx6s0kh7Zw94HmE3lcecxjH4hIf7yNr5uih1o4XL5XoQzwXE92HEXYjNrC1+1Rs
ebOMM2F2N6mhi+zLhbsgcGO5HKEcJ9OTTOCDuGbewrmbQ8FI2vuHcBt0g+ehh4Qc
ojH1xQC3Xe8cdlB+4xMth0xesygMihQPq//teDaRoxpB1c2YkcC+zpKG0IcpPCxy
wNTZgLqwiyYruyffnZxXDx5+fHqSnKFiFhjZ9j39H4ATC2k3FH8Hy8UP2feHQDud
pL7x1tJOtc0n8F5Mm6dvBGf8iOVbN34QTME1/LO5ALJHeECU7Tm8vSUWQ+49h3FD
xX8Ep/uTAQT8VdiiZSECjctgKffhNd00PU8hUFUuAOn4o8QYDU+5cedbCFtBzYZm
pwyRXamKL4ZOgo50W8s6EASKJbUU0zD3rbjQr2KVjUkLfMR49XpuTf5PZyEKMSHO
8idUYTEaq70BEfpw/hbg/ph7sSSAGU1+5zgYPmq+2dc9RPsSrlgroOdWZjZVso+I
nOQN9hP7skwXKlkyU+p3faAoVkd/4RTdzN7pYZis4+Fzu97wNQSVSScSfmBS3KEK
XAJVHX3zKE7Nqet9hnJc
=2+8X
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
