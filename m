From: Michael Abbott <michael-W/Bzo8D1sxa8qtKVGud/9w@public.gmane.org>
Subject: Re: [PATCH 2.6.29.2] PXA I2C: Define log level for i2c PXA error
 report
Date: Mon, 11 May 2009 11:31:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0905111126020.20970@venus.araneidae.co.uk>
References: <Pine.LNX.4.64.0905060829580.24668@venus.araneidae.co.uk>
 <20090506102202.73d6045d@hyperion.delvare> <Pine.LNX.4.64.0905081102060.14384@venus.araneidae.co.uk>
 <fd6b62c10905110311w6350828tf90d9c699b73fe30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="682240-1872984673-1242037911=:20970"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fd6b62c10905110311w6350828tf90d9c699b73fe30-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?GB2312?B?0sHU8w==?= <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--682240-1872984673-1242037911=:20970
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 May 2009, =D2=C1=D4=F3 wrote:
> 2009/5/11 Michael Abbott <michael-W/Bzo8D1sxa8qtKVGud/9w@public.gmane.org>
> > Now this is very odd. =A0I'd assumed the error messages I was getting w=
ere
> > just noise, but the commit you point me to uses KERN_ERR instead -- and=
 so
> > I get a brief storm of these messages on boot on my target:
> >
> > [ =A0 20.667923] i2c: error: exhausted retries
> > [ =A0 20.671962] i2c: msg_num: 0 msg_idx: -2000 msg_ptr: 0
> > [ =A0 20.677113] i2c: ICR: 000007e0 ISR: 00000002
> > [ =A0 20.677128] i2c: log: [00000446:000007e0]
> >
> > This is repeated nine times in total with exactly the same numbers. =A0=
Any
> > thoughts as to what this means? =A0Other than these messages on startup=
 my
> > I2C sensors seem to work perfectly well.
> If all error messages seem like "exhausted retries",not "timeout or
> master error",there maybe some operation conflicts,and i2c controller
> cannot succeed operateing after max times retry.  And which mode do
> your i2c work?  Poll or Interrupt?

Well, to be honest I don't actually know (I've inherited the driver and I=
=20
haven't figured out how the I2C drivers work), but here's how the i2c is=20
initialised:

static struct i2c_pxa_platform_data xcep_i2c_platform_data  =3D {
        .class =3D I2C_CLASS_HWMON
};

=2E..
        pxa_set_i2c_info(&xcep_i2c_platform_data);

This is called in the .init_machine method, and the target system is a=20
PXA255.

However, after the error messages on startup, all the sensors seem to be=20
detected and seem to be operating normally.
--682240-1872984673-1242037911=:20970--
