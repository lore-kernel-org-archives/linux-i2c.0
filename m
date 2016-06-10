From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv5 0/8] 2c: Relax mandatory I2C ID table passing
Date: Fri, 10 Jun 2016 13:00:27 +0200
Message-ID: <20160610110027.GA1626@katana>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <20160609191513.GB23522@katana>
 <adcdbb75-41ae-774e-21cb-c039e2f0686f@osg.samsung.com>
 <20160609200405.GE23522@katana>
 <575A9082.9060804@bingham.xyz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <575A9082.9060804@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Is this what you were looking for?

Mostly, thanks. This verifies that the old way still works. Good!

The new way (no i2c_device_ids, just compatibles) will need Javier's
patch to work with module auto loading, I know. But what about userspace
instantiation with built-in driver? I didn't understand if this was
tested using the new way. And do you need then the full-compatible or
the vendor-stripped string?

Thanks,

   Wolfram


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXWp3LAAoJEBQN5MwUoCm2uFUQAJ51Y2leqmwUja50vxsfGasR
jyCr41jWmdC9jdLKISQO+Px7veyWF4lxBCE0wsanGpWGx9E4Ute0sUWWr/CVFPcY
bEGony3L1sGgrvluLL+fre7+1ppzQpklsHLdI8YeShiUajxd4sEg+usdlEWtOmjZ
aBKcvosgM7v931bAd4pOkwzaQfdafY5FlCyB2uLIysGw0BiC/9W40ZvolEfarxhQ
V5KAZnKEQ1/CbBYwe20Txvmtp1s/jYyHw9BbzwVHh9w8pB6BtoH6TBC0EeObi0DL
S33FjWl/eznY261GVA5+IrD1/CbCUP51bRvnJtiQSKlcHYfAOnUxK241RfG++BE0
GdkEOK1XTCwY9oUw+fxB7LW9eaRpT10s9nLyS2vPcnAk1DQcodu1nhclYPEIwSan
s0c+HuGAJTZ6hrJHcr3Do8t+rP8Ds4mckgJVhCWzk3DrqcFCkvG2IAQcSYs+p+HQ
LB5gMRa1pI8Knq3aigfDA9gvRQqLI6pecP6qUFAVF0kqw0Ex9Ns5lWGcChpljLCA
r6B2kEp/rIC7gtGmPZx28pu+++FhuvoV75BYK2CfS43wzkv30S/avYF+R4a9B8Za
fQuXopWKDiZMT0jF7JNuhZS0JQHos/ug18qzdt0wtahoADhinJWOq0fR0HDYpedc
z4WvkRadSDRCeUHZSUEB
=wtNF
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
