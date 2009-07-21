From: Manuel Lauss <manuel.lauss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH] i2c-au1550: dev_pm_ops conversion.
Date: Tue, 21 Jul 2009 07:02:58 +0200
Message-ID: <f861ec6f0907202202w104f269au8086a243b68d9b3a@mail.gmail.com>
References: <1248115661-20189-1-git-send-email-manuel.lauss@gmail.com>
	 <20090720210617.GA28218@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090720210617.GA28218-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Mon, Jul 20, 2009 at 11:06 PM, Ben Dooks<ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org> wrote:

>> +
>> +static struct dev_pm_ops au1xpsc_smbus_pmops =3D {
>> + =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D i2c_au1550_resume,
>> + =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D i2c_au1550_suspend,
>> +};
>>
>> =A0static struct platform_driver au1xpsc_smbus_driver =3D {
>> =A0 =A0 =A0 .driver =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "au1xpsc_smbus",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pm =A0 =A0 =3D &au1xpsc_smbus_pmops,
>
> hmm, why not
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.pm =A0 =A0 =3D (struct dev_pm_ops &) =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.suspend =A0 =A0 =A0 =A0=
=3D ...,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.resume =A0 =A0 =A0 =A0=
 =3D ...,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>
> ?

I remember one patch being shot down on account of having this
style.  I prefer the original style too, but I've no objections to chan=
ging
it...

Thank you!
       Manuel Lauss
