From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCHv7 07/11] i2c: match dt-style device names from sysfs
 interface
Date: Mon, 14 Nov 2016 23:27:18 +0100
Message-ID: <20161114194953.GB3603@katana>
References: <1478522866-29620-1-git-send-email-kieran@bingham.xyz>
 <1478522866-29620-8-git-send-email-kieran@bingham.xyz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b6t245dli6yaldfz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1478522866-29620-8-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Kieran Bingham <kieran@ksquared.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org


--b6t245dli6yaldfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2016 at 12:47:42PM +0000, Kieran Bingham wrote:
> A user can choose to instantiate a device on an i2c bus using the sysfs
> interface by providing a string and address to match and communicate
> with the device on the bus. Presently this string is only matched
> against the old i2c device id style strings, even in the presence of
> full device tree compatible strings with vendor prefixes.
>=20
> Providing a vendor-prefixed string to the sysfs interface will not match
> against the device tree of_match_device() calls as there is no device
> tree node to parse from the sysfs interface.
>=20
> Convert i2c_of_match_device_strip_vendor() such that it can match both

The function name here is the old one...

> vendor prefixed and stripped compatible strings on the sysfs interface.
>=20
> Signed-off-by: Kieran Bingham <kieran@bingham.xyz>

=2E.. and in patch 2, the sentence "remove this function if all drivers
are converted" is obsolete, too, since we need this function always for
sysfs.

This make me wonder if we shouldn't squash this patch also in into patch
2 (like I suggested for the next one), and create a best-of-all-worlds
commit message from these three patches?

Opinions?


--b6t245dli6yaldfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYKjpGAAoJEBQN5MwUoCm2yX0QAIcP3nbfRkY9X1rlzQcdl3Xz
t69Rgwkxnke9nnfxi4eLjetoAMQCNUVykdSxor/HezcohEPBFUDjoyOL0/DOdyG0
lHoBvQ1fHjwBdnfvZfb48F/7/KXQ6GNNjgdhBknKnB100lTgrUWgpdnvhPR7wbpR
w109/i8N5MFwQ8aKbQbhWCn6t1qWe6LRfHQxypb0uTe4Yu2zC6QnrNA/nMtupgNg
/9JIRkl978anBgZUGmmC8xfcf+egqz5wIjxS71YzReEs/UE5XL0Ke0nej2Xl+sLE
eBlWONYzwSRLjRmGfzcJnL/kmAioREPkvGVoQRkpc+QocjoInec2kfJJZQJUlolQ
sWs6qppBr5O1UdYBtOoHNNFMkREP6WLZq5ZsE4uiDcx80AkueyrOAxslGOc78f/w
tKGkxOfdAXkRz3bd8Bz80B8cnIV+sNJqUjJO3Dtx3ssYeERpgizRVj7HMdAZEmbu
4Libo3icS7uWS0ZMUG2+sFNPI/XOzcEDZA9pi5FQ2HnRMf0mcZlJl5tk+dBHyhMS
Xt4yoeyhz9Wdc3WF9it2dyAw2fGk7HgD+20D2kgqRwaP5SH1iiTXXdQpwoNFcP3e
WIWBrXb43pWUBlGaSQH5LNDb3vdN62zSXOBGxoY62kCy6yJThEHzBA2LXIEBRYcR
2vWyMvZH1c+xz2Fwn10z
=Wt4M
-----END PGP SIGNATURE-----

--b6t245dli6yaldfz--
