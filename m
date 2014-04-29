From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [Patch V2 0/9] I2C ACPI operation region handler support
Date: Tue, 29 Apr 2014 17:47:11 +0200
Message-ID: <1527127.pmk7LiQ709@vostro.rjw.lan>
References: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com> <43726986.W0L99n76oE@vostro.rjw.lan> <535F0666.1090409@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <535F0666.1090409@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: wsa@the-dreams.de, mika.westerberg@linux.intel.com, awilliam@redhat.com, lenb@kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday, April 29, 2014 09:54:46 AM Lan Tianyu wrote:
> On 2014=E5=B9=B404=E6=9C=8829=E6=97=A5 06:51, Rafael J. Wysocki wrote=
:
> > On Monday, April 28, 2014 10:27:39 PM Lan Tianyu wrote:
> >> ACPI 5.0 spec(5.5.2.4.5) defines GenericSerialBus(i2c, spi, uart) =
operation
> >> region. It allows ACPI aml code able to access such kind of device=
s to
> >> implement some ACPI standard method.
> >>
> >> On the Asus T100TA, Bios use GenericSerialBus operation region to =
access
> >> i2c device to get battery info. So battery function depends on the=
 I2C
> >> operation region support. Here is the bug link.
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D69011
> >>
> >> This patchset is to add I2C ACPI operation region handler support.
> >>
> >> Change Since V1:
> >>        Fix some code style and memory leak issues in Patch 7
> >=20
> > Is it the only patch that has changed from v1?
>=20
>=20
> I also remove a redundant semicolon in the PATCH 8. Sorry. I didn't
> notice these patches are already in your tree. I will produce diverge=
nce
> patches based on your bleeding-edge branch.

No need for that, I'll use the new versions.

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
