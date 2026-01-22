Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950E3AE6E0
	for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084339; cv=none; b=tZ8gch6uZcMkgb9dRkxEJwSH8htZQexnJJLd99wtADNSEUJo3nycgZfK4WfQesDG/qQpsl1MsFSzCAeI0me04+1wSyRj9Uk3qJfbIQdwTJOD8NjkfnEhuW5s3emFk4SYwMRFaCXc6dAj19zTWDHrdWZ8ilGAJMjXXL8Hk/rPzqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084339; c=relaxed/simple;
	bh=s0PP6POZG+0DDhlnkBd6RLq6XlMNNCrkEEqlrLC8oio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzAJ0iRX4Uby+w4x/os3JHgaflwGMIjtf1yP1trWH45lKVQmtgr3WOYIPN79o5nUo/OSSff3Fe3TnM5PKQmoIz7+fzfYOC3cQqq+t2L0JOcD7cupK8UyDz40DFA4bgruhI8LuYq74r+HMDwe75x/hCgLBDKFVS4m3oyFiE/kB4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L44yAuw9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L44yAuw9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso7286985e9.1
        for <linux-i2c@vger.kernel.org>; Thu, 22 Jan 2026 04:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769084336; x=1769689136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw8PwRqcSFnjHYu9kruFq08beZFwPpI2ZTR02sRsPTY=;
        b=L44yAuw9UXdXbQTfb37ta+820tlRHp05ren+Relt6nJvhkTrFiNWJ7PdUiOOBoX5xd
         gZTqA2IkC0Gp4DqycajqLcqCp3+4I+cuiiiuWyAtxKd3QxI+GHPA1nIUXoH5tzMTTVRD
         n342LpUbMuhkdTI2ufpW+0wHsj3E1X2xH77qW8dPXo1rd47RgDv2dhLS2wjY4U9V8tbH
         a749LF4Xkoi1WO7ITYTJPRlFFAC5Dd1VTzdjQUI2tP0lGSWpcvnB//aZ65mhxLafBNcQ
         c10aSh0EQuUFO9s44yBvyGnXAA2m0yF5gTRW1iqu/VWnVwS3ONOLMaXqIhnnZk3e4VZA
         OnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769084336; x=1769689136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aw8PwRqcSFnjHYu9kruFq08beZFwPpI2ZTR02sRsPTY=;
        b=EluSbgWmCq3ImIyIjCQWNdlR7oou4Ikb2+/tfmgjSDnuQi/IGnEO+SLKBN8wr0ifFK
         Hivj63ob7K4kiKpImOEo77MHzGaJIoB9eDdnrfR8JAxbSQuradIShr18rIUj1cPj8k9x
         LPe0z5IheUfq1OQX6njzKZLmt1m1k3W5rjCL/eEYI2aYFqnGRjJD+5I5+RtL69DCc8Pp
         qgpJWzc/qtuppXmrSMiICxox0lc19ft7iNAzig5/NW87c1+ghRmpoP+gZddxdPxNeMrr
         Kwd0mtnfYvAyfimZdIHGdWZmrLcE3z9YH4LDvf4XDapXvVMEVYSmZkducHrkJDT1vkpn
         Y73w==
X-Forwarded-Encrypted: i=1; AJvYcCXwH7fBpcooN4P5nN1qd7hkJN9SO3t+47AnwFIvn40D9E3J5cGTb5/EjVHkIlXWOTTG7sAQx96gUVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMiuae2/hQ0UV+X+aesuNBOqY2GkTQBzsXiTlLLJwsAtttCSDq
	vjE5uO4wTo984gsTHO0BnORqqXOJwVpAgqO6qasGd4ml17wkIkvsSIrP
X-Gm-Gg: AZuq6aJDqz3yjbyCxI6q5DkwXfQUMmOcMR+y5syTFsjlG8Kmos1s8r9k20ZVhctjrHx
	0UNCXwvyJ6lHAV0Y/CeUwhiyP1Hrwtq//oKQ/GIVnffW9+zsdPleS1QY7LI9oxaMgeyECGFbiHh
	O3uapn48HDI+zNsTqrumDkSIl0RTLKgVPUEXPikXI1QmEI86vb5HG3ExcQBxCyvlZJporinzvPe
	UP5wjt2xOyfwWOTuFx0TFqlAw1yhY21K9qKuSleU9CzQNwmijRggtr6Xu5rzTr3xvWGhmoRSrZJ
	9/rKoFgynHZfpW1Br3HPvE+fW3aLu2g6/E8CEahOXyuhiYkED2HhRpGS2yL3JmbXJRQHZ2E7QaZ
	Sir8JrjMX93gtdL+EtwuRrhXXFPPyti71US4VJshojYz7wO0GTYrlcGyopsV+kSanOcexqXCdRa
	p9BZxPL53f5ikMWm3iclQ5Ng==
X-Received: by 2002:a05:600c:3e07:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-4803ad094b1mr190051015e9.24.1769084335819;
        Thu, 22 Jan 2026 04:18:55 -0800 (PST)
Received: from eichest-laptop ([77.109.188.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43595e0a6fasm16302233f8f.10.2026.01.22.04.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 04:18:55 -0800 (PST)
Date: Thu, 22 Jan 2026 13:18:52 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>, o.rempel@pengutronix.de,
	kernel@pengutronix.de, shawnguo@kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	s.hauer@pengutronix.de, festevam@gmail.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH V3 1/2] i2c: imx: preserve error state in block data
 length handler
Message-ID: <aXIVrFdTB4V6pnBh@eichest-laptop>
References: <20260116111906.3413346-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20260116111906.3413346-2-Qing-wu.Li@leica-geosystems.com.cn>
 <aXH_agPD8D2QIVs0@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXH_agPD8D2QIVs0@zenone.zhora.eu>

Hi Andi and Li,

On Thu, Jan 22, 2026 at 11:48:54AM +0100, Andi Shyti wrote:
> Hi Li,
> 
> I'm adding also Stefan in the Cc list as he has authored the
> lines you are changing.
> 
> On Fri, Jan 16, 2026 at 11:19:05AM +0000, LI Qingwu wrote:
> > When a block read returns an invalid length, zero or >I2C_SMBUS_BLOCK_MAX,
> > the length handler sets the state to IMX_I2C_STATE_FAILED. However,
> > i2c_imx_master_isr() unconditionally overwrites this with
> > IMX_I2C_STATE_READ_CONTINUE, causing an endless read loop that overruns
> > buffers and crashes the system.
> > 
> > Guard the state transition to preserve error states set by the length
> > handler.
> > 
> > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> 
> I asked you to add the Fixes tag here. Perhaps you need to add:
> 
> Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
> Cc Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Cc: <stable@vger.kernel.org> # v6.13+
> 
> You can get the information above with "git blame".
> 
> I'll wait for comments from Oleksij and/or Stefan here.
> 
> Andi
> 
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> > index 205cc132fdec..05ba41144648 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -1102,7 +1102,8 @@ static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned i
> >  
> >  	case IMX_I2C_STATE_READ_BLOCK_DATA_LEN:
> >  		i2c_imx_isr_read_block_data_len(i2c_imx);
> > -		i2c_imx->state = IMX_I2C_STATE_READ_CONTINUE;
> > +		if (i2c_imx->state == IMX_I2C_STATE_READ_BLOCK_DATA_LEN)
> > +			i2c_imx->state = IMX_I2C_STATE_READ_CONTINUE;
> >  		break;
> >  
> >  	case IMX_I2C_STATE_WRITE:
> > -- 
> > 2.43.0
> > 

It looks good to me, thanks for the fix. I wonder if the functions in
the isr should instead better return a status and based on that we
decide if we have to change the state or not. Then we would have the
decision to what state we swtich at one place. However, this would
probably be too much rework for that fix.

Therefore, if you add the fixes tag suggested by Andi:
Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
