From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH-v5 RESEND 3/5] i2c: pxa: Add support for pxa910/988 & new
 configuration features
Date: Sun, 25 Oct 2015 09:40:07 +0100
Message-ID: <20151025084006.GD2159@katana>
References: <1440395978-9065-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440395978-9065-4-git-send-email-vaibhav.hiremath@linaro.org>
 <20150911190619.GB1516@katana>
 <55F65AF7.8090706@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55F65AF7.8090706@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, robert.jarzmik@free.fr, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, "Jett.Zhou" <jtzhou@marvell.com>, Yi Zhang <yizhang@marvell.com>
List-Id: linux-i2c@vger.kernel.org


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> And the i2c binding documentation, which says,
> for platforms using REGS_PXA2XX, they need to provide additional node
> "mrvl,pxa-i2c". Which is confusing :)

Yes, the description of the compatible entry is pretty bogus. Could you
fix that?


--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLJVmAAoJEBQN5MwUoCm2tckP/12rBIYs8GdCLa1trpXNLfcE
mMBIZSMzqkfssfDNy5Ww3Z6366v92EI2NaYPF14ZLF0BsGW4Szqon4Yn8BQZjJOL
WNufmQOGphwfJ7n2Hl68rN2lva+YLbbHxGu9u7Mwn1GZoZOu0astpSCN/e+2eo/7
OWDirgWNCeJlQ8gPtfpWTjhm/L8l3pUCbUZ4X/MQxMkqxajo7eO3Z3j+8vDeV6kV
xyYC1a12aUqGKQwIT7U94iSm2vN9EKEcED9LMGuoNwJGZ8kgqflq1wPNS7z66+4N
9NoMntiah3yu+/y4kzL82vD1oMxUJuD1CYHUVFsMq3YjojUr5SvBvyFXZWWsxorP
RSrPCiKczA6FQ8mPyeK5jZ98aPR+KAni9FRwET9KKWu17u3np3x/iVuOvRhdbosf
r7axf+26uZRQay3kqjoroIU+ti9CMGgAPdlogYzsZSoicsFGQLC1PTBWBdxcogMC
JAuSexL7+fWvDtsbY1PRV6Ydr8B4iAi0a9OvkMQJJzScRb/gI/pAkvwv7dtuq4xq
bharv4VRN33GBoz7RiptKbD2CPuT28LHy/S4QCTFEI6dmdTGF0nIfAb9JYCAMSVk
YphMDIe9nRHXpoRrfQnzBAwDAff+0eom/3fi7O3NpwuPOi++vObNs5D4FcwJ/TmO
b30jTiXcWuDpy0NH+e4J
=Hgfl
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
