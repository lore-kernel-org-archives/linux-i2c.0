From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] i2c: uniphier: add UniPhier FIFO-less I2C driver
Date: Thu, 22 Oct 2015 22:59:09 +0200
Message-ID: <20151022205908.GA1516@katana>
References: <1438243942-26401-1-git-send-email-yamada.masahiro@socionext.com>
 <1438243942-26401-2-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:60171 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932560AbbJVU7Y (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 22 Oct 2015 16:59:24 -0400
Content-Disposition: inline
In-Reply-To: <1438243942-26401-2-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-i2c@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Anders Berg <anders.berg@avagotech.com>, Max Schwarz <max.schwarz@online.de>, David Box <david.e.box@linux.intel.com>, Wei Yan <sledge.yanwei@huawei.com>, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, Andrew Bresticker <abrestic@chromium.org>, linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Baruch Siach <baruch@tkos.co.il>, Xudong Chen <xudong.chen@mediatek.com>, Lee Jones <lee.jones@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Sachin Kamat <sachin.kamat@samsung.com>, Ray Jui <rjui@broadcom.com>, linux-arm-kernel@lists.infradead.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 05:12:20PM +0900, Masahiro Yamada wrote:
> Add support for on-chip I2C controller used on old UniPhier SoCs
> such as PH1-LD4, PH1-sLD8, etc..  This adapter is so simple that
> it has no FIFO in it.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Finally! Mostly looking good.

> +static u32 uniphier_i2c_functionality(struct i2c_adapter *adap)
> +{
> +	return I2C_FUNC_I2C;
> +}

No I2C_FUNC_SMBUS_EMUL? But check if SMBUS_QUICK is supported by your
adapter.

> +	regs =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!regs) {
> +		dev_err(dev, "failed to get memory resource");
> +		return -EINVAL;
> +	}

This 'if'-block can go. devm_ioremap_resource will check it for you.

Thanks,

   Wolfram


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKU4cAAoJEBQN5MwUoCm227YQAIGUmTq2I/tQj9zEHSl3PAPS
7vLVfXu/ThrYeoGKL+A+MEre/7g+aYheKF//CAhXX9pSxoG1TwvkYsww52SLLCv3
pYfNzS+B5wJr7mDMVPiSbflUmrrLtMODUA7HTKCpdzAnhZRfKq3Myqm2PvLo3fB7
KCx443r8B48EHTIGAHQ9eARqdnJxP7G8JA3zky4CEsxa9IEqXiDPqwi7Bq9GWRqU
tdRVOpF9DgzUScd9YpO+u1BmPXzV/blAJ0dpLLylEic3khcVN3doYQNvYHZzcs6b
Z3hJ3hR9aNLx1oYRbwmb14EFXx+MsSXEJceQMrTP+VKifhJwuIWdWqxCtgas5GzH
2HM8DchdzzFI1aQSenhFHhwI9sT/c9XCIABqQhyvxINVw1tkrkG4bVmwmiK/UPKz
/wcHiF3Zz8xbcKupNGQVcg0lMtEnrTSkmahvGVq63OT+qmUoFZvIv0tG22cNEyA5
8PXakbz07zkmUSN0c4a5cQ55M4qEBYCtCdxWRFhNiJOR87czlKbBzD8iBkdGtOzy
5TMNks0PWzFltSZPVJM72iDqr7JIZnGi2Q/jyTAJbvbBHIAmel3YvFbfDXH0Hsdo
KwQn19n1okQpWKd9Eo8PsG45v2SFD1VHanSbBYAQPxxORJ7WBtOVznqv/Onr3N8T
MejUppof1B/6zeiEOcBI
=w3op
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
