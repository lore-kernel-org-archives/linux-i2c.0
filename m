From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help on selecting one (and only one) i2c bus
Date: Wed, 11 Mar 2009 10:15:13 +0100
Message-ID: <20090311101513.271f5464@hyperion.delvare>
References: <000001c9a0c6$bf92af80$b23e81a4@par.st.com>
	<20090310163044.571e4aff@hyperion.delvare>
	<fd6b62c10903102327u426a4262meeabe2c581d7107b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fd6b62c10903102327u426a4262meeabe2c581d7107b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?5LyK5rO9?= <wxc200-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ayman KHAMOUMA <ayman.khamouma-qxv4g6HH51o@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pramod gurav <pramodforum-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, 11 Mar 2009 14:27:33 +0800, =E4=BC=8A=E6=B3=BD wrote:
> hi Jean,
>=20
> As you said,i2c address 0x00 is not allowed for common i2c slave devi=
ce,it
> is reserved as broadcast address.Unfortunately,our project has a sens=
or
> cy8c201a0 on i2c-bus,it use 0x00 address.
>=20
> We met much phone hang problem with i2c,errors such as "waiting for b=
us
> free" or "exhausted retries" are all with this sensor.
>=20
> I guess when master would try to address this senosr,it infact send a
> broadcast address,that may cause problem easily,every slave device wo=
uld
> have a chance to pull down the bus line.
>=20
> Now, as the signal show,the ACk signal is too too long in hard-ware,t=
hat
> cause the the i2c-bus unit busy,which block the other i2c operation.
>=20
> I am trying to re-configure i2c-unit as gpio-mode,and set high/low le=
vel
> manually as a workround.
>=20
> Any good suggestion to solve this issue?

Yeah, switch to hardware which respects the I2C standard.

--=20
Jean Delvare
