From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 1/2] mfd: ti-smusbdig: Add support for the TI
 SM-USB-DIG
Date: Thu, 16 Jun 2016 11:39:37 +0100
Message-ID: <20160616103937.GT4948@dell>
References: <20160613150800.6302-1-afd@ti.com>
 <20160615154303.GN4948@dell>
 <57617A1D.3050502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57617A1D.3050502@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 15 Jun 2016, Andrew F. Davis wrote:

> On 06/15/2016 10:43 AM, Lee Jones wrote:
> > This requires a USB Ack.
> >=20
> >> The TI SM-USB-DIG is a USB to SPI/I2C/1Wire/GPIO adapter.
> >> Add MFD core support.
> >>
> >> Signed-off-by: Andrew F. Davis <afd@ti.com>
> >> ---
> >=20
> > Where is the change log from v1 =3D> v2?
> >=20
>=20
> Looking at a diff of the two it looks like all the changes are relate=
d
> to your v1 feedback:
>=20
>  - Rename sm-usb-dig -> ti-smusbdig
>  - Inline helper functions in header
>  - Alphabetize includes

Please ensure this is added when you submit subsequent sets.  It
really does help with the review and saves a great deal of time.

> >> Changes from v2:
> >>  - Add missing dependency on USB, thanks kbuild test robot
> >>
> >>  drivers/mfd/Kconfig             |   9 +++
> >>  drivers/mfd/Makefile            |   2 +
> >>  drivers/mfd/ti-smusbdig.c       | 138 +++++++++++++++++++++++++++=
+++++++++++++
> >>  include/linux/mfd/ti-smusbdig.h |  75 ++++++++++++++++++++++
> >>  4 files changed, 224 insertions(+)
> >>  create mode 100644 drivers/mfd/ti-smusbdig.c
> >>  create mode 100644 include/linux/mfd/ti-smusbdig.h
> >=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
