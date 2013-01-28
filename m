From: Amaury =?iso-8859-1?Q?Decr=EAme?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 5/6] Misc: display unsigned hex
Date: Mon, 28 Jan 2013 22:00:32 +0100
Message-ID: <20130128210032.GB29409@gentoo>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
 <1357305215-17643-1-git-send-email-amaury.decreme@gmail.com>
 <1357305215-17643-6-git-send-email-amaury.decreme@gmail.com>
 <20130128193304.657b869f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130128193304.657b869f-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 28, 2013 at 07:33:04PM +0100, Jean Delvare wrote:
> > -		dev_dbg(&adap->dev, "SMBus busy (%02x). Resetting...\n", temp);
> > +		dev_dbg(&adap->dev, "SMBus busy (%02hx). Resetting...\n", temp);
>=20
> %hx is for shorts, not bytes. There is no format specifier for shorts=
,
> so a cast is always needed for these if you want to be strictly
> compliant. In practice gcc is smart enough to do the cast
> automatically. Same for most cases below.
>=20
> My suggestion to use %hx was really only for the cases where the
> variable is an unsigned short or u16, you can leave all the rest as i=
s.
>=20

I indeed missed that point. Corrected.

--=20
Amaury Decr=EAme
