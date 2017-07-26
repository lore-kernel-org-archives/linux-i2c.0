From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: can't write more than one byte to AT24C64 EEPROM using "eeprog"
Date: Wed, 26 Jul 2017 22:57:41 +0200
Message-ID: <20170726205740.GB1510@katana>
References: <20170725085131.Horde.ogXTYHLwBV6pmCIUgV7abh7@crashcourse.ca>
 <alpine.LFD.2.20.1707251344110.20856@localhost.localdomain>
 <alpine.LFD.2.20.1707261427010.32595@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:53972 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbdGZU5n (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 26 Jul 2017 16:57:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1707261427010.32595@localhost.localdomain>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: linux-i2c@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>   thoughts? is no one else seeing this issue?

Just for the record: I always use the kernel at24 driver for eeproms and
haven't used those tools for ages. I could imagine this is true for most
people and would explain undiscovered bugs and bitrot.


--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll5AkQACgkQFA3kzBSg
Kbblpg//f+Bym6V1ZEFqAb5a2VtKpMOoGOZrmCFtERMEKBIlIjaApsV+MeanhcE5
D4MgfHSOq+XMxTj9mK3Xl1uejCqyZ/w6DNmMm6NWjNBQo0y5/x7tnXfh2hx+278m
EhaEPKsVBa439vqQt/tZD5IJDvxih90QwTrCLL7r8FbJ8TOFwaneu16Io/hO7yjU
lv+GHhO/0batdVWFTq/WIHMIQXUFRuTyspxNbtU1a9v3tDeW0DGh/EjGFffkW08n
zdZjH7sWAgxhZ4JgDpm+3igQCw3tOzxWQWpcNQAoyuRVobNuXoO63DTTBGV9iWhT
aPe+1HwPlLTTAukI6M5/WBH8erTbGldKxVRAwlkNeuFH95Pd2lFblP24YDa4n6/K
hr+UQi7ySbOmdX7i7CuqMFff385ggmGRGz2fXFPJBghPnHgYpbjB/3R83V4w2wyw
fDbJ95CKEBQhGp91ULsoAz5Uzz/SO3L4MZBZpUDvSK23VQ4zYomTE1I7S1rivKH0
ogISBozV1ldCL00f03qcz/1+nNeKqd+iElg6Ya1gGqqgPkZP00rDBomhYAL5EvBB
ZrYvD6C2Ex1paPsWXYTpum3G9jhnnNgr6+rqFhuVkOlmvVkFMVgJyEfH9RMpHXpU
u4h5QL+kxO8/FMh0uxVgjV41A2LtwB8iL5SCn2CChsyTpGVKJRk=
=PC3T
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
