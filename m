From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFCv3] i2c: hold the core_lock for the whole execution of
 i2c_register_adapter()
Date: Sat, 21 Mar 2020 20:15:32 +0100
Message-ID: <20200321191532.GF5632@ninjato>
References: <20191008163956.GB566933@t480s.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:38604 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgCUTPe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sat, 21 Mar 2020 15:15:34 -0400
Content-Disposition: inline
In-Reply-To: <20191008163956.GB566933@t480s.localdomain>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Slawomir Stepien <sst@poczta.fm>
Cc: linux-i2c@vger.kernel.org, krzysztof.adamski@nokia.com, jakub.lewalski@nokia.com, slawomir.stepien@nokia.com, alexander.sverdlin@nokia.com


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Slawomir,

On Tue, Oct 08, 2019 at 06:39:56PM +0200, Slawomir Stepien wrote:
> From: S=C5=82awomir St=C4=99pie=C5=84 <slawomir.stepien@nokia.com>
>=20
> There is a race condition between the i2c_get_adapter() and the
> i2c_add_adapter() if this mutex isn't hold for the whole execution of
> i2c_register_adapter().
>=20
> If the mutex isn't locked, it is possible to find idr that points to
> adapter that hasn't been registered yet (i.e. it's
> kobj.state_initialized is still false), which will end up with warning
> message:
>=20
> "... is not initialized, yet kobject_get() is being called."
>=20
> This patch will change how the locking is arranged around
> i2c_register_adapter() call and will prevent such situations. The part
> of the i2c_register_adapter() that do not need to be under the lock has
> been moved to a new function i2c_process_adapter.
>=20
> Signed-off-by: S=C5=82awomir St=C4=99pie=C5=84 <slawomir.stepien@nokia.co=
m>

Thank you for tackling this one and sorry for the late reply.

Do you have a test case for me so I could reproduce the bad case here?

Kind regards,

   Wolfram


--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl52Z9AACgkQFA3kzBSg
KbZBNQ/9G9uQf1DGPu6wnbucPPvSvBsi5udU3ywB4N607J4bvqZnp69SoJMUl3to
omnTxfv/z9tel9JorSWD4fA7iMSuTBpyFpbpqwXQNmC2LTo7fDs+SScv3i/e42ws
jG2q/NFj4uyZOoD+T9otUj53Bow6f2OXhL+CRnlH46c3ljEnaSo2moRIcBZdmWtE
lRd8Oj+v28CyFOe1yMv562jIK8HKTz9D2lQQV8ABQ3lMtg9UCMeZVdY0JVPtT1mP
1+UdC+QLDeycjuZPnmVDpRHWLU1xZKcAHSg4OOLqBb70u9ftKx5EGTp9QwBDdqua
2rVbij53+xaXzcSXYpdMGimgln5SWt/orN4lMWGzEyiXJl1vT4btgN1YeA4wE3rX
5sbRgFljz+zxY4BhjjRbMGt7kWJFl+7Hig0Lq7LZdYDVSeiuIt/SdKxuu1RaoRyt
4gULK8YMG5yKRb3oXaU2ueQpYE/KoxdihtDjzNS3u3YeX/JQjfoCiDSaVt9dSXBW
T7XaH6wu4trFQVmmfITwLYF8eoHeYunFiax/Iy40H7J5XkftTm9gpKioGJKLwng5
nZR/vdCC4SSqkK1dvMjmfPDYERsU6YK13+gcVU31uqejsss9dHoVOQKVHPLh8c6n
QtauY1MqHLMuMuHC3YfJ0WJkk+bLo/IXd5oni3Wx0vEB+8JztQs=
=NZWs
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
