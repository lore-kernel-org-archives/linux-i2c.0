From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Patch V2 0/9] I2C ACPI operation region handler support
Date: Tue, 29 Apr 2014 09:54:46 +0800
Message-ID: <535F0666.1090409@intel.com>
References: <1398147855-9868-1-git-send-email-tianyu.lan@intel.com> <1398695268-28645-1-git-send-email-tianyu.lan@intel.com> <43726986.W0L99n76oE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <43726986.W0L99n76oE-sKB8Sp2ER+y1GS7QM15AGw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, awilliam-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 2014=E5=B9=B404=E6=9C=8829=E6=97=A5 06:51, Rafael J. Wysocki wrote:
> On Monday, April 28, 2014 10:27:39 PM Lan Tianyu wrote:
>> ACPI 5.0 spec(5.5.2.4.5) defines GenericSerialBus(i2c, spi, uart) op=
eration
>> region. It allows ACPI aml code able to access such kind of devices =
to
>> implement some ACPI standard method.
>>
>> On the Asus T100TA, Bios use GenericSerialBus operation region to ac=
cess
>> i2c device to get battery info. So battery function depends on the I=
2C
>> operation region support. Here is the bug link.
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D69011
>>
>> This patchset is to add I2C ACPI operation region handler support.
>>
>> Change Since V1:
>>        Fix some code style and memory leak issues in Patch 7
>=20
> Is it the only patch that has changed from v1?


I also remove a redundant semicolon in the PATCH 8. Sorry. I didn't
notice these patches are already in your tree. I will produce divergenc=
e
patches based on your bleeding-edge branch.


>=20
> Rafael
>=20


--=20
Best regards
Tianyu Lan
