From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [wsa:i2c/for-current 2/2]
 drivers/i2c/busses/i2c-imx-lpi2c.c:642:2: error: implicit declaration of
 function 'pinctrl_pm_select_sleep_state'
Date: Thu, 26 Jan 2017 00:27:39 +0100
Message-ID: <20170125232739.GA2242@katana>
References: <201701260730.JLSp8dq5%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:35606 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752126AbdAYX1n (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 25 Jan 2017 18:27:43 -0500
Content-Disposition: inline
In-Reply-To: <201701260730.JLSp8dq5%fengguang.wu@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Gao Pan <pandy.gao@nxp.com>, kbuild-all@01.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa-dev@sang-engineering.com>, Vladimir Zapolskiy <vz@mleia.com>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

>    drivers/i2c/busses/i2c-imx-lpi2c.c: In function 'lpi2c_imx_suspend':
> >> drivers/i2c/busses/i2c-imx-lpi2c.c:642:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
>      pinctrl_pm_select_sleep_state(dev);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OK, I added the missing include and amended the change. Branches were
not out for long, so I hope nobody notices the rebase.


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYiTRrAAoJEBQN5MwUoCm2/VoP+wcQnzkZm+8pqWBff0Zy4A4Z
4IgPVD1A8kk8OuOt0oGsEPQr2MSsSwHC7woat0VA46GjLg2dlAajahbsj8NkLZ+l
vh4S46YuX77/YlC+4dYmNHueIGWtshVpUfi6PmCzzD47aJLQAeGk6AI5vLoen9oR
MdL/jwqt7BZ0XvXXBk4s6N40BSgcRctmXtfs+SJkBW4cR97PWqnCcFRUXa79zVx/
7pxc53NA2RAYLE6Dmd3nCXOFM5DKKJOxH1Xz5A/CWzQvh7xzhK6SIZ9XPUd9mmXU
p71S5r5YL9AJf8cOm4fIwBuLRJZJJi3/bNUXdOpVgvwem/TH6/ZOczKry3cCgxF1
e/bmjgQizjsy0EQBkfGTrfCq4rNnVgTGFv6VZcKlNEm/0X/3BvtUff4V6naGsR5g
dq8/OwFLSjy/IJIZhUFqgOSX6Ptozqo1268YToCRbufi89lEE1RJFucP6WIsIWUN
6IHtoRG2seOnDFy6ow4rm/EdocC74mi/56oXq4cDGaflKnUKQnqlEM1iPqahX/c8
Lvdh7mxNm/u2J11HGFvHuwcWed40DF4Wp7uJspfbyMf85KltsTGCg/8aw1lNQWYe
3l+WuP7kqy7aC3wdACYuRAfSPVUlm/lhDuH7zuUXUkeSX3eyl4C9lMjVXyw58Bpx
Mq/VqUVvLSv1oRQRNGo/
=Ns5+
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
