From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/1] misc: Add Tunnel creek In-Vehicle I2C loader driver
Date: Fri, 15 Oct 2010 10:49:02 +0200
Message-ID: <20101015104902.1047c978@endymion.delvare>
References: <1283956897.4593.12.camel@debian>
	<4CA2FB10.2020605@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4CA2FB10.2020605-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard =?ISO-8859-1?B?UvZqZm9ycw==?= <richard.rojfors-gfIc91nka+FZroRs9YW3xA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Richard,

On Wed, 29 Sep 2010 10:38:40 +0200, Richard R=F6jfors wrote:
> On 09/08/2010 04:41 PM, Richard R=F6jfors wrote:
> > To follow is a patch adding a driver which adds devices to the I2C
> > bus on tunnel creek in-vehicle development boards.
>=20
> I never got any feedback on my patch.
>=20
> It doesn't seem like misc has it own mailinglist so I suppose this is
> where it should be posted(?)
>=20
> The reason for the driver is the lack of board config in X86 so there=
 is
> simply no way to define the devices on the I2C bus. It can not be don=
e
> from the user space, since GPIO pins need to be turned into interrupt=
s
> numbers and passed in the platform data to the I2C devices.
>=20
> Any suggestions how to move forward to get such driver into the kerne=
l?

I don't like the idea of such "loader" drivers. If we need to have such
a separate driver for every embedded x86 system, things will get pretty
ugly quickly. I know we already have at least two somewhat similar
drivers (i2c-amd756-s4882 and i2c-nforce2-s4985) but I really would
like to get rid of them, not add more of the same type.

My impression is that x86 doesn't have board config because it wasn't
so far an architecture used for embedded systems. But times are
changing, and now x86 starts being used for embedded systems. Instead
of coming up with a new way of handling I2C device instantiation
("loader" drivers), I think we simply want to add board config support
to x86 as many other architectures already have.

As a matter of fact, I have been discussing this with Intel people
recently:
  http://marc.info/?t=3D128683908500001&r=3D1&w=3D2
It is pretty clear that Intel have added board config support to x86
already, even though that change may not be public yet. So I can only
encourage you to discuss this with Jacob Pan, Feng Tang and Alan Cox.

If you need a temporary solution until then, I encourage you to simply
add your code to the I2C bus driver your system is using. We already
have examples of this in i2c-i801, i2c-ocores, i2c-powermac,
i2c-taos-evm and i2c-xiic, so at least you wouldn't be doing
something new.

--=20
Jean Delvare
