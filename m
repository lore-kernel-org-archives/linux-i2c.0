From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v5 2/2] i2c: rk3x: add i2c support for rk3399 soc
Date: Thu, 14 Apr 2016 20:48:48 +0200
Message-ID: <20160414184848.GB2338@katana>
References: <1458147438-62387-1-git-send-email-david.wu@rock-chips.com>
 <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:43648 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754178AbcDNSsy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 14 Apr 2016 14:48:54 -0400
Content-Disposition: inline
In-Reply-To: <1458147438-62387-3-git-send-email-david.wu@rock-chips.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: David Wu <david.wu@rock-chips.com>
Cc: heiko@sntech.de, dianders@chromium.org, andy.shevchenko@gmail.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, David Wu <wdc@rock-chips.com>


--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> + - input-clk-rate : frequency rate of function clock used(in Hz). If omitted,
> +	the default clock rate is used. It is just used at rk3399 soc.

Why is this needed? Why don't we simply use the default or calculate the
best value somehow?

> + * @t_calc: Caculated rk3x private timings  that would
> + * be written into regs

double space


--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXD+YPAAoJEBQN5MwUoCm2CbIP/1DYo12nDzyKYowD8vGoq2/G
jVyw8m5squQpCdpcb04C2D6BGl3bWffDtaE/+GTFtXD3qQOEfl/1ETcfBGqTFXem
eWvwABc+Hoc5Xu0QDYhX0jUTsIQTxX9ieFApnSat1WDm0VDpX8U7vbX36kp/nFcX
HZycF3MjGibV6Tjr8N+kFMYTPKNf90Kq1zh5lngE1euCAU1KjtOORWs7Mgyqimse
4lFoSQG/W1nmh+z6adhL+DgRwC1wDgVZSNOGebG45DT4Jm14DCWFuFe3Q8z1CIv3
pWDjCyK+OwNMy0C3AD6orbeWYNnaBvBNHEjoRzJ+ENSEYWL9o1xwRUlAjPUgNOs+
Q+gEYXtLsZcdUvvTiJe+x3lz4vC+lJnFjNcCiXpX9ITJ/kV/CrIsakADMsT0eXBR
vswPLT+tci9YqdLqKd7dy/Tjo/IkSv4In9WJc9wgmjGAghv9RIMdRdXfCD6VzVrW
OePvO7CCWegoRASGsoPOB09R71tx5jyrLIe7XxGR8GBEARHUnsS0d0eUvB9YqF0H
fAIkzE9dnhTBBC2DAjTJn717RukhT65RMmAmKFdfQ8DLrsE8l1IQs5F00b3yHuMC
MA3ffNQbfyECKfj2nKLX4GZTuOY4pQgFfyuHYsaCcKlJdK+RU9VfwVtnKZQS8AVd
UA9x1/7Td7fPeHo5ERin
=r0mK
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--
