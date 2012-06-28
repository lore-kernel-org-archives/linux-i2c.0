From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/8 v3] i2c: i801: check INTR after every transaction
Date: Thu, 28 Jun 2012 13:36:50 +0200
Message-ID: <20120628133650.6b7c8746@endymion.delvare>
References: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
	<1340805255-8041-4-git-send-email-djkurtz@chromium.org>
	<20120627180724.762f854a@endymion.delvare>
	<CAGS+omCoto4djKuZUooeD2A-szjrH4e9=YJCptR_raOdQ8g3-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omCoto4djKuZUooeD2A-szjrH4e9=YJCptR_raOdQ8g3-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 28 Jun 2012 15:51:34 +0800, Daniel Kurtz wrote:
> On Thu, Jun 28, 2012 at 12:07 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> w=
rote:
> > On Wed, 27 Jun 2012 21:54:10 +0800, Daniel Kurtz wrote:
> >> +
> >> + =C2=A0 =C2=A0 if (timeout > MAX_RETRIES)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&priv->pci_dev=
->dev, "INTR Timeout!\n");
> >> +
> >> + =C2=A0 =C2=A0 outb_p(status, SMBHSTSTS(priv));
> >
> > Wouldn't it be more correct to only write the INTR bit? Writing bac=
k
> > the whole 8 bits frightens me a little especially because of bit
> > INUSE_STS. If we ever want to support this feature, I think we have=
 to
> > first ban writing back the whole status to register HST_STS. And th=
is
> > is the only place where we still do AFAICS.
>=20
> It looks like the current code does it this way to clear any error
> bits that may be set in the timeout case (errors set, but no INTR).
> For example, if there was a bus / arbitration error while waiting for
> PEC.
>=20
> Perhaps we can split the difference (I tested this and it has no
> obvious regression):
>=20
> +     /* Clear INTR, or in case of timeout, any other status bits. */
> + =C2=A0 =C2=A0 outb_p(status & STATUS_FLAGS, SMBHSTSTS(priv));
>=20
> But in a separate patch...
>=20

I agree, this would be a reasonable compromise.

--=20
Jean Delvare
