From: Ruslan Babayev <ruslan@babayev.com>
Subject: Re: [PATCH net-next v2 1/2] i2c: acpi: export i2c_acpi_find_adapter_by_handle
Date: Mon, 27 May 2019 19:03:44 -0700
Message-ID: <874l5f9vy7.fsf@babayev.com>
References: <20190505193435.3248-1-ruslan@babayev.com> <20190525005302.27164-1-ruslan@babayev.com> <20190527184743.GA8808@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20190527184743.GA8808@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ruslan Babayev <ruslan@babayev.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, xe-linux-external@cisco.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


Wolfram Sang writes:

> On Fri, May 24, 2019 at 05:53:01PM -0700, Ruslan Babayev wrote:
>> This allows drivers to lookup i2c adapters on ACPI based systems similar=
 to
>> of_get_i2c_adapter_by_node() with DT based systems.
>>=20
>> Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
>> Cc: xe-linux-external@cisco.com
>
> Please have a look how your patches look in my inbox:
>
> May 05 Ruslan Babayev  ( 129) [PATCH] net: phy: sfp: enable i2c-bus detec=
tion on ACPI based systems
> May 05 Ruslan Babayev  (  65) =E2=94=9C=E2=94=80>[PATCH 1/2] i2c: acpi: e=
xport i2c_acpi_find_adapter_by_handle
> May 24 Ruslan Babayev  (  65) =E2=94=94=E2=94=80>[PATCH net-next v2 1/2] =
i2c: acpi: export i2c_acpi_find_adapter_by_handle
> May 05 Ruslan Babayev  (  65) [PATCH net-next 1/2] i2c: acpi: export i2c_=
acpi_find_adapter_by_handle
> May 06 Ruslan Babayev  (   3) =E2=94=9C=E2=94=80>[PATCH RFC v2 net-next] =
Enable SFP support on ACPI
> May 06 Ruslan Babayev  (  65) =E2=94=9C=E2=94=80>[PATCH RFC v2 net-next 1=
/2] i2c: acpi: export i2c_acpi_find_adapter_by_handle
> May 06 Ruslan Babayev  ( 120) =E2=94=94=E2=94=80>[PATCH RFC v2 net-next 2=
/2] net: phy: sfp: enable i2c-bus detection on ACPI based systems
> May 07 Ruslan Babayev  ( 154)   =E2=94=94=E2=94=80&=E2=94=80>
> May 07 Ruslan Babayev  (  10)     =E2=94=94=E2=94=80>
> May 22 Ruslan Babayev  (  29)       =E2=94=94=E2=94=80>
> May 05 Ruslan Babayev  (  93) [PATCH net-next 2/2] net: phy: sfp: enable =
i2c-bus detection on ACPI based systems
> May 06 Ruslan Babayev  (  25) =E2=94=9C=E2=94=80&=E2=94=80>
> May 06 Ruslan Babayev  (  99) =E2=94=94=E2=94=80&=E2=94=80>
>
> This is highly confusing, and super hard to find out which patches belong
> together. v2 2/2 seems even missing. Please resend this as a new series w=
ithout
> any in-reply-to, and a fresh cover-letter, so I know which one to apply t=
o my
> tree.
>
> Thanks,
>
>    Wolfram

Will do, sorry about that.
