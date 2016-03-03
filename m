From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] i2c: mediatek: i2c multi transfer optimization
Date: Thu, 3 Mar 2016 22:18:35 +0100
Message-ID: <20160303211835.GC1501@katana>
References: <1456421739-5450-1-git-send-email-liguo.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:45673 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758105AbcCCVSm (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 3 Mar 2016 16:18:42 -0500
Content-Disposition: inline
In-Reply-To: <1456421739-5450-1-git-send-email-liguo.zhang@mediatek.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Liguo Zhang <liguo.zhang@mediatek.com>
Cc: srv_heupstream@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Xudong Chen <xudong.chen@mediatek.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 01:35:39AM +0800, Liguo Zhang wrote:
> Send the next transfer in the i2c irq handler, and only signal
> complete() when the entire transaction has been completed.

This describes what you do. But not why. Is this an improvment of
throughput? Is there a downside of interrupt latency?

Thanks.

>=20
> Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> ---
> change in v2:
> Remove the unused variable left_num in mtk_i2c_transfer().

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW2KorAAoJEBQN5MwUoCm2p3EP/1CyMQ/2QGu59Qz0je8uKiUZ
CwEQJKgwh7AXuyCHczdHezhGtVpGkc2Qpgodty2ELyiujTAH5TkzOScL3cD8yyHr
AVve4pT3Atq9MFRAIOHJGmShf1HMTbfa/IyNTcny3QjuIti+ncgdMdVzxfFZxguW
g0s2gTG5Jz6SDHZfzz7eLD4ct1FW4JpUk0mDM6ZdQfS2fXbg9zGPgcsfb0mwXoue
emga0lRk9hQcPm5HSUfQ5TxRMFe3i1I+qu4RZ5K+fndIcvRAAUbRd30vHDNWOWDi
YPJ+WjeFChFRGtKeUvm0OTtjfnYJ7gJq2Zv4LyZ13vsDEqUx7zHZ50JfBbeIUQd1
n2gn424Dbn9vxMSKdJL8WQMr546NDPWgbBuyWE6V4BsSN3gI1eXlIGV4EpbH8i08
olXfdPCiIBEi7POluh4dcsR9t0KfebmvYokcju6EJmSLBCFXkEdM/42ifS+N/7lS
nlbyXKyGMM0K+cnXb/PyShsT0LLqV8NWRvhFro06sO0Ex4i8vtRQFQURXTuvrgzq
aQTd30JaEwwzub0Phh2uqiPT06Em/37g1VTtYQ5uSVKBt6Ld6svKNoyEYOe6iKMQ
HUzc+1354kZRjh0+VZgCimWlyt6Pix0O4Ii/ug7dmpbff5IOiuITJVwSVt0OBG7k
PHKvmReh3W+py3hfZl3G
=EL2G
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
