From: Amaury =?iso-8859-1?Q?Decr=EAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH resend 1/2] I2C: sis630: sis964 bus
Date: Fri, 4 Jan 2013 12:33:29 +0100
Message-ID: <20130104113329.GA31752@gentoo>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
 <1346204115-30293-2-git-send-email-amaury.decreme@gmail.com>
 <20121004145702.2be5b612@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121004145702.2be5b612-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Thu, Oct 04, 2012 at 02:57:02PM +0200, Jean Delvare wrote:

> > -* force =3D [1|0] Forcibly enable the SIS630. DANGEROUS!
> > +* force =3D [1|0] Forcibly enable the driver. DANGEROUS!
>=20
> "SIS630" here and in many other places really means "SIS630 and
> compatible" i.e. "any chip supported by the driver." So you don't
> really have to change it.
>=20

Ok, removed.=20

> Given that the SiS964 defaults to the high speed, this option has
> actually very little value for that chip. I suppose you did not even
> test it. IMHO it would be better to simply mark it as SIS630/730-only
> and ignore, conceal or reject it if a SIS964 is detected. I vote for
> concealing it, as this option as the lowest cost AFAICS.
>=20

Ok, I removed the modification on the clock and marked it as SIS630/730=
 only.

>=20
> These days we have git to track these changes. I'd rather drop this
> section from the driver altogether (e.g. in your cleanup patch), it i=
s
> of very limited interest these days.
>=20

The change list will be removed by the cleanup patch.


> > +	| SMB_CNT                | Bit 1 =3D Slave Busy | Bit 1 =3D Bus p=
robe |
>=20
> I also see a difference for bit 3 in this register: reserved on SIS63=
0,
> Last Byte on SIS964. This doesn't matter right now because the driver
> doesn't support I2C block reads, but this means the SIS964 does suppo=
rt
> them and you may want to add support for this in the future (it makes
> reading SPD EEPROMs a lot faster.)
>=20

Ok added. I omitted it as it wasn't used by this version of the driver.

> > +#define SMB_SAA			0x13	/* host slave alias address */
>=20
> This register isn't used by the driver per se, only to compute the
> address range end in an error message. As you removed all unused
> registers from the list, you should remove it too.
>=20

Right, removed.

>=20
> You forgot to mention in the array listing the differences between th=
e
> chips, that register at offset 0x06 has a different meaning. It's
> SMB_PCOUNT on the SIS630 but SMBus Packet Error Check on the SIS964,
> where SMB_PCOUNT was moved to offset 0x14. Without this explanation,
> your comment above is unclear.
>=20

OK, I added this in the differences array.


>=20
> If you follow the logic of the two other chips, what should be listed
> here is PCI_DEVICE_ID_SI_760 =3D=3D 0x0760. I have no idea why it is
> implemented that way, but at least for this patch I'd rather stick to
> it.
>=20

My fault. It's indeed 0x0760 here.

>=20
> This is a nice bug fix, which would deserve a patch on its own.
>=20

> This look like a bug fix as well, not sure how we missed that so far.
> This should be a separate patch too.
>=20

Ok, splitted to separates patchs.

> >  	}
>=20
> You shouldn't do that. Returning -EAGAIN is enough, i2c-core will do
> the retries if you properly set i2c_adapter->retries (which the drive=
r
> doesn't do yet.) Retrying 500 times in a row would be way too much
> anyway.
>=20

Thanks. I now use the genuine i2c_adapter->retries.


>=20
> Should be 0x%04hx, as this is an unsigned short. Something that could
> be cleaned up in other places BTW.
>=20

Ok, I made a separate patch.


Best regards.

--=20
Amaury Decr=EAme
