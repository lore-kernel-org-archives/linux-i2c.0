From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 5/8] powerpc: i2c-mpc: make I2C bus speed configurable
Date: Wed, 1 Apr 2009 07:55:38 -0600
Message-ID: <fa686aa40904010655i73819214m795939e784889267@mail.gmail.com>
References: <20090331123727.853787299@denx.de>
	 <20090331124035.908249543@denx.de>
	 <fa686aa40903310841x42876819rafe3e8bf24b8646e@mail.gmail.com>
	 <49D31D1D.6020004@grandegger.com>
	 <fa686aa40904010630l798528efh465a7543a15f50e5@mail.gmail.com>
	 <49D36F1F.2050107@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49D36F1F.2050107-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 1, 2009 at 7:41 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>=
 wrote:
> Grant Likely wrote:
>> On Wed, Apr 1, 2009 at 1:51 AM, Wolfgang Grandegger <wg@grandegger.c=
om> wrote:
>>> Grant Likely wrote:
>>>> The table definition is more verbose this way, but I think it resu=
lts
>>>> in more understandable and easier to extend code. =A0It also adds =
lets
>>>> the compiler do more type checking for you.
>>> OK but I don't like the callback function to do the settings. We ne=
ed
>>> backward compatibility with old DTS files including the ugly "dfsrr=
"
>>> property, right? Then it seems consequent to continue using i2c->fl=
ags
>>> for that purpose and not to introduce another method. If we don't n=
eed
>>> backward compatibility, we could drop the flags completely and just=
 use
>>> callback functions.
>>
>> I don't understand why you don't like it. =A0It's an elegant solutio=
n
>> and it simplifies the code somewhat. =A0After grabbing the callback
>> pointer the compatibility code can simply override it. =A0But I won'=
t
>> belabor the point or oppose the patch if you stick with the flags
>> pointer.
>
> I changed my mind ;-). Have a look to PATCH v2 I sent out a few minut=
es ago.

I saw and I like.  :-)

>> I've been thinking about this more. =A0These tables are only ever go=
ing
>> to be used by the i2c_mpc driver and so really they are a part of th=
e
>> i2c_mpc driver itself. =A0Putting them into common code doesn't make=
 any
>> sense because it is not common code. =A0I will not merge a patch tha=
t
>> puts them into mpc5200 common code.
>
> It's not common code, I agree. How about putting it into mpc52xx_i2c.=
c
> and use:
>
> =A0$ cat Makefile
> =A0obj-$(CONFIG_I2C_MPC) +=3D mpc52xx_i2c.o
>
> Or it could be moved back to the i2c_mpc driver and we add stubs for =
the
> functions to get the bus frequency, or use #ifdef's.

I'm happy with either as long as it lives in the same directory as the
i2c_mpc driver, and as long as the i2c maintainers are okay with it.
Oh, and if you use a separate file it should be statically linked into
the i2c_mpc module using the i2c_mpc-$(CONFIG_WHATEVER) trick.  No
EXPORT_SYMBOLS should be needed.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
