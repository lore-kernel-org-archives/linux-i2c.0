From: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Subject: Re: [PATCH] i2c-tools: do not fail opening bus if /dev/i2c is not a
 directory
Date: Wed, 18 Aug 2010 14:45:14 +0200 (CEST)
Message-ID: <57080007.49741282135514070.JavaMail.root@zimbra-corp-1-b7>
References: <20100818144329.50711481@hyperion.delvare>
Reply-To: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100818144329.50711481-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

----- "Jean Delvare" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> a =C3=A9crit :

> Hi Florian,
>=20
> On Wed, 18 Aug 2010 14:33:50 +0200, Florian Fainelli wrote:
> > In case /dev/i2c is not a directory, open_i2c_dev will fail opening
> > /dev/i2c/<i2cbus> but only handles the ENOENT errno, while we shoul=
d
> also
> > handle ENOTDIR errno because this is the returned error code. The
> patch
> > attached fixes the issue.
>=20
> This is better discussed on the linux-i2c list. Redirecting...
>=20
> > Signed-off-by: Florian Fainelli <ffainelli-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
> > --
> > Index: tools/i2cbusses.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- tools/.svn/text-base/i2cbusses.c.svn-base	2010-08-18
> 14:22:18.000000000 +0200
> > +++ /tmp/tempfile.2.tmp	2010-08-18 14:33:12.000000000 +0200
>=20
> What a ugly header. How am I supposed to apply this?
>=20
> > @@ -378,7 +378,7 @@
> >  	sprintf(filename, "/dev/i2c/%d", i2cbus);
> >  	file =3D open(filename, O_RDWR);
> > =20
> > -	if (file < 0 && errno =3D=3D ENOENT) {
> > +	if (file < 0 && (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR)) {
> >  		sprintf(filename, "/dev/i2c-%d", i2cbus);
> >  		file =3D open(filename, O_RDWR);
> >  	}
> >=20
>=20
> I've never seen the case where /dev/i2c exists but isn't a directory
> (which is why that case isn't handled.) How did you get in this
> situation? It doesn't make much sense IMHO.

Well, I got another driver here living at /dev/i2c which I am slowly mi=
grating, but I would like to have i2cdetect working anyway ;)

>=20
> That being said, we can certainly apply your patch if it makes you
> happy, I don't see it as being terribly useful, but it also shouldn't
> hurt.

I would be glad if you apply it. Thanks!
--
=46lorian
