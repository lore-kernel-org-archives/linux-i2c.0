From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 6/6] Documentation: ACPI: Document probe-low-power _DSD property
Date: Tue, 21 Jan 2020 17:56:39 +0100
Message-ID: <CAJZ5v0ho8ry7iTXBTxHMjwcqT+EGT2mRy2rmp+o7rmG0apYimQ@mail.gmail.com>
References: <20200121134157.20396-1-sakari.ailus@linux.intel.com>
 <20200121134157.20396-7-sakari.ailus@linux.intel.com> <CAJZ5v0iJXUjK0n7mkqxagX9FtOmMsLqVMmU2xpQOLSb0aBWSMA@mail.gmail.com>
 <20200121161856.GZ5440@paasikivi.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20200121161856.GZ5440@paasikivi.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org, Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>, Hyungwoo Yang <hyungwoo.yang@intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Mani, Rajmohan" <rajmohan.mani@intel.com>, Tomasz Figa <tfiga@chromium.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 21, 2020 at 5:19 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> On Tue, Jan 21, 2020 at 05:09:44PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 21, 2020 at 2:41 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Document the probe-low-power _DSD property and how it is used with I²C
> > > drivers.
> > >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  .../acpi/dsd/probe-low-power.rst              | 28 +++++++++++++++++++
> > >  Documentation/firmware-guide/acpi/index.rst   |  1 +
> > >  2 files changed, 29 insertions(+)
> > >  create mode 100644 Documentation/firmware-guide/acpi/dsd/probe-low-power.rst
> > >
> > > diff --git a/Documentation/firmware-guide/acpi/dsd/probe-low-power.rst b/Documentation/firmware-guide/acpi/dsd/probe-low-power.rst
> > > new file mode 100644
> > > index 0000000000000..e0343ffefe071
> > > --- /dev/null
> > > +++ b/Documentation/firmware-guide/acpi/dsd/probe-low-power.rst
> > > @@ -0,0 +1,28 @@
> > > +.. SPDX-License-Identifier: GPL-2.0
> > > +
> > > +======================================
> > > +Probing I²C devices in low power state
> > > +======================================
> > > +
> > > +Introduction
> > > +============
> > > +
> > > +In some cases it may be preferred to leave certain devices powered off for
> > > +the entire system bootup if powering on these devices has adverse side
> > > +effects, beyond just powering on the said device. The _DSD property
> > > +"probe-low-power" has been defined for this purpose.
> >
> > Well, if you say "has been defined", you need to provide a pointer to
> > the definition document (a specification of some sort or similar).
>
> How about:
>
> s/has been defined/is used/

I would say "Linux recognizes the ... that can be used for this purpose."
