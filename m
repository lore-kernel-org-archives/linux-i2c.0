From: Vadim Pasternak <vadimp@mellanox.com>
Subject: RE: [patch v9 1/1] i2c: add master driver for mellanox systems
Date: Thu, 24 Nov 2016 14:55:35 +0000
Message-ID: <AM5PR0501MB2097CA728A63D56B51261BA7A2B60@AM5PR0501MB2097.eurprd05.prod.outlook.com>
References: <1479660974-143713-1-git-send-email-vadimp@mellanox.com>
 <20161124145201.GD4271@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0059.outbound.protection.outlook.com ([104.47.2.59]:17180
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755615AbcKXUbi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 24 Nov 2016 15:31:38 -0500
In-Reply-To: <20161124145201.GD4271@katana>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: "wsa@the-dreams.de" <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, Michael Shych <michaelsh@mellanox.com>



> -----Original Message-----
> From: Wolfram Sang [mailto:wsa-dev@sang-engineering.com]
> Sent: Thursday, November 24, 2016 4:52 PM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: wsa@the-dreams.de; linux-i2c@vger.kernel.org; linux-
> kernel@vger.kernel.org; jiri@resnulli.us; Michael Shych
> <michaelsh@mellanox.com>
> Subject: Re: [patch v9 1/1] i2c: add master driver for mellanox systems
>=20
> On Sun, Nov 20, 2016 at 04:56:14PM +0000, vadimp@mellanox.com wrote:
> > From: Vadim Pasternak <vadimp@mellanox.com>
> >
> > Device driver for Mellanox I2C controller logic, implemented in
> > Lattice CPLD device.
> > Device supports:
> >  - Master mode
> >  - One physical bus
> >  - Polling mode
> >
> > The Kconfig currently controlling compilation of this code is:
> > drivers/i2c/busses/Kconfig:config I2C_MLXCPLD
> >
> > Signed-off-by: Michael Shych <michaelsh@mellanox.com>
> > Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> > Reviewed-by: Jiri Pirko <jiri@mellanox.com>
> > Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
>=20
> Applied to for-next, thanks!

Thank you very,

Vadim.
