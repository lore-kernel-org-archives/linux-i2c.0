Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809421ABD7
	for <linux-i2c@vger.kernel.org>; Fri, 26 Jun 2026 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782438952; cv=pass; b=P2V7tzcsvZhjNCzKDDFg5W3qhEizXRfx7CIV0D61RBMhvZsb9kvbCuniOqTaVf9tponwECztdFYqYlelTD3iG/Av8BvrKARkGt22JFgPFzN6V0EQ1w01t1TjUQX+c3XqXwzcO+PYjtUsluxKKG9CD4kZe54eO6DNd1m2ZonT/vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782438952; c=relaxed/simple;
	bh=jXiXb8BB8/5rZZmokBeg/dECudwiIK4cvNgjgqBgQ3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKVOsJWvNcJNtMERHYaj4wNBlwsWXUmDNtnncfNOLuxz+PaPaq4EXHuutcj6oeV2n1f1pyQmgdxdakapmSm2L/jCd53gsEJfuU67PiA9RnABgEKOgl16R4vUhFYmhHzZgVJwoCmr+b/VzaTwIby9DC3lBRoJoCx1o5BrzaaUfM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWe5gc6r; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWe5gc6r"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-697ebe536b6so689007a12.1
        for <linux-i2c@vger.kernel.org>; Thu, 25 Jun 2026 18:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782438950; cv=none;
        d=google.com; s=arc-20260327;
        b=pdsVwplzWL5g7OqWBTF3B4fGcJdlv2QC7CSN68BPWlIIyxn5Pu4Eab5zcxkMlFya9w
         EZQxqqeB1QBnDxdkUcvgetnC672SRWn+WHTrHeuZ3EQil+lAfg0wLsGXYMObiMjub1lF
         hTl8kHMYJ/oPo8PbGxiCHJu11DZLLXeI3YtrZ5vWPM20ZIuaweIOGAi3QxYA3+An7+6w
         Re9MSB3gTXqmM2lGAT17bruG9ygXmXMkRa2I3x208C1YDXb16dzF9wWUDri6HHZDo9QL
         WXEo/II5K2WGOeth4nHYfy9M3AMGK4vZdjd8SK2sGo09ivDkAb5AyZ7O3N6OOelNs0Xl
         ZkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LNZy2c6rQcybgL+bCAHWO3UrpbXcc8ANhnoFPYD99Hk=;
        fh=BTmfgk6hwCU45OF81k5lernGKDm40r8h070xc+xRt/8=;
        b=Px1uc/vtW5HedmkTN7THfTDdKdcT82y44+78nvmB0d4TcSOC8/fHq5mbbkmtqyy3tG
         sDjjHYu0+Vb6oXtEvo5EybhmoEtdlFI+da0nzzFbMSjRN6FrH13Fr24yVle9dFhjKp5H
         J+oteB9GtNxgdjgLA7ieXQcQFTQ8Z85BfKsobFZiiQr4tIHZWrdTCA3tKP+xt+NOpOk0
         ST40yRUGqScFwQlor7EYsnhAWUBI9O2HKKZDBTDVhBt8uwthbmZKeVCyjA9PPSyspyxP
         sViSiA3wpZg36OEO1Rt9+4rceeF/OJ3P+64CNavTn3IAqBPFNvzIPMIXKMmWLFNIK92F
         t3Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782438950; x=1783043750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNZy2c6rQcybgL+bCAHWO3UrpbXcc8ANhnoFPYD99Hk=;
        b=nWe5gc6rAFWOdIkY+CahYvCdhWSBnezkK8Yh6zP9/grgJuDp01mKbqSJgN0phhojiK
         7e0RtZ1GVg7TEXf1XDYntwYWqPSptq7Ub1QS2RT0Xbn+RKrsNM3By3+pr/PVtzHf8Oxb
         tN7jtkfEHo6llKMzISX4AyWfVICOl8kLeJ6SUfd4FNhUEHUjAUUw21qJ878yeMI22fh7
         wmDVf+TPgAiHAeKs1L9KHS21JyjwWC6u08n87lojUb9qmk1MxlMkQNYgd1WFS5B8tRNe
         DuHrTrXbcTfM6p+t+m9fuvdlJGcRIJl+VUV5W9WwcPCeSzYwzuM6IGxmDFY9CQ7hIKV2
         kOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782438950; x=1783043750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LNZy2c6rQcybgL+bCAHWO3UrpbXcc8ANhnoFPYD99Hk=;
        b=MwcTS4lCAVaaSU32/ghJknE7EVnEuNZLPbsHaQ+M79XxVR6tTeDNr1hFjSZSoFBzxJ
         oBE+ZRuHQa/Ap2xB4rY5u06PcUycuu/lFLAjEIsvIyEpqfuYLlepWH29XdfgAUrJCbf5
         sN53uHtrlzTgOmN76aAl4q30Zn5krMsdFRPWGUvuD+zYTF+IDLBNzbwMLCtnK6lPM6sc
         Q+EPgNf5qoava5vLjLo+Tv3oMT6fbOXKK+3v0TUVIIKoUQTQdEmiqs30hCV0cOf4I7Et
         SIF4b46KMIJnRQ9Qiq+Ebm7DjLZblL0K0liVm/i77acQWULVIuX3ESE38oc4/z+Sxo0h
         PV3w==
X-Forwarded-Encrypted: i=1; AHgh+RoYZLXW0YyvKaHTegc/1dVLES6oRD2nMLeypPPbr+nuDZlyNjGDPKYqrjJgaW0epF63myL/LE/G5Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEG9Y/UE/JeqDKcAGXlovmY526BLcaWMVvVrk1Fds/65ULDeDP
	0pclluLOT6LzhwHageyQBZd8BORG3DRANF+LJlhBz9j097jMrBALp0BsBHNwbIOv5fEWebseQWd
	WCy7Y/UhIKnApyTzNDxTyF68c4pEy8ec=
X-Gm-Gg: AfdE7cmLxbMVyRECpFREWyGpW23ZL/IanMLQXQTwdNYqLss0lqWyDK0VZWja4CPF/4H
	HgZiM0lODQePE6SwYa9GrM8AU6B5wFBsFYYow5hXfxPpqh40HLMSsKNXRtWGVlutU2Z0qusDahx
	gJU0s1K5dO2TunIoYRKmg5pPPANDajp87GKsI5Om7ywhZWWc58Z9HSNOQSkxf5QPYdHwFmgCvgI
	Q39khpEawmxhJHUyGO0TJWGorRlnhs3aXrJSGBMHOQHfn/jeFqqB1lyk8As0CLEcX52NP7swcRs
	rl1VDDY=
X-Received: by 2002:a05:6402:3512:b0:697:eece:eae0 with SMTP id
 4fb4d7f45d1cf-69810a3a8a5mr919346a12.6.1782438949713; Thu, 25 Jun 2026
 18:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625071130.93544-1-liem16213@gmail.com> <20260625160219.55116-1-liem16213@gmail.com>
 <aj1UR5ddawsdMbZC@SMW015318>
In-Reply-To: <aj1UR5ddawsdMbZC@SMW015318>
From: liem <liem16213@gmail.com>
Date: Fri, 26 Jun 2026 09:55:38 +0800
X-Gm-Features: AVVi8Cdo9F6_HUwGPZkGfKdDVs1g2IkW69-hNTuPosIJl9Kc44faaQDJLD5vnmQ
Message-ID: <CABoz+=00tywisdxcmkF_F8rOYg=BMtzZDsTN2JOXfzEwsQu01Q@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: imx: Fix slave registration error path and
 missing timer cleanup
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andi Shyti <andi.shyti@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Biwen Li <biwen.li@nxp.com>, 
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Frank,

Thanks for the review. I'll split this into two separate patches and
send a v3 series.

Regards,
Liem

On Fri, Jun 26, 2026 at 12:16=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wr=
ote:
>
> On Fri, Jun 26, 2026 at 12:02:19AM +0800, Liem wrote:
> >
> > There are two issues that affect the i2c-imx slave handling:
> >
> > 1. In i2c_imx_reg_slave(), i2c_imx->slave is checked at the beginning
> >    and the function returns -EBUSY if it is non-NULL.  If
> >    pm_runtime_resume_and_get() fails later, the error path returns
> >    without clearing i2c_imx->slave, leaving it non-NULL.  Subsequent
> >    attempts to register a slave will then immediately fail with
> >    -EBUSY, making it impossible to register the slave again.  Fix
> >    by setting i2c_imx->slave =3D NULL on the error path.
> >
> > 2. In i2c_imx_unreg_slave(), the slave pointer is set to NULL after
> >    disabling interrupts.  However, a pending interrupt might already
> >    have started the hrtimer (i2c_imx_slave_timeout) before the pointer
> >    was cleared.  If the hrtimer fires after i2c_imx->slave is set to
> >    NULL, the timer callback i2c_imx_slave_finish_op() will call
> >    i2c_imx_slave_event() with a NULL slave pointer, and the
> >    last_slave_event check loop in i2c_imx_slave_finish_op() may cause
> >    a system hang because last_slave_event is no longer updated.  Fix
> >    by canceling the hrtimer and waiting for it to complete after
> >    disabling interrupts, before clearing the slave pointer.
>
> Please use two patches to fix these problem. One patch fix one problem.
>
> Frank
>
> >
> > Both issues can trigger a kernel oops, system hang, or permanent
> > slave registration failure under certain race conditions.  Add the
> > missing NULL assignment and the missing hrtimer cleanup to harden
> > the slave path.
> >
> > Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Liem <liem16213@gmail.com>
> > ---
> > v1 -> v2:
> >   - Instead of adding a NULL check in i2c_imx_slave_event(), cancel
> >     the hrtimer and wait for it to finish in i2c_imx_unreg_slave()
> >     after disabling interrupts, as suggested by <Carlos Song>.
> >     This avoids a potential hang in the last_slave_event loop in
> >     i2c_imx_slave_finish_op().
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
> > index 28313d0fad37..04ffb927aba9 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -936,6 +936,7 @@ static int i2c_imx_reg_slave(struct i2c_client *cli=
ent)
> >         /* Resume */
> >         ret =3D pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
> >         if (ret < 0) {
> > +               i2c_imx->slave =3D NULL;
> >                 dev_err(&i2c_imx->adapter.dev, "failed to resume i2c co=
ntroller");
> >                 return ret;
> >         }
> > @@ -957,7 +958,7 @@ static int i2c_imx_unreg_slave(struct i2c_client *c=
lient)
> >         imx_i2c_write_reg(0, i2c_imx, IMX_I2C_IADR);
> >
> >         i2c_imx_reset_regs(i2c_imx);
> > -
> > +       hrtimer_cancel(&i2c_imx->slave_timer);
> >         i2c_imx->slave =3D NULL;
> >
> >         /* Suspend */
> > --
> > 2.53.0
> >
> >
