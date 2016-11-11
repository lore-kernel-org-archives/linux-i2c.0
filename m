From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch v5+1 repost] i2c: mux: mellanox: add driver
Date: Fri, 11 Nov 2016 11:45:50 +0000
Message-ID: <AM5PR0501MB20972E41C17AF2642A5E194EA2BB0@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1478813183-134553-1-git-send-email-vadimp@mellanox.com>
 <cd343dec-3154-19b2-c5ca-1947e49bc886@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0050.outbound.protection.outlook.com ([104.47.2.50]:10176
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750714AbcKKLpy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 11 Nov 2016 06:45:54 -0500
In-Reply-To: <cd343dec-3154-19b2-c5ca-1947e49bc886@axentia.se>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, "wsa@the-dreams.de" <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>



> -----Original Message-----
> From: Peter Rosin [mailto:peda@axentia.se]
> Sent: Friday, November 11, 2016 10:36 AM
> To: Vadim Pasternak <vadimp@mellanox.com>; wsa@the-dreams.de
> Cc: linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; jiri@resnull=
i.us;
> Michael Shych <michaelsh@mellanox.com>
> Subject: Re: [patch v5+1 repost] i2c: mux: mellanox: add driver
>=20
> On 2016-11-10 22:26, vadimp@mellanox.com wrote:
> > From: Vadim Pasternak <vadimp@mellanox.com>
> >
> > This driver allows I2C routing controlled through CPLD select
> > registers on a wide range of Mellanox systems (CPLD Lattice device).
> > MUX selection is provided by digital and analog HW. Analog part is not
> > under SW control.
> > Digital part is under CPLD control (channel selection/de-selection).
>=20
> *snip*
>=20
> Thanks for your patience!
>=20
> I changed my Acked-by into a Signed-off-by, fixed up a few multi-line com=
ment
> formatting issues, and pushed it to the i2c-mux/for-next branch at
> https://github.com/peda-r/i2c-mux.git

Thank you very much, Peter.

Cheers,
Vadim.

>=20
> Cheers,
> Peter
