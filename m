From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v15] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Date: Thu, 7 Feb 2019 16:53:27 +0100
Message-ID: <20190207155326.GC4796@kunai>
References: <20181226232258.GA23526@syn-yoga530>
 <20190205120545.GA1045@kunai>
 <CAErSpo5kvFVwo-DCLYT_7UmRQKS1jHahFXawvnZUtZ=ApHKz1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo5kvFVwo-DCLYT_7UmRQKS1jHahFXawvnZUtZ=ApHKz1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Elie Morisse <syniurge@gmail.com>, linux-i2c <linux-i2c@vger.kernel.org>, Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com, sandeep.singh@amd.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Bjorn Helgaas <helgaas@kernel.org>
List-Id: linux-i2c@vger.kernel.org


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bjorn,

thanks a lot for your additional information!

> IMHO the split into two drivers is a bit of a mess and doesn't really
> correspond with the hardware, as I mentioned at [1].  The PCI device
> is the real hardware and the driver should claim that.  AFAICT the
> ACPI device exists only to pass some config information to the PCI
> driver.  I think the natural approach would be for the PCI driver to
> directly search the ACPI namespace for that config information.

AFAIR the AMD folks insisted on the two driver setup because they need
it in the future? Maybe they can explain again here?

> The fact that driver_find_device() is essentially unused except for a
> few very special cases is a good clue that there's probably a better
> way.

Excactly this thinking made me recommend something else, too. Let's see
what we can come up with.

Thanks,

   Wolfram


--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlxcVHYACgkQFA3kzBSg
KbbKUg/+PJomClPceiLS2KRwNbNrlsyyrzpU/NmDQhCRtTVswOm0z/li4Mb0kj4X
TwcLUFjZAYe8tyX/8K6QeTEsG+5iPPWKmlA1AoEy+sX7vl/OX8kRdVAcSoGOx5/8
0jNc+1m3mTF/woaiDHEwMPHo178SQpaYC5kyvvnvyoH3PZY1uMVMOwCUzTMsfuWu
imW08ROvQoW/T0zSiW9v3OSsaaapCdQuBzq+qXBeEpaGyYCqaDZIj++ZMS7QIpoI
+YBEtiHDRzSNyBo2Qr7rOsDwD38BvHBd1QI1mYzifaf26P2YbDB97IceTMVBS4Ru
Vp9Fp6gVgcPZWjv47ilsgz8YFyXCPiPVICJyMLsadAOYcwz/Mu1sE4vruweq8j6c
ahAgtlXvA083CXe8aXxuQUp50gSvo1AMyFGmZLxhUXrdz/ci67jnupU0RxqiLmkC
EFPyMeELKfOy5ubWij9MPb+gA6j5vMuqhvsCuuzJArdcMVsBxPbU9KvfnIf6dKT/
rcH76sULNbv5Ygr4z5EUTAXJSRS0LWy9lu2YfzKg+WFRh4PrpQazmwjEmE36cB6E
E9m5dhkCuyWjAtCPmM0k0Dki8jTS9K47EtQOXTkXcFgD+lnl7ffkQrc5bcismsKv
47u2jjhCEHFG3XiVkhaZmeXgydqlZ8O2YKImmTSZ5RrSfjqSEII=
=ib+6
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--
