From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PULL REQUEST] i2c for 3.17
Date: Mon, 11 Aug 2014 09:39:11 +0800
Message-ID: <53E81EBF.5020905@intel.com>
References: <20140809135557.GA4837@katana> <CA+55aFy0UVY=60pCr85AvhedfO-MEoD-iMGdWmBYt8fKgF7kWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+55aFy0UVY=60pCr85AvhedfO-MEoD-iMGdWmBYt8fKgF7kWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2014=E5=B9=B408=E6=9C=8810=E6=97=A5 01:34, Linus Torvalds wrote:
> On Sat, Aug 9, 2014 at 6:56 AM, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> wrot=
e:
>>
>> here is the pull request for 3.17 for the I2C subsystem. Highlights:
>=20
> Lowlight: selecting ACPI support (which used to be the default if ACP=
I
> was enabled) now forces i2c to be built-in.
>=20
> I've pulled this, but it's broken. You need to fix it someway.
>=20
> The reason for this is
>=20
>   config I2C
>          tristate "I2C support"
>   ...
>   config I2C_ACPI
>          bool "I2C ACPI support"
>          select I2C
>          depends on ACPI
>    ...
>=20
> where if I2C_APCI is on (y), then that "select I2C" will cause I2C to
> be upgraded to 'y' as well.
>=20
> This seems to be intentional, judging by the commit message, but it's
> wrong. Distributions etc generally compile i2c as a module, and you'v=
e
> now broken that.
>=20
> This is a regression. Change the "select I2C" to a "depends on I2C",
> and test the end result. Don't force people to build things into the
> kernel.

Hi Linus:
	Sorry about this, I will create a fix patch soon. Thanks.

>=20
>                  Linus
>=20


--=20
Best regards
Tianyu Lan
