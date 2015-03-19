From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] eeprom: at24: Add support for large EEPROMs connected to
 SMBus adapters
Date: Thu, 19 Mar 2015 09:16:21 +0100
Message-ID: <20150319081612.GA900@katana>
References: <20150204190819.GA15467@roeck-us.net>
 <20150204233516.GA1677@katana>
 <20150205002630.GA396@roeck-us.net>
 <20150205144028.GA4865@katana>
 <20150205175326.GA26691@roeck-us.net>
 <20150212040126.GA1691@roeck-us.net>
 <20150216120951.GA2840@katana>
 <20150317042049.GA6765@roeck-us.net>
 <20150318132707.GD3580@katana>
 <550A4162.8000009@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <550A4162.8000009-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I don't call that multi-master, though, so I guess we may have a bit of a
> terminology problem.

This is definately not a multi-master issue, I agree. It is just
another issue I saw when thinking about your patch thoroughly again.

> I'll see what I can come up with, but I am not sure if I'll find the time
> before the 4.1 commit window opens. Company has a working solution (kind of),
> so now I'll have to do this on my own time ;-).

But their solution is buggy and needs a fix! :)


--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCoXVAAoJEBQN5MwUoCm2zEoQALRNlBsi1/Nf0azFBg9sYGOk
6K01fMVc5x8+vVqOrq6n+WkfYPyVhJ9uI/ac80SPh54DLMNuvCcR0WRKlqR9XOvx
sEw5D8+ERAZlfT4+MH8uVRrsgHNJhQ7J+e5t+5x+ULWAzxYlsFlszLGfUdRl8YIN
J3Sqs95zCOEREBRN4gMOlITqZU1oJ/8lEVy/JDugpvz2eRD1RE8lTqGDUq+v3t2t
dUvXZP7heySxejnNf9/qlW0sPXGyIUYfuZVoVivqLW/VVFIliqQC0SOf1Ze37pyp
XNAtF7BKxjh1Yws6yei7fKGv1Es3SMityAxbtNhrQ7JCcRs6/5uRXg1My5DPsY72
vON2djpiB9+i5LIbZDt3/fa7cKetlJdBJ6RBOerlFynnOFTXVHYv8MMlG4uFLvRj
zD85Qfndsw979JOPSt+y9cgHog55NEwOWF8asIRTdMcsVVt3aE6UTxtbcbhPgL2O
Ac8O1S5VoRhDYIM1Tuk5o0uLOqPfwDjrRmZqLj7fK8ieRQkAcrG3QGk8V4243Le9
vPO30oLdwss68W5ISh38VmBacm4jvAtc/Hcr9v09IKjejHmyfBIbCgY9VTajsglQ
rKnj1HpNJigRXd7SxS9jJMQfe85cXiTWlckdNVZcupLiPNHP+myKc0re5zGA9dd0
zOIolkSqyglwH9kpHNIQ
=/IMA
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
