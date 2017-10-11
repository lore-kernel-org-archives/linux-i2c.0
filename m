From: "Wu, Aaron" <Aaron.Wu@analog.com>
Subject: RE: [Adi-buildroot-devel] [PATCH 4/7] i2c: gpio: Augment all
 boardfiles to use open drain
Date: Wed, 11 Oct 2017 10:37:03 +0000
Message-ID: <649EF91064D35D40B9C93A225BF41674ADD7CEFD@NWD2MBX6.ad.analog.com>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-5-linus.walleij@linaro.org>
 <20171009142824.GB17971@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-dm3nam03on0064.outbound.protection.outlook.com ([104.47.41.64]:5315
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753256AbdJKKhK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 11 Oct 2017 06:37:10 -0400
In-Reply-To: <20171009142824.GB17971@linux-mips.org>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Steven Miao <realmz6@gmail.com>, "adi-buildroot-devel@lists.sourceforge.net" <adi-buildroot-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi all,

Steven is no longer working on this for ADI. Acked by me if this works. Tha=
nks.

Best regards,
Aaron Wu
Analog Devices Inc.

-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]=20
Sent: Monday, October 09, 2017 10:28 PM
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@linux-mips.org; Steven Miao <realmz6@gmail.com>; adi-buildro=
ot-devel@lists.sourceforge.net; Geert Uytterhoeven <geert@linux-m68k.org>; =
linux-i2c@vger.kernel.org; linux-arm-kernel@lists.infradead.org
Subject: Re: [Adi-buildroot-devel] [PATCH 4/7] i2c: gpio: Augment all board=
files to use open drain

On Sun, Sep 17, 2017 at 11:39:03AM +0200, Linus Walleij wrote:

> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf

---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most engaging te=
ch sites, Slashdot.org! http://sdm.link/slashdot __________________________=
_____________________
Adi-buildroot-devel mailing list
Adi-buildroot-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/adi-buildroot-devel
