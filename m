From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
Date: Thu, 13 Nov 2014 01:34:19 +0100
Message-ID: <20141113003418.GE2062@katana>
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
 <1414537731.23458.120.camel@snotra.buserror.net>
 <5450AC85.40302@keymile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5450AC85.40302-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Cc: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux PowerPC Kernel <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux device trees <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Brunck, Holger" <Holger.Brunck-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>, "Boschung, Rainer" <Rainer.Boschung-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> If we wanted to be on the safe side and strict (since we are not sure that the
> hardware is 100% compatible), we maybe should add a fsl,qoriq-i2c compatible to
> the driver that does the same as mpc8543-i2c.

Or you leave the driver as is and use both compatibles:

compatible = "fsl,qoriq-i2c", "fsl,mpc8543-i2c", "fsl-i2c";

?

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUY/yKAAoJEBQN5MwUoCm2m98P/ix5SsOvuRsDYFbeDB3XqNyN
16yH9cU7oGeDHPFyvqzcnZ++d6+r0tpaErXOU3GS2NBdaMnNMHogmhBIbmCbdlW8
A3gp2+mY/BnSmvl6dv5tqKzjqX2zZ5+3KOj6EcVAXVR9bz5qmFpKrEsZYv++BQj/
tNEAUN7iy2gt33kckfBxpfrIwjAiylsKae3hqLMhmry8x5rd2/KrkGB6qL1QOaAx
wV4ZIMcDBDVO7u4lmokl9heRebED6vYB8YiTWZH1dDz1whbN2loUGZroTmR+dbAv
2UY+S2CMxUg1bQPkyDVe2GglZ1wXit8SKToa/mClSeXtpiW546JzcYW0Ep4HUQf3
lv9+Lg1ne+y771u/Pome2MUPHR6Ntuuy9GHxQad/kx/1jRe6/C3yko+3VoQj9SrY
3sNXLcUmraRLQL/3EjOJdjFOJapjkopt5Jh4Lt6jIueOjEZLBXEbVJgGiHyS1IU7
61FeVvl6Mxt8lt2zsUjT8IBzi8xh43zquzHjJgjAXH4CxHXx7y+GURJmclXmOf0h
HE5qMLRerHOC7Fr4pOnuXixehhrxKZsz9MuUk2NMnAlqEULxgRMCXbzw9rRLKVSS
m2VsqDdYRABZjLrhIFmfWOMnye4tKMd/I7qitE617QhZFqc9+YsiJoFHj3Tncchc
zA+pXncSKBWHcPRjo/DJ
=XA65
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
