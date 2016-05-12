From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: Raise SDA for each received bit, if necessary
Date: Thu, 12 May 2016 11:05:44 +0200
Message-ID: <20160512090544.GB1638@katana>
References: <1461780714-20378-1-git-send-email-tdz@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461780714-20378-1-git-send-email-tdz@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Zimmermann <tdz@users.sourceforge.net>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

On Wed, Apr 27, 2016 at 08:11:54PM +0200, Thomas Zimmermann wrote:
> Some I2C adapters don't raise SDA by themselves when sending a bit. This
> behavior can be seen with the DDC channel of SiS 300 graphics cards.

I think you mean 'clients' or 'devices' here, not adapters (masters),
right? So, it seems you have a bus without a pull-up resistor (or a
broken one?) but use now a push-pull design. This is against the I2C
standard and for most circiuts quite dangerous as it can lead to
shortcuts.

Do you have any hints that the bus is designed this way? In which driver
do you want to use the new flag?

Thanks,

   Wolfram


--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXNEdoAAoJEBQN5MwUoCm22u8P/07ooDEFEXbT/Urr006Yz3x5
gRqcSxVV0kEUrIc/6sK1nxGdh19DhDkjtAV630Qn1/Orp/bI/w7jiCzRfiicijdY
ROwsbX91PdGcNANfWEy2TAwnJNCf/TOHtPYMShLPEzSuRe75MFP0mpZ/G8VRc5BS
uf3deVDWFeO+JN8Jmr7mdPk/I92heh8LVggPr95XKkXrfTxD1unhET0cQTQPbEMW
NYmkd0row/FXCJDbbx0JECwzR85P8T5HcjH786qAfNPtiBupf+ExZDr7q91s6q5V
yQV5XLkTvcUi9Oe8uNediZ6BxdlhZX9PvHvuSnM5xyL3LVcOKI79cNYEh9JvqJ42
4Nla9yVrDMJ7F6HHBPypf5TzXwDOEKN8nbf8eHnmemINOZFfjxIpbJUNYuWF59QL
tof8hXIZjQU+MN7E4iGfsK1uGOft+8sn7fp+Q4fRFFaEYGogHpaKFng8YK4VjJK0
9hLINmm5N8ZVnVWjTOGQ+hwjDjx2YdMK6mmony764TrLJczd0RmcaSQpSmNxqOCM
Rc1Uzw+amujwphLY7VZMn6aM7Y462A3oSqeznTJ6YGdohvNRUT7spH0pYONC6tr4
U7z7mpeqT8g0J3jVU2D4UTtsy4jibV7oEivLwIL4LpAQ3s+pOLG9QanBB2TCJSqH
G45bZdJDnXOgyoJq8pon
=HCuS
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
