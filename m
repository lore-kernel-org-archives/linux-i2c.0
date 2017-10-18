From: Chris Brandt <Chris.Brandt@renesas.com>
Subject: RE: [PATCH] i2c: riic: remove clock and frequency restrictions
Date: Wed, 18 Oct 2017 16:41:57 +0000
Message-ID: <SG2PR06MB1165C76C6B35511B21CC70668A4D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20171018140459.104351-1-chris.brandt@renesas.com>
 <20171018163725.ik6ieofpd6ehilbo@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from relmlor1.renesas.com ([210.160.252.171]:37237 "EHLO
        relmlie4.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750829AbdJRQmC (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 18 Oct 2017 12:42:02 -0400
In-Reply-To: <20171018163725.ik6ieofpd6ehilbo@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

On Wednesday, October 18, 2017 1, Wolfram Sang wrote:
> > +	brl -=3D t->scl_fall_ns / (1000000000/rate);
> > +	brh -=3D t->scl_rise_ns / (1000000000/rate);
>=20
> However you solve the precision issue, please take care about the "space
> around operators" rule afterwards. checkpatch should help you there.

OK.

I ran checkpatch and fixed everything it found, but it didn't flag that one=
.


$ scripts/checkpatch.pl z_patches/riic/S4V1/*
total: 0 errors, 0 warnings, 169 lines checked

z_patches/riic/S4V1/0001-i2c-riic-remove-clock-and-frequency-restrictions.p=
atch has no obvious style problems and is ready for submission.


Chris
