From: Elie Morisse <syniurge@gmail.com>
Subject: Re: [PATCH v13] i2c: Add drivers for the AMD PCIe MP2 I2C controller
Date: Fri, 14 Dec 2018 12:53:12 -0300
Message-ID: <CAC_JBqqo5joUKBz1s7m0ccw0OXxqk57aiY93UEV4inumug6hBg@mail.gmail.com>
References: <20181209155602.GA8414@syn-yoga530> <20181211210159.to6okhbaqpymoax5@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211210159.to6okhbaqpymoax5@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, helgaas@kernel.org, Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com, sandeep.singh@amd.com, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi,

Having the patch reviewed by Nehal Shah would be great. While waiting
to hear from him, he voiced some concerns in the v10 thread:
https://lkml.org/lkml/2018/11/27/62
The _DEP hint was removed in v12. Regarding AMD's intention of having
two drivers, there are still two drivers, just within the same module.
And the comment about where the DMA mapping code should be is minor
and it's trivial to move it back if AMD plans to expand the platform
driver.

Noone reported any issue since v11, I'm done improving the drivers
unless it's necessary in order to get it accepted upstream. Please let
me know if I still have to change something to get it merged.

Elie Morisse

Le mar. 11 d=C3=A9c. 2018 =C3=A0 18:02, Wolfram Sang <wsa@the-dreams.de> a =
=C3=A9crit :
>
> On Sun, Dec 09, 2018 at 12:56:02PM -0300, Elie Morisse wrote:
> > MP2 controllers have two separate busses, so may accommodate up to two =
I2C
> > adapters. Those adapters are listed in the ACPI namespace with the
> > "AMDI0011" HID, and probed by a platform driver.
> >
> > Communication with the MP2 takes place through iomapped registers, or
> > through DMA for more than 32 bytes transfers.
> >
> > This is major rework of the patch submitted by Nehal-bakulchandra Shah =
from
> > AMD (https://patchwork.kernel.org/patch/10597369/).
> >
> > Most of the event handling of v3 was rewritten to make it work with mor=
e
> > than one bus (e.g on Ryzen-based Lenovo Yoga 530), and this version
> > contains many other improvements.
> >
> > Signed-off-by: Elie Morisse <syniurge@gmail.com>
>
> Nehal Shah, are you happy with this driver from your side?
>
