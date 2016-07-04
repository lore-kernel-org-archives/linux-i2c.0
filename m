From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: bcm2835: Set up the clock stretching timeout at
 boot.
Date: Mon, 4 Jul 2016 09:31:19 +0900
Message-ID: <20160704003118.GA1381@tetsubishi>
References: <1464818845-5348-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464818845-5348-1-git-send-email-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +	/*
> +	 * SMBUS says "Devices participating in a transfer will
> +	 * timeout when any clock low exceeds the value of
> +	 * T_TIMEOUT,MIN of 25 ms."
> +	 */

SMBus has that timeout, but I2C doesn't. How about disabling the timeout
simply? Or using the max value if you want to keep the timeout
detection?


--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXea5WAAoJEBQN5MwUoCm25yQP/0SVdel/LnOpqFx9mEXo+SSt
Mt5jBziDwWlFmO+65C7K5qML9egszemXnSxE09i+pHUUMWWQu5V9yMwSFsYsxpTR
seh7dvxo93AfON17zCz/KCxGyyZQAB5qk+tkSe5+6de0bpy+Two35tCAc8k/jeFE
HCRxKlF6rYhY7OraY0whdViVhLtOPlnqcXuFJyegFANxzAwNRxwjguSnPBgYBYdz
wav+opWhon8M1dE1R+Z+NJ5gLq4IjiLOFrxf88PsYhRJAuGc254j/AgPe1YVR1vU
gpyDjZ3ulkjAV3iDRFp0+wZLLkAWtKDYeFFGAF+SLefdAEjwynheZWRQQGhHLE1G
NsATIED8SmfVvwU1mJNuwZantepNO72K9KjlR6tmwLrKwPG5wW4CV+9dL/58kexT
anBZqDc7aj2TNlSkGppKHb6PuY5Terzw+NJEoZ9JuW4b0Y1mMg7FN+TSZExvypLN
vYGGUaI1vDI94zmifJOG2EQYiwvEjjBIjtZnQWZwwiDWTas69HhVkFKYZp9rFWOH
Cj+hcB7kS9D/NAB6ZQcCgl1YzMUybcgxIHrUN3PpzZEDBfInCjj45xbk1TVLoPU9
3c2wzY8o6gM47lo01Vx8JciOurw/Lor0G29+XXhBNf44Opa/nu0JVRgIycQ1tYde
63NiRnttMz1zrw30gkcE
=7pli
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
