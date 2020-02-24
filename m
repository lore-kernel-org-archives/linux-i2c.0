From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH v1 26/40] i2c: riic: Use generic definitions for bus
 frequencies
Date: Mon, 24 Feb 2020 16:48:54 +0000
Message-ID: <TY1PR01MB1562EA8B9260B64E08843E168AEC0@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20200224151530.31713-1-andriy.shevchenko@linux.intel.com>
 <20200224151530.31713-26-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr1400092.outbound.protection.outlook.com ([40.107.140.92]:20832
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbgBXQs7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 24 Feb 2020 11:48:59 -0500
In-Reply-To: <20200224151530.31713-26-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Mon, Feb 24, 2020 1, Andy Shevchenko wrote:
> Subject: [PATCH v1 26/40] i2c: riic: Use generic definitions for bus
> frequencies
>=20
> Since we have generic definitions for bus frequencies, let's use them.
>=20
> Cc: Chris Brandt <chris.brandt@renesas.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-riic.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Chris Brandt <chris.brandt@renesas.com>
