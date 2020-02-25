From: Laine Jaakko EXT <ext-jaakko.laine@vaisala.com>
Subject: RE: [PATCH] i2c: xiic: Support disabling multi-master in DT
Date: Tue, 25 Feb 2020 14:27:21 +0000
Message-ID: <AM0PR06MB5185341478B6919A9CC22271D4ED0@AM0PR06MB5185.eurprd06.prod.outlook.com>
References: <20200218135627.24739-1-ext-jaakko.laine@vaisala.com>
 <481fe028-0ec6-eca3-7436-ebbb8527f3d8@xilinx.com>
 <AM0PR06MB518514EE9C057CB129079825D4ED0@AM0PR06MB5185.eurprd06.prod.outlook.com>
 <20200225141357.GE3677@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:4876
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730734AbgBYO1Z (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Tue, 25 Feb 2020 09:27:25 -0500
In-Reply-To: <20200225141357.GE3677@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Michal Simek <michal.simek@xilinx.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shubhrajyoti Datta <shubhraj@xilinx.com>

-----Original Message-----
From: Wolfram Sang <wsa@the-dreams.de>=20
Sent: Tuesday, 25 February, 2020 16:14
To: Laine Jaakko EXT <ext-jaakko.laine@vaisala.com>
Cc: Michal Simek <michal.simek@xilinx.com>; linux-i2c@vger.kernel.org; linu=
x-arm-kernel@lists.infradead.org; Shubhrajyoti Datta <shubhraj@xilinx.com>
Subject: Re: [PATCH] i2c: xiic: Support disabling multi-master in DT

> My favourite is to change alignment to be just one space. Then, we have
> a bit of overhead now, but never again in the future.

Ok, I will add that change as separate patch to V2 patch series.

Thanks,
Jaakko
