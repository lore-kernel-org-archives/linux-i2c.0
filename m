From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: pxa i2c unit busy caused unrecoverable phone hang problem
Date: Mon, 27 Apr 2009 12:08:10 +0200
Message-ID: <20090427120810.20af38b8@hyperion.delvare>
References: <fd6b62c10904270057w610239dflfd228f949c0649b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fd6b62c10904270057w610239dflfd228f949c0649b2-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?5LyK5rO9?= <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 27 Apr 2009 15:57:45 +0800, =E4=BC=8A=E6=B3=BD wrote:
> We use Marvell's pxaXXX chip,and the i2c unit often become BUSY statu=
s .As
> normal operation,the Unit-Busy will become free quickly,but sometimes
> UNIT-BUSY forever.For there are very frequent i2c operations,the cell=
-phone
> become hang soon,nothing could be done but remove the battery and reb=
oot.
>=20
> So could you give a suggestion?  Is there any useful way to protect f=
rom
> entering this abnormal UNIT-BUSY i2c status or recover from that?

I don't know anything about PXA platforms, there's nothing I can do for
you, sorry.

--=20
Jean Delvare
