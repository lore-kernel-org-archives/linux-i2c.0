From: Dongsoo Kim <dongsoo.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: About a suspicious msleep during doxfer in s3c2410 i2c bus driver
Date: Thu, 23 Jul 2009 00:58:52 +0900
Message-ID: <E724615E-9F06-4406-9852-041261C5DAA6@gmail.com>
References: <5e9665e10907220112m1dbf4975icf1511bc4ac3a1bf@mail.gmail.com> <20090722124333.GC7622@sirena.org.uk>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=EUC-KR;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090722124333.GC7622-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org, ????????? <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, ????????? <bhmin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dongsoo Kim <dongsoo45.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, =?EUC-KR?B?wfi8uiC+5w==?= <jsgood.yang-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


2009. 07. 22, =BF=C0=C8=C4 9:43, Mark Brown =C0=DB=BC=BA:

> On Wed, Jul 22, 2009 at 05:12:17PM +0900, Dongsoo, Nathaniel Kim =20
> wrote:
>
>> Since I was working on S3C64XX and C1XX, I found something weird on
>> I2C bus device.
>> The thing is that when I try to write multiple registers through I2C
>> bus, it takes much more time for multiple registers to be written =20
>> than
>> any other processor's i2c bus device.
>
> Yes, this is extremely painful for a lot of devices - audio CODECs =20
> tend
> to be noticably affected, especially at resume.  Depending on your
> device and what you're doing you *may* be able to speed things up by
> accessing many registers in a single I/O in the chip driver but
> obviously that's not ideal.
>
>> With several different target boards using s3c64xx and s5pc1xx, it
>> went good without that msleep(). And of course it is working great
>> with multiple i2c device attached as well.
>> So, I want to ask Ben and anyone else using I2C device about removin=
g
>> that msleep might be ok or not. In my case, it went ok. Please let m=
e
>> know your opinion.
>
> My *recollection* is that this is mostly there for multi-master
> configurations.
>
> I'm wondering if even if we can't remove the delay completely yet we
> could add platform data to allow it to be configured on a per-board
> basis?

I  wish I could answer clearly about this but not having much =20
experience over various I2C bus devices so I can't say with a strict =20
"yes". But in my experience, I've never seen any i2c bus driver =20
serving platform data to be configured with delay support. Tho if it =20
is really necessary for some specified class of i2c devices, we should =
=20
make one.
I'm wondering why anybody has been issued this topic yet. the driver =20
for s3c2410 i2c bus has been the way it is for ages I guess. It =20
obviously seems to be taking long time to write down registers through =
=20
the s3c2410 i2c bus driver than any other processor's i2c driver. =20
maybe not so many people using enormous i2c register programming on =20
Samsung processors could be the reason I suppose. anyway, let's figure =
=20
it out the best way we can.
Cheers,

Nate




=3D
Dongsoo, Nathaniel Kim
Engineer
Mobile S/W Platform Lab.
Digital Media & Communications R&D Centre
Samsung Electronics CO., LTD.
e-mail : dongsoo.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
            dongsoo45.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
