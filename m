From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 0/3 v2] i2c: i801: enable irq
Date: Wed, 27 Jun 2012 16:01:21 +0200
Message-ID: <20120627160121.3c3c3a88@endymion.delvare>
References: <1325847502-17841-1-git-send-email-djkurtz@chromium.org>
	<20120627112402.26576746@endymion.delvare>
	<CAGS+omDYaPBQiKBiVewbwZR2Vnjv+NfqbZxc+fknpCBNvRFRKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omDYaPBQiKBiVewbwZR2Vnjv+NfqbZxc+fknpCBNvRFRKw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 27 Jun 2012 21:56:34 +0800, Daniel Kurtz wrote:
> On Wed, Jun 27, 2012 at 5:24 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wr=
ote:
> > I planned on testing this on my ICH3-M system, but it turns out you=
r
> > interrupt-based implementation only works for ICH5 and later chips.=
 As
> > ICH5 and later chips all implement the block buffer, there's no rea=
son
> > for the byte-by-byte-code to ever be used for SMBus block transacti=
ons.
> > However, the block buffer feature can be disabled for testing purpo=
se
> > by passing module parameter disable_features=3D0x0002.
> >
> > I just did, and actually it doesn't work. i2cdump shows 32 bytes no
> > matter what the device said. Debug log shows that the driver reads
> > fewer bytes from the device though, as it is supposed to. So I thin=
k
> > the problem is simply that the interrupt path is missing this compa=
red
> > to the polled path:
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D=
 1 && read_write =3D=3D I2C_SMBUS_READ
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 && command =
!=3D I2C_SMBUS_I2C_BLOCK_DATA) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0len =3D inb_p(SMBHSTDAT0(priv));
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(...)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0data->block[0] =3D len;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >
> > I.e. we don't let the caller know how many bytes we actually read f=
rom
> > the device. I fixed it with:
> >
>=20
> I was just in the middle of finalizing a new patchset when I saw your
> last email.
> I incorporated (and tested for no-regressions) the snippet below.
> Unfortunately, I'm not set up to test this type of transaction, so
> hopefully you can double check my version of this patch with your
> setup.

Sure, no problem, I will do another full round of testing on the new
patchset.

--=20
Jean Delvare
