From: Amaury =?iso-8859-1?Q?Decr=EAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH resend 2/2] I2C: sis630: Cleaning and cosmetics
Date: Fri, 4 Jan 2013 12:44:00 +0100
Message-ID: <20130104114400.GB31752@gentoo>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
 <1346204115-30293-3-git-send-email-amaury.decreme@gmail.com>
 <20121004172939.387eb8d1@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121004172939.387eb8d1-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Thu, Oct 04, 2012 at 05:29:39PM +0200, Jean Delvare wrote:
>=20
> I'd rather drop the changelog altogether, we have revision control
> systems (svn and git) for that.
>=20
Changelog dropped.

>=20
> This is a mask, would be good to make it visible in the name. OTOH th=
e
> masking is a no-op in practice so I'm not sure it's worth defining.
>=20
I removed it. I understand that byte mask shouldn't be keeped but bit m=
ask is ok.
Is it the right logic ?

> I can't see the rationale for changing this variable name. temp was
> just fine. Changing it makes the patch larger for no good reason. Sam=
e
> later below.
>=20

The variable was changed to normalizing purpose. To keep things clear, =
I removed
that diff.

>=20
> This is an actual code change. You just can't do that in a cleanup
> patch, sorry. I don't even see the benefit, this makes the logic hard=
er
> to understand.
>=20
Indeed, it shouldn't be here.

> This again is a code change. It subtly changes the behavior of the
> driver if several errors are reported at the same time. You can't do
> that in a cleanup patch! If you really want to do it, make it a
> separate patch, so that you can properly describe the change and the
> reasons why you think it is good.
>=20

Removed it.

> Unrelated with this patch, but I think the above is wrong. The
> datasheet says to write 1 to clear bits in the SMB_STS register, so t=
he
> above is clearing all bits _except_ SMBCOL_STS. Not good. OTOH we wil=
l
> end up clearing all bits in sis630_transaction_end() anyway, so there=
's
> no point in doing it already here.
>=20

Modified and splitted to a separate patch.

>=20
> Please leave "clear" as it was, it is much more readable. Remember yo=
u
> do not have to care about the 80 column limit for strings.
>=20
> You can keep the string on a single line.
>=20
Good note taken.

>=20
> Spaces can be added around "+"s too.
>=20
>=20
> Space before comma could be removed.
>=20
--> Cleanup patch v2 :)

Best regards.
--=20
Amaury Decr=EAme
