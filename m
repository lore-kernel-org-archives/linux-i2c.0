From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/8 v3] i2c: i801: check and return errors during
 byte-by-byte transfers
Date: Thu, 28 Jun 2012 09:08:28 +0200
Message-ID: <20120628090828.47b5aff8@endymion.delvare>
References: <1340805255-8041-1-git-send-email-djkurtz@chromium.org>
	<1340805255-8041-5-git-send-email-djkurtz@chromium.org>
	<20120627185136.315e6625@endymion.delvare>
	<CAGS+omDkhA=dP0JP=4huQEwJ4j6YqZWJ+mFsJv+eeGMBRpu5fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGS+omDkhA=dP0JP=4huQEwJ4j6YqZWJ+mFsJv+eeGMBRpu5fQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Seth Heasley <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 28 Jun 2012 11:46:28 +0800, Daniel Kurtz wrote:
> On Thu, Jun 28, 2012 at 12:51 AM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> w=
rote:
> > On Wed, 27 Jun 2012 21:54:11 +0800, Daniel Kurtz wrote:
> >> If an error is detected in the polling loop, abort the transaction=
 and
> >> return an error code.
> >>
> >> =C2=A0* DEV_ERR is set if the device does not respond with an ackn=
owledge, and
> >> the SMBus controller times out (minimum 25ms).
> >> =C2=A0* BUS_ERR is set if a bus arbitration collision is detected.=
 =C2=A0In other
> >> words, when the SMBus controller tries to generate a START conditi=
on, but
> >> detects that the SMBDATA is being held low, usually by another SMB=
us/I2C
> >> master.
> >> =C2=A0* FAILED is only set if a the transaction is set by software=
 (using the
> >> SMBHSTCNT KILL bit).
>=20
> That was supposed to say:
>=20
>  * FAILED is only set if a transaction is stopped by software (using
> the SMBHSTCNT KILL bit).

Changed, thanks!

> > Not quite sure what you mean with "set by software". Other than thi=
s,
> > patch looks good, applied, thanks.
>=20
> Applied where?
> I'd like to send a rebased patchset onto whatever you have already st=
aged.

http://khali.linux-fr.org/devel/linux-3/jdelvare-i2c/

--=20
Jean Delvare
