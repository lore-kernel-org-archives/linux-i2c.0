From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH resend 2/2] I2C: sis630: Cleaning and cosmetics
Date: Fri, 4 Jan 2013 13:53:25 +0100
Message-ID: <20130104135325.58d2aec0@endymion.delvare>
References: <1346204115-30293-1-git-send-email-amaury.decreme@gmail.com>
	<1346204115-30293-3-git-send-email-amaury.decreme@gmail.com>
	<20121004172939.387eb8d1@endymion.delvare>
	<20130104114400.GB31752@gentoo>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130104114400.GB31752@gentoo>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amaury =?ISO-8859-1?B?RGVjcuptZQ==?= <amaury.decreme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nelson-bExrPSV3DA0@public.gmane.org, mhoffman-xQSgfq/1h4JiLUuM0BA3LQ@public.gmane.org, amalysh-S0/GAf8tV78@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Amaury,

On Fri, 4 Jan 2013 12:44:00 +0100, Amaury Decr=EAme wrote:
> On Thu, Oct 04, 2012 at 05:29:39PM +0200, Jean Delvare wrote:
> > This is a mask, would be good to make it visible in the name. OTOH =
the
> > masking is a no-op in practice so I'm not sure it's worth defining.
>=20
> I removed it. I understand that byte mask shouldn't be keeped but bit=
 mask is ok.
> Is it the right logic ?

No, my point is that masking operations which will always resolve to
no-ops by construct should be avoided. The compiler may not always be
able to optimize these out. This hold for both single and multi-bit
masking.

--=20
Jean Delvare
