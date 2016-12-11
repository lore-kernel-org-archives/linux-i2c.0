From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 2/5] i2c: Add STM32F4 I2C driver
Date: Sun, 11 Dec 2016 22:42:33 +0100
Message-ID: <20161211214232.GA2552@katana>
References: <1481185563-8735-1-git-send-email-cedric.madianga@gmail.com>
 <1481185563-8735-3-git-send-email-cedric.madianga@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:47542 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753926AbcLKVmh (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 11 Dec 2016 16:42:37 -0500
Content-Disposition: inline
In-Reply-To: <1481185563-8735-3-git-send-email-cedric.madianga@gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
Cc: robh+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, linus.walleij@linaro.org, patrice.chotard@st.com, linux@armlinux.org.uk, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> +config I2C_STM32F4
> +	tristate "STMicroelectronics STM32F4 I2C support"
> +	depends on ARCH_STM32  || COMPILE_TEST

Double space.

> +#define STM32F4_I2C_MIN_FREQ		2
> +#define STM32F4_I2C_MAX_FREQ		42

Those two must be unsigned to fix the build error (e.g. 2U) reported by
build-bot.

Also, I get the following build warnings:

  CC      drivers/i2c/busses/i2c-stm32f4.o
drivers/i2c/busses/i2c-stm32f4.c: In function =E2=80=98stm32f4_i2c_handle_r=
x_addr=E2=80=99:
drivers/i2c/busses/i2c-stm32f4.c:445:6: warning: variable =E2=80=98sr2=E2=
=80=99 set but not used [-Wunused-but-set-variable]
  u32 sr2;
      ^~~
drivers/i2c/busses/i2c-stm32f4.c: In function =E2=80=98stm32f4_i2c_isr_even=
t=E2=80=99:
drivers/i2c/busses/i2c-stm32f4.c:496:41: warning: variable =E2=80=98sr2=E2=
=80=99 set but not used [-Wunused-but-set-variable]
  u32 real_status, possible_status, ien, sr2;

I assume those are reads to clear the register, so we really don't need
to save the value in a variable.

Rest is looking good.

Thanks,

   Wolfram


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYTchIAAoJEBQN5MwUoCm23iYP/je32KwTHgR2/HYeZleG8pvB
uvR3ZCM/7+9pkvovo7zHGTzZ1eLj90/KlXYg9u0BL68rcz+MHkthfmUOa19JVl6R
i0HFk6qBXgdLu9y1SdkLsSf4SdY67o09Pdxpzp1KSzPibk2IxH+4iGZ4fZ9qzybP
yr6Lh05LYwL+10qGNN6k9KcPdWsy9YZuuFRhOUG0Vy2a4ObI4RJIbmEkcxKhowFA
rIuTaSJyRUk8u+hv+h5PUbMnr25lREoxI/st2c196wrWseu3c+asT4jiJ57P3kyg
tHvHJuiCC3ieiNAicq5HJ3o/RTzBYB+IbPbg815g77JIOdSIm+TguZAHeXWO+vEP
sEp/+yzZ5MEafyTqhzAfIudkcrV86lTyXVSUGJZI74Rtp7TWHtN/E7FkvC8Pn93C
FbXK2ij8NI6B6iyjlKs6SYI+1xDyqulRioRWGbZiUPD/GOt8ZzS/aUSJVThMOkRl
xcCsU9gPr7BVzeVohsaj5sfqxKuRa31wOLoG795c2F7W2KuSH6klYVCuiM5rPrpp
DQdmAHTQ/7+BDpWF9+isAsolvKv3RVT45cVY/k/iNBePZtJyOnx9SaVpRw2GHJAN
cp4K0Q9dhBxB6BXEloceoUrd40qJ1bmnP9PRWurwTifm3mWccTpHumI2zxDBP/ca
AlpGILU4+Yb0TWwS347b
=w/Jd
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
