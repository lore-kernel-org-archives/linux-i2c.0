From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: lis3lv02d i2c access on shutdown
Date: Mon, 6 Mar 2017 17:54:54 +0100
Message-ID: <20170306165454.GA2086@katana>
References: <647cd755-3554-0719-6811-c64ffae0fc1e@revolayer.com>
 <33dcfc02-67ef-ba6e-30a6-e2cd26aa9f71@tremplin-utc.net>
 <20170304223222.GA2386@katana>
 <41bff51c-9a4c-3e28-a9ed-eea916f87e9d@revolayer.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39130 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753739AbdCFSmJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 6 Mar 2017 13:42:09 -0500
Content-Disposition: inline
In-Reply-To: <41bff51c-9a4c-3e28-a9ed-eea916f87e9d@revolayer.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: James Maki <jamescmaki@revolayer.com>
Cc: =?utf-8?B?w4lyaWM=?= Piel <eric.piel@tremplin-utc.net>, linux-i2c@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 06, 2017 at 09:10:52AM -0600, James Maki wrote:
> I think it is the same issue. How would i2c_transfer_noirq work? In my case
> another task was in the middle of a transaction when it was "stopped". This
> means not only do you need i2c_transfer_noirq, but also need to flush the
> bus before calling kernel_shutdown_prepare().

I don't know yet. I have a rough idea, but not even a design. The above
issue is important to know when starting to design the interface,
though. So, thanks for letting us know.

That all being said, if somebody is faster than me in doing this
interface, I am all for it :)


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYvZRdAAoJEBQN5MwUoCm2q74P/jg2gPmv2Xr4OaniwDiG4ERU
7AsnfktuX1toNjqnltgc5UXlqTY248pQi6IP67ZuGX2NoljKXVe5cHSkC9OyA8XM
gA57tsHdzag+CV/2AbjxbqtMpImlg0vHxPr8u+1ZCNufPzl04U7/LLwRklwpC51B
RT2qRB9+mmVb+H5IfdwUWb+HxpM2v6sMLB0HMewVCQfl/i4srehRC+rSBf5b5OFg
X1meUglVo/skp04/IBlu3GmcnnacVqqv/91q0yX+2RWMtgFAJfoYYnhFXTUPP9+Q
TGyNyD1ApZOfR4F4wGjAMAyzIeGcXqdu6KaANE5sfDbYB6n1wWk7/ohE13SCJ7TG
Ff5yEyCT5cbyxxvqLNam4ZjKDPOZGKmdN6A/GyyFsQfgq0W549G4Qrvi/R/3CpHy
sNmFqaxk3yRT832jN/XX4UEarrsPbwLn9pfaEN5VagDEKhG0vWWhppn6j3tqffci
1BieZbOUfjkjusw3ite5SUTiVA9lHxy14qM0xw1Vq3a0asEEIApl23D8iSfn3XpD
Vd3XAHtkqvNYocqfY8RlW7mmFM90oUL6Wp/kZRyl84Ga1P+IT0q6NfMYczWU8Cu+
j6QpGM2mDFaYvKJHBbOj/ZQIhu6UShQHQGUJwtl99QVCSTHdv/kuJNz7i+WcoaWl
JIdt3aS+GAEFKhNjq91I
=PFoS
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
