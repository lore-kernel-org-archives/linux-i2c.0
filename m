From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH 4/4] platform/chrome: i2c: i2c-cros-ec-tunnel: Convert i2c
 tunnel to MFD Cell
Date: Fri, 22 Nov 2019 02:42:53 -0800
Message-ID: <CABXOdTf7Oo-qPSnC040Tgxhn3mCogKo=WCsxo_Kj+C+f9DOCyw@mail.gmail.com>
References: <20191121211053.48861-1-rrangel@chromium.org> <20191121140830.4.Iddc7dd74f893297cb932e9825d413e7890633b3d@changeid>
 <CABXOdTeotUnO_7k9UycJ0vJEKV8pdZOjRrepDv5WVo5RmOLnEA@mail.gmail.com> <20191122080319.GC3296@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122080319.GC3296@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Raul E Rangel <rrangel@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Wolfram Sang <wsa@the-dreams.de>, Akshu.Agrawal@amd.com, Guenter Roeck <groeck@chromium.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, Benson Leung <bleung@chromium.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 22, 2019 at 12:03 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 21 Nov 2019, Guenter Roeck wrote:
>
> > On Thu, Nov 21, 2019 at 1:11 PM Raul E Rangel <rrangel@chromium.org> wr=
ote:
> > >
> > > If the i2c-cros-ec-tunnel driver is compiled into the kernel, it is
> > > possible that i2c-cros-ec-tunnel could be probed before cros_ec_XXX
> > > has finished initializing and setting the drvdata. This would cause a
> > > NULL pointer panic.
> > >
> > > Converting this driver over to an MFD solves the problem and aligns w=
ith
> > > where the cros_ec is going.
> > >
> >
> > I thought the mfd maintainer objects to the use of the mfd API outside
> > drivers/mfd. Did that change recently ?
>
> It hasn't changed, although I don't see that here?
>
Sorry, I was confused.

Guenter

> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > > ---
> > > You can now see the device node lives under the mfd device.
> > >
> > > $ find /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunne=
l.12.auto/ -iname firmware_node -exec ls -l '{}' \;
> > > /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.au=
to/firmware_node -> ../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/de=
vice:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00
> > > /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.au=
to/i2c-9/firmware_node -> ../../../../../../../LNXSYSTM:00/LNXSYBUS:00/PNP0=
A08:00/device:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00
> > > /sys/bus/platform/devices/cros-ec-dev.0.auto/cros-ec-i2c-tunnel.12.au=
to/i2c-9/i2c-10EC5682:00/firmware_node -> ../../../../../../../../LNXSYSTM:=
00/LNXSYBUS:00/PNP0A08:00/device:1c/PNP0C09:00/GOOG0004:00/GOOG0012:00/10EC=
5682:00
> > >
> > >  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 36 +++++++++--------------=
--
> > >  drivers/mfd/cros_ec_dev.c               | 19 +++++++++++++
> > >  2 files changed, 32 insertions(+), 23 deletions(-)
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
