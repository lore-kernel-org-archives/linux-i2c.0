From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Properly handle DMA safe buffers
Date: Wed, 19 Sep 2018 22:45:28 +0200
Message-ID: <20180919204527.GA889@kunai>
References: <20180918194126.138455-1-swboyd@chromium.org>
 <20180918221646.GA970@kunai>
 <153738150448.119890.13258586980997802695@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <153738150448.119890.13258586980997802695@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, Girish Mahadevan <girishm@codeaurora.org>
List-Id: linux-i2c@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> But now when I try to use it I'm not exicted when the buffer is bounced
> but we fail to map the buffer with the DMA APIs. For an I2C_M_RD

Yes, this was reported before and the function to unmap looks different
now as of v4.19-rc2...

> the buffer that we setup. Or we can pass an argument to
> i2c_release_dma_safe_msg_buf() to indicate if we should do the memcpy or
> not?

... exactly like this :)


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAluitWMACgkQFA3kzBSg
KbaAFg//dqDFAfIoJUMAhhmlYtZ0393th0MNeamqeo9Tc79PJktgV88y1d08K52B
oEqQwcgZWVHlQOB+5I66by6GohvIvY+U4DkHao7yrI+I9W+o3J22ajDdHt+MkBkr
2FdFs7db/cOh9eqz/3Purvt1jlNM3aIWQuq4LzkBmipH1RCOn0a/HpTjYDa5/HXR
R39eNpvBjT/OPvsxveZZlDpBIyW2G5K93AkXfC30VKtP0U8x629KEf4RMCcsnFtr
tW89p0bFyb1FnEvP+PmmfgFM2CYMAIBYtiy8cUO0r2SR66lFaWtVP4nDk8KWKb0m
NLImRi1iusddiwBp3h8yEswB4jcnpFzr4cQUW0BmksA2VXLW5E+Se7KefbbrUQmP
+1IaCQF60RuKQLvgGZMrzw5+sxTZJXI4HLG4Aa4yHPyY+CXQQhULReTGaNSvYHgH
wer8sMyQN29z2gptRj2Ut77xQMV15H8l+DPi62WDGK5efvuJrwykB6ExQwgoMnzw
iCF6mcMZ+jVZOEYoovcZaVunxjhZVKZTkCRRFixHlLn6CAijoS/QOooCe3aQn2yk
GVkTr5nTiyfPkPckZBAhmTmd8ahgMpJNoG0IKzTPTms5RnCKxjh8JC/OTaowtUMt
N7qeA9qrr0Ao7H85FLpio63iTwFK11Qk7wh0EJiTVzw0LmRxkak=
=2mSM
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
