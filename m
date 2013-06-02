From: CF <cfoissac-GANU6spQydw@public.gmane.org>
Subject: Re: Newbie: accessing i2c features through kernel functions
Date: Sun, 02 Jun 2013 23:38:12 +0200
Message-ID: <51ABBB44.4010403@free.fr>
References: <1369818463.42609.YahooMailNeo@web141202.mail.bf1.yahoo.com> <51A87235.2060702@free.fr> <20130531165620.52a79500@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130531165620.52a79500@crub>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Le 31/05/2013 16:56, Anatolij Gustschin a =E9crit :
> On Fri, 31 May 2013 11:49:41 +0200
> CF <cfoissac-GANU6spQydw@public.gmane.org> wrote:
>
>> I'm requesting help. I am currently successfully using i2c-dev modul=
e.
>> But i'm unable to drive i2c busses from kernel space as i'd do from
>> userspace (with the use of open, read, write, ioctl functions). I ca=
n't
>> logically acces glibc.
>>
>> Can somebody point me how i could do from kernel space ?
> you need to get the I2C adapter for your bus using i2c_get_adapter()
> and then send the I2C messages by i2c_transfer().
>
> Anatolij
>
It works flawlessly. I could directly drive a device attached to my i2c=
=20
bus simply by wrapping i2c_tranfer() and some i2c_msg messages, thus=20
expose w/e functions i need to propose a reduced instruction set.

I also learned how works fops structure, to retrieve the equivalent of=20
open/read/write/ioctl 's GLIBC in kernel space. Although i don't use it=
=20
for my need, quick tests worked nicely with them.

I'll perhaps dig how to work with others structures (in example i don't=
=20
really see how i2c_client works), and i certainly also need to=20
understand the differences between various algorithms.

Thank you !
