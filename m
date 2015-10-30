From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 0/6] enable I2C devices behind I2C bus on Gen2
Date: Fri, 30 Oct 2015 19:08:39 +0000
Message-ID: <20151030190839.GO4058@x1>
References: <1444213129-29793-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1445439954.22669.38.camel@linux.intel.com>
 <20151030185450.GM4058@x1>
 <CAHp75VcYBcG5uFgCDnv3MeQEXbPaWF3z7bvDauWZ8vYA_O32jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33057 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbbJ3TIr (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 30 Oct 2015 15:08:47 -0400
Received: by wmeg8 with SMTP id g8so18789605wme.0
        for <linux-i2c@vger.kernel.org>; Fri, 30 Oct 2015 12:08:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHp75VcYBcG5uFgCDnv3MeQEXbPaWF3z7bvDauWZ8vYA_O32jA@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Mika Westerberg <mika.westerberg@intel.com>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 30 Oct 2015, Andy Shevchenko wrote:

> On Fri, Oct 30, 2015 at 8:54 PM, Lee Jones <lee.jones@linaro.org> wro=
te:
> > On Wed, 21 Oct 2015, Andy Shevchenko wrote:
> >
> >> On Wed, 2015-10-07 at 13:18 +0300, Andy Shevchenko wrote:
> >> > There is a board in the wild, i.e. Intel Galileo Gen2, that has =
ACPI
> >> > enumerated
> >> > devices behind I2C bus.
> >>
> >> Lee, since Wolfram is going to apply patches 1 and 5, how could we
> >> proceed with the rest? Patches are indeed build independent, thoug=
h
> >> they are unified by enabling logically piece-by-piece. It would be
> >> great if you think you may apply them to your v4.4 queue.
> >
> > So we're just waiting for Thierry's Ack now, right?
>=20
> That's right. Either Ack, or he might apply patch by himself. It
> wouldn't be harmful in any case.

I'll give him another few days.  If we don't hear anything then I'll
apply them all bar the PWM patch.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
