From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: axxia: disable clks in case of failure in probe
Date: Thu, 22 Sep 2016 19:57:03 +0200
Message-ID: <20160922175703.GE1861@katana>
References: <1474057854-22545-1-git-send-email-khoroshilov@ispras.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50197 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966666AbcIVR5I (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 22 Sep 2016 13:57:08 -0400
Content-Disposition: inline
In-Reply-To: <1474057854-22545-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 16, 2016 at 11:30:54PM +0300, Alexey Khoroshilov wrote:
> axxia_i2c_probe() does not disable clock in case of failure
> in i2c_add_adapter(). Also it ignores returned value from
> clk_prepare_enable().
>=20
> Found by Linux Driver Verification project (linuxtesting.org).
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

The driver has changed. Can you rebase against i2c-next or linux-next?


--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX5BtvAAoJEBQN5MwUoCm2oqYP/RXv8DmZ+ZO/WdiDVKeGeV+B
zlvL0FDlSy41VPEB53Qp0gxvy5ZEXplA8dnrj7Mdp6wpIuGGOdu+pzma2ZJFB5Yk
CqpQLm0yHndnROVsu+7mHDbIPQYpoIA8cY6gDdwV/2eXEyTkfW9gKP5IIAKpsRg2
sXvhTcxG/UgLasbLhw9LTBJujv7filGfyWUITWYxQqt3BresVgdry1c4a6Qzbl3I
3+gGQBSo07aNW35hUO1b0iN7kLa24Q4lTCB1tFYBNQ+zRCgseK15sDHPhvs0n+gq
/Y6P3EBt+8nWRFPa2v0WHEDvEXdt9Yqbwo5vfh6l7+BcrBN+dD9+rgOb1r6AiX80
jtE9v1b3V78TU0x083D3dvoP6IDkwme+M8FYdBCf1l7bZILKuXeYn3kGRNHKfbgh
1CSm+rtimHekDEZDNdElLjcv+JN7XbTBZb8Ml0aYyyP5GxCutUxQABh5zIZAIQg/
QQnLyOtRjNKtI8EHAy8rXFPRX1tctLbegLHE7xwTdv5vIeYxRjrf9BmeYXdwm+Je
rv8bjPDHpscpVhRcOjxs8Ok2Cq921U/y4XWQ4ZEwbTVinG90V5wDud1VkZQdEU8T
qTqBSWVIQbvtnGWAKpwwj2lBDqvU7TmrgzqOlFI49XN3gpj8Q6n9wMuJrMJZ/syP
1vYCr8SqMTy1I2wD2bX9
=dUyD
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
