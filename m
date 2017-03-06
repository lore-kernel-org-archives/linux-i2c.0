From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: Possible Regression caused by "[PATCH] i2c: riic: correctly
 finish transfers"
Date: Mon, 6 Mar 2017 13:34:55 +0000
Message-ID: <SG2PR06MB116521B4B60AD78B66EA13D58A2C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170306111637.GA28805@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:60226 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753115AbdCFNfB (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 6 Mar 2017 08:35:01 -0500
In-Reply-To: <20170306111637.GA28805@verge.net.au>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Wolfram Sang <wsa@the-dreams.de>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Simon,

On Monday, March 06, 2017, Simon Horman wrote:
> Hi,
>=20
> I have noticed a regression in v4.11-rc1 since v4.10 on r7s72100/Genmai.
>=20
> With some assistance from Geert I have isolated the problem as being
> caused by 71ccea095ea1 ("i2c: riic: correctly finish transfers").


I just tried v4.11-rc1 with the RSK and it boots fine. However:
 1. The RSK DTS is not probing a I2C EEPROM on boot like the GENMAI DTS (wh=
ich is
    Where the hang up seems to be)

 2. There is no PFC code yet upstream, (my RSK/u-boot has it) so now that
   the driver is actually waiting for a STOP condition, it might never get =
it because
   the pins are not actually configured.

When I get to the office, I'll dig out my GENMAI board and try it.


Chris
