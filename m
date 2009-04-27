From: =?UTF-8?B?5LyK5rO9?= <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: pxa i2c unit busy caused unrecoverable phone hang problem
Date: Mon, 27 Apr 2009 23:32:26 +0800
Message-ID: <fd6b62c10904270832w54c77fb3kdff9981d949ff54b@mail.gmail.com>
References: <fd6b62c10904270057w610239dflfd228f949c0649b2@mail.gmail.com>
	<20090427120810.20af38b8@hyperion.delvare> <49F58A01.6060401@compulab.co.il>
	<fd6b62c10904270641p1dc6d86awc271dcc10a1f6b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fd6b62c10904270641p1dc6d86awc271dcc10a1f6b0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, yi.ru-SckdOjWYlhYAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

As a compromise,we hope make the phone system free to run even the i2c
subsystem become busy already.Then there maybe time to choose some
useful way to solve that. The console can not input when phone hang
now.

So we try to make the sleep time in i2c layer long enough,but the
result not well,because there are many threads waiting for i2c bus
operation.The key threads such as serial console could not get chance
to run,or cannot interact with user timely.

Anyone could give a hand about this?

Thanks in advance again.

--Yize

2009/4/27 =E4=BC=8A=E6=B3=BD <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> thanks your reply ,Jean and Mike
>
> Winston Churchill =C2=A0- "The best argument against democracy is a f=
ive-minute conversation with the average voter."
>
> 2009/4/27 Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
>>
>>
>> Jean Delvare wrote:
>> > On Mon, 27 Apr 2009 15:57:45 +0800, =E4=BC=8A=E6=B3=BD wrote:
>> >> We use Marvell's pxaXXX chip,and the i2c unit often become BUSY s=
tatus .As
>> >> normal operation,the Unit-Busy will become free quickly,but somet=
imes
>> >> UNIT-BUSY forever.For there are very frequent i2c operations,the =
cell-phone
>> >> become hang soon,nothing could be done but remove the battery and=
 reboot.
>> >>
>> >> So could you give a suggestion? =C2=A0Is there any useful way to =
protect from
>> >> entering this abnormal UNIT-BUSY i2c status or recover from that?
>>
>> PXA I2C controller often reports BUSY when one of the I2C lines are =
held low.
>> Verify you have proper pull-ups and that devices connected to I2C bu=
s behave in
>> a sane way.
>
> Yes,we do.The unrecoverable problem is UNIT-BUSY,we still be confused=
 by the root cause.Now we guess there are two types of answers:
>
> 1) Another master left I2C busy in abnormal status after operation
> 2) Protocol conflict violation caused by messages transfer,such as th=
e=C2=A0 too large=C2=A0 message or wrong operation.Most of the time,I2C=
 works fine.
>
> We thought there would be some reset mechasim in that bad situation,b=
ut not.
> There are many threads waiting for the mutex lock while the current o=
perating one is trying,trying,and trying,,,but I2C Unit Busy block all.
>
> -- Yize
>>
>> > I don't know anything about PXA platforms, there's nothing I can d=
o for
>> > you, sorry.
>> >
>>
>> --
>> Sincerely yours,
>> Mike.
>>
>
