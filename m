Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5810734E75D;
	Thu,  6 Aug 2026 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004331; cv=none; b=npsoiQd4Y0AZIV8LuF6pZT7f1/IJr6MF31TTCz7uuG24dyQiFXzjJY3vcOmjnV+TH1SZfxzV2LniBZl7OxzK47lAIJcHr1zb6YAAN/RkdhpJ21kVGY7YIxnzRXbstv1ZQpLFChJJ5UKTnU9WIuBHq2GQok7WVShsy4QZ/lh5REI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004331; c=relaxed/simple;
	bh=Qp/vDuU7em1+nwqfUZSmp1WQ2VXqEyXV+78Due81s/g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ONPmFNECD96ruGE+ccv/otp7Z2nK/34qVC06tpt7xM09tSmO8gWR+MyhiSqo9xKfwSpqm8R6JGqTn2GAw6ukedW+mQuc8A82gSxR3rUcAdTc8/BF4f9TduXu+R+JTBdyt6Rlu/K09QbCVJMQC8vsar+ohPfMXdG/42V/LAUHOdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4C93420194D;
	Thu, 06 Aug 2026 10:18:46 +0200 (CEST)
Message-ID: <80a94424da18d5003265c5e8bf5ecb5a90499b59.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] i2c: rcar: add R-Car Gen5 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang
	 <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Andi Shyti <andi.shyti@kernel.org>, 
 Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org
Date: Thu, 06 Aug 2026 10:18:46 +0200
In-Reply-To: <CAMuHMdVAgjguscFMKd7u1XPuZEkB7mH9-G-Y8nYfXqbzJ2hH9Q@mail.gmail.com>
References: <20260727122546.4232-4-wsa+renesas@sang-engineering.com>
	 <20260727122546.4232-6-wsa+renesas@sang-engineering.com>
	 <CAMuHMdVAgjguscFMKd7u1XPuZEkB7mH9-G-Y8nYfXqbzJ2hH9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mo, 2026-08-03 at 15:14 +0200, Geert Uytterhoeven wrote:
> Hi Wolfram,
>=20
> On Mon, 27 Jul 2026 at 14:26, Wolfram Sang
> <wsa+renesas@sang-engineering.com> wrote:
> > To support the next generation of R-Car SoCs, we need to skip polling
> > the reset status. SCMI doesn't support it and the firmware must take
> > care of this anyhow. Other than that, the driver works fine as-is.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Thanks for your patch, which is now commit 87e713f200481106 ("i2c:
> rcar: add R-Car Gen5 support") in i2c/i2c/i2c-next.
>=20
> > --- a/drivers/i2c/busses/i2c-rcar.c
> > +++ b/drivers/i2c/busses/i2c-rcar.c
>=20
> > @@ -900,8 +901,12 @@ static int rcar_i2c_do_reset(struct rcar_i2c_priv =
*priv)
> >         if (ret)
> >                 return ret;
> >=20
> > -       return read_poll_timeout_atomic(reset_control_status, ret, ret =
=3D=3D 0, 1,
> > -                                       100, false, priv->rstc);
> > +       /* SCMI based resets don't need to poll for success */
> > +       if (priv->devtype < I2C_RCAR_GEN5)
> > +               return read_poll_timeout_atomic(reset_control_status, r=
et, ret =3D=3D 0,
> > +                                               1, 100, false, priv->rs=
tc);
>=20
> How to differentiate between using SCMI and running on bare metal?
> The latter still needs polling.
>=20
> I think you should call reset_control_status() first, and check for
> -ENOTSUPP, which would indicate that reset status is not available.

Ah, I suppose this driver is what you need .reset and .status for in
the R-Car X5H MDLC driver?

Seeing this, I wonder: could the status poll be moved into the reset
controller driver(s)? That would leave this driver with a simple,
unconditional reset_control_reset().

regards
Philipp
>=20
