From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: i2c-sh_mobile irq rollback fix
Date: Mon, 16 Aug 2010 08:24:27 +0200
Message-ID: <20100816082427.626ea303@hyperion.delvare>
References: <20100802071637.18054.76993.sendpatchset@t400s>
	<20100810151828.36a77cc3@hyperion.delvare>
	<AANLkTikQuCX7YC1tQ5MvwBdgxg1LE6k9f98-3M8khBJ6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTikQuCX7YC1tQ5MvwBdgxg1LE6k9f98-3M8khBJ6-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 16 Aug 2010 10:59:06 +0900, Magnus Damm wrote:
> On Tue, Aug 10, 2010 at 10:18 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> w=
rote:
> > On Mon, 02 Aug 2010 16:16:37 +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> >>
> >> Update the i2c-sh_mobile driver to properly free
> >> interrupts. The function sh_mobile_i2c_hook_irqs()
> >> is fixed so module both unload and load are working
> >> as expected.
> >>
> >> Signed-off-by: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> >> ---
> >>
> >> =C2=A0drivers/i2c/busses/i2c-sh_mobile.c | =C2=A0 23 +++++++++++++=
----------
> >> =C2=A01 file changed, 13 insertions(+), 10 deletions(-)
> >>
> >> --- 0001/drivers/i2c/busses/i2c-sh_mobile.c
> >> +++ work/drivers/i2c/busses/i2c-sh_mobile.c =C2=A0 2010-08-02 15:1=
4:48.000000000 +0900
> >> @@ -538,15 +538,17 @@ static int sh_mobile_i2c_hook_irqs(struc
> >> =C2=A0{
> >> =C2=A0 =C2=A0 =C2=A0 struct resource *res;
> >> =C2=A0 =C2=A0 =C2=A0 int ret =3D -ENXIO;
> >> - =C2=A0 =C2=A0 int q, m;
> >> - =C2=A0 =C2=A0 int k =3D 0;
> >> - =C2=A0 =C2=A0 int n =3D 0;
> >> + =C2=A0 =C2=A0 int n, k =3D 0;
> >
> > You can't really hope to get the code right with such variable name=
s.
>=20
> And your suggestion is...? If you see something wrong with the code
> please let me know.

Nothing specific. I'm just trying to make you realize that one-letter
variable names don't carry any meaning and thus make the code harder to
write, read and debug.

--=20
Jean Delvare
