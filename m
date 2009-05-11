From: =?GB2312?B?0sHU8w==?= <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2.6.29.2] PXA I2C: Define log level for i2c PXA error
	report
Date: Mon, 11 May 2009 21:29:53 +0800
Message-ID: <fd6b62c10905110629w6c9a641fr878351fb9217a32e@mail.gmail.com>
References: <Pine.LNX.4.64.0905060829580.24668@venus.araneidae.co.uk>
	<20090506102202.73d6045d@hyperion.delvare> <Pine.LNX.4.64.0905081102060.14384@venus.araneidae.co.uk>
	<fd6b62c10905110311w6350828tf90d9c699b73fe30@mail.gmail.com>
	<Pine.LNX.4.64.0905111126020.20970@venus.araneidae.co.uk>
	<20090511112801.GA20283@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090511112801.GA20283-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Cc: Michael Abbott <michael-W/Bzo8D1sxa8qtKVGud/9w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

2009/5/11 Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>:
> On Mon, May 11, 2009 at 11:31:51AM +0100, Michael Abbott wrote:
>
>> static struct i2c_pxa_platform_data xcep_i2c_platform_data =A0=3D {
>> =A0 =A0 =A0 =A0 .class =3D I2C_CLASS_HWMON
>> };
>
>> ...
>> =A0 =A0 =A0 =A0 pxa_set_i2c_info(&xcep_i2c_platform_data);
>
>> This is called in the .init_machine method, and the target system is=
 a
>> PXA255.
>
>> However, after the error messages on startup, all the sensors seem t=
o be
>> detected and seem to be operating normally.
>
> These errors occur when attempting to talk to non-existant devices wh=
ich
> is almost certainly going to happen with the class based device probi=
ng
> since the kernel will probe for each device at each possible address =
on
> each I2C bus.
>
that happen when the device driver registered but the hardware doesnot
exist.i once met this
when my camera driver could not find the hardware camera.

thanks
--wxc200
