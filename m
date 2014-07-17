From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] i2c-i801: Fix the alignment of the device table
Date: Thu, 17 Jul 2014 12:00:39 +0200
Message-ID: <20140717120039.0889a3fa@endymion.delvare>
References: <20140623103658.57df2c14@endymion.delvare>
	<20140716172309.GD2759@katana>
	<20140717082930.0dcad551@endymion.delvare>
	<20140717084157.GA2740@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140717084157.GA2740@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 17 Jul 2014 10:41:57 +0200, Wolfram Sang wrote:
>=20
> > One possibility is to switch to tabs and shift all columns (but the
> > first) by 4 to the right. This rules out the addition of a column i=
n
> > the future, but otherwise fulfills your desire.
>=20
> I'd like that. Plus, I am not so strict with the 80 char limit. If th=
ere
> is another feature, then be it on column 80+. I don't think the table
> will grow to 100+ chars in the future. If so, we probably need to
> redesign it anyhow.

Agreed.

> > To be honest, I don't really care. All I wanted is that columns are
> > properly aligned. If the plan above makes you happier then fine wit=
h
> > me, I'll do that.
>=20
> Please do. And thanks for doing annoying whitespace work.

No problem. Above 30=B0C that's about all my brain is good at anyway ;-=
)

--=20
Jean Delvare
SUSE L3 Support
