From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: pxa: move header file out of deprecated i2c folder
Date: Sun, 29 Oct 2017 18:52:57 +0100
Message-ID: <20171029175257.dfmf5642zfszoxe3@ninjato>
References: <20170814164303.2383-1-wsa@the-dreams.de>
 <87d15qlq6z.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2jeeo3rd6f6zlzog"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:43300 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbdJ2RxA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 29 Oct 2017 13:53:00 -0400
Content-Disposition: inline
In-Reply-To: <87d15qlq6z.fsf@belgarion.home>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-i2c@vger.kernel.org, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Russell King <linux@armlinux.org.uk>, Daniel Mack <daniel@zonque.org>, Marek Vasut <marek.vasut@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>, Jonathan Cameron <jic23@cam.ac.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--2jeeo3rd6f6zlzog
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Robert,

I had a look again at this patch.

> > include/linux/i2c is deprecated because too many platform_data of i2c
> > clients incorrectly ended up there. The few still relevant include files
> > for I2C bus masters with their platform_data have been moved to the
> > platform_data directory. This final one, PXA, is not entirely
> > platform_data, so it is simply moved one layer up. After that, the i2c
> > subfolder can finally go soon.
> >
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>
> I'm sorry I completely missed this one.
> Either it's too late and trash this mail, or it's not, and then I'd sugge=
st
> another approach :
>  - patch 1 : move include/linux/i2c/pxa-i2c.h to include/platform_data/i2=
c-pxa.h
>    (i2c-pxa.h and not pxa-i2c.h to be consistent)
>  - patch 2 : move this chunk to arch/arm/mach-pxa/devices.h
> > extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
> >=20
> > #ifdef CONFIG_PXA27x
> > extern void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *inf=
o);
> > #endif
> >=20
> > #ifdef CONFIG_PXA3xx
> > extern void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *inf=
o);
> > #endif
>=20
> This is the cleanest approach I could think of.

Wouldn't it be even cleaner if patch 1 & 2 above would be swapped? First
move the chunk, then rename the file?

And is there a branch I should base this on? Currently, I am thinking of
basing this patch on for-next and then submit it around rc1 time.

Does that make sense to you?

Regards,

   Wolfram


--2jeeo3rd6f6zlzog
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln2FXkACgkQFA3kzBSg
KbYUzg//Uf5VuLpW6OlmM7GME3Zf5GWXsISoqrUmnxoEL6H3whhhAedpTrkjVkdC
CLeYSNKkj9XOJJR+EcljiGhk+KVi7nMpaedYCNHyHkTNpeCZJke5yHzJQuDM/yMh
ftC6DddxCnPs+I3VUQyNe638YxOI1TeDH+8+svEg0dFAAON5UrJqWnM8surfRMQo
HkswwsymeCgA9Ujnn9ozu8HOhGzN3fGo+0z86KUR8fi0UAu5fLf9VUn/5xNAshVm
hqp8gQJMzUxR+6G41vBGZ3iReR/bYH9peGR8UnBmFZQ12774wVGk3x95Y325Sxhr
7rRvKXJJSQiQMxO7aVcNtIOOn0TP3kYa5hrjBIVFGF6iPbvQ+lLXoNhUuN6C9dqT
crWjHKRm/hOtCuj8tOkcWRklYRVmtZmAdLY21P58iO8yb5gAqnUnRaEPphwbu3fx
IiEiY+Ak5afZgS/ZnmiX19gDYcfU40mQ68b8JpfeCAY+KKWrqUV7HNLSdLu4HZ/e
r6j28YK7OaVmH180AssWbBCyDWuuk7TwR4V5K0KMXTSE/ETEsZBT4Gir8o69I0c+
MIIw71s4hTNA/nbTxDYSmcS7ZgR0hN3K9hrm5aRnsMMSt8aHlcqhbsvDksVl510x
uywk/nbbnw6napRfBCUahM1jB7ZDgSSKEhCIWgqp6K9XrtRiumI=
=X7Ko
-----END PGP SIGNATURE-----

--2jeeo3rd6f6zlzog--
