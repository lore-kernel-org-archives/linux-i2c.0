Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7A2F1FFA
	for <linux-i2c@vger.kernel.org>; Wed, 18 Feb 2026 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771432679; cv=none; b=jwV5t+ID4yBdw1dlNHay6Ct+gXtrQc0uMz/+BhOPdNV4aF5UCtI9RU0X0Wnx8S5cM+SDtD0RNX1YdTPuJ7X+LbJciW0v0bTgOrhhMYaCRPgEOdjP/rpMvuckqnchuvoYihUAnJpd0plDG6Mj7/5/+UDPf0LSZygx+wVZQRBTNMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771432679; c=relaxed/simple;
	bh=UFp07q0ioASXzFZZUzkNI/LzekItwem0tA37Xcrofyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2Pz6mj/nB8ms9B9u3IKi2WMWMgu6DX8M1bBrpXckKB8apM2f20edNfK4txj46KTtxAZQGzyTS2MQ+lnpRO3fOlwE4UcUSvy2G7B3KeO7PfWBZBDCOjrXzWmO1I3uOCu3x/MvG1twbkVXjqyJP/lyTtip06PDmfeF3vIbt9APM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZCcnEjBI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCcnEjBI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4359108fd24so11303f8f.2
        for <linux-i2c@vger.kernel.org>; Wed, 18 Feb 2026 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771432677; x=1772037477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=syJvSBYWmoc2bQ+suPVmqNX1ElaxT5/1N2KtMvR5unw=;
        b=ZCcnEjBIXx8RLgvc+gE3FzSuPp5WxtlBGNaDVUkS/RWtU99D80lno5t9gFkCpbKo1n
         V2+Dp+7aTVUJuHH2H358RkXl2dgBw9YjFcji4piLy1tWbiRmRNm75YyGj2PHldm4QOMa
         1H+W+EzHDkZZBWXr7HYQw9tIMj3ILS4XxZSCDuC1bEsHSykowCQu2+Ofm9x4sat5vfGb
         Mp2NUTTyG6+TptV9RfL2bGBxQnVvjPXNLf13YV7Kqc7AGFV8Kp0K1u4WgUSxb1bjA0IQ
         5U8zDczTeQuA6cyJqjbAXaHzZS1n5fdPg4DHr0yPhCoXO0Ghf+H9D+6BqPbxgy1b8hcN
         QcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771432677; x=1772037477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syJvSBYWmoc2bQ+suPVmqNX1ElaxT5/1N2KtMvR5unw=;
        b=ZTPSQiq0t3VUHLQs04Rn45XMKo92IGFSzNfVwe3sHpvjeOKlAyjhlo1Xaoab+okykJ
         TnLlTlHmp/pPi4dN7Q2l76wDTSQ8o/4PGrHDqay4q2Q1eReHUfL/CF00SN1sBCY93WJL
         uSTTD67DJhMEM9XBUzqEri84gwkA6TL+m6m7qhc4F40EdEqPpW5NbHG8ye2mBS2CXaUl
         bkr2HBLwQ048i/TS1Zn/sMqfVctaIMX/uaL+cNw9n8f/q9UnK1h4cDGh9KACpL03ZC46
         HwRZv3jOig5AxVyHzg8B7lPHBYRsozWxDkjSnudVbetbpwTEGNntAuoKysR6DY/sWKSi
         uNeg==
X-Forwarded-Encrypted: i=1; AJvYcCWVwGu2vTmK/EzeoYrt+jYnVQx8NZAbwhbzE9echF+yisV79+pA1ZI/N4so+a5jQB/s47LbAAyL7uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YywTV83QZe1851S1CfUeVCsd3rDaR+dvuXI1NvZjQiDeO+K+8UC
	a2l0ABIF8EB+/E+ziYQAa2nL0XfuNHmEQalLFI5w6HaY3iagkPPRuSFGx7kfLQ==
X-Gm-Gg: AZuq6aK6iPFrn/WhRXhJH8sW4G+lhDUhpAFs8nepZQsxmsHegu5gZKIX/v+8DKA/PUj
	QpUrYHhkgLEN4KU2NGK9Unab02a2Kz1H3DZ0h3AuiJBv21SdbW1HzWVjOOi3ebQKKce8BdeuEjm
	UtDhQT3Y8B+TRN3AhcKLo0+fUi5ggRjahVZPwdhBhcBBVQ2lwOuW4OA19xfyZ3XHKV4FUnCtR1X
	LQ8T3d8TozxWkgmxw4w6tG2jjHjel26A7BsB42Stv5BTq9LXqJ6V5HIRAQNh/w7NvCKXZKCq19E
	6MTrh6iKrNAvc6WFsIPsCivEcT41y8XGawso6Xjk7QvBanUERL/JPXypjpoMCW8VlacTiNcowhk
	QQl6I33PNo71kRtTjBp+qlLyHmtYoXXwEqeX+Fxb/x5jaz0onUoUr7pYGyZ0ptUbKOn3/AsWvNP
	fDjbqCQ0Nvjczvkj5S6PEqXmpSDClbRJnleEb4
X-Received: by 2002:a05:6000:26cf:b0:435:95dc:b8ca with SMTP id ffacd0b85a97d-43958e4c9a0mr4169076f8f.40.1771432676926;
        Wed, 18 Feb 2026 08:37:56 -0800 (PST)
Received: from eichest-laptop ([178.197.206.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8d46sm43928122f8f.32.2026.02.18.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 08:37:56 -0800 (PST)
Date: Wed, 18 Feb 2026 17:37:54 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Frank Li <Frank.li@nxp.com>
Cc: o.rempel@pengutronix.de, kernel@pengutronix.de, andi.shyti@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com,
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 2/2] i2c: imx: ensure no clock is generated after last
 read
Message-ID: <aZXq4gn4xhInQQlq@eichest-laptop>
References: <20260218150940.131354-1-eichest@gmail.com>
 <20260218150940.131354-3-eichest@gmail.com>
 <aZXoTGK_v3L4pc-E@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZXoTGK_v3L4pc-E@lizhi-Precision-Tower-5810>

Hi Frank,

On Wed, Feb 18, 2026 at 11:26:52AM -0500, Frank Li wrote:
> On Wed, Feb 18, 2026 at 04:08:50PM +0100, Stefan Eichenberger wrote:
> > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> >
> > When reading from the I2DR register, right after releasing the bus by
> > clearing MSTA and MTX, the I2C controller might still generate an
> > additional clock cycle which can cause devices to misbehave. Ensure to
> 
> Do you means SCL have additional toggle? You capture waveform?
> 

Yes exactly. We were able to capture the waveform when the issue
happens. It doesn't always happen though, it depends on how much time
passes between clearing MSTA and MTX and reading from I2DR.

If you want to see the waveform, I uploaded it to our server:
https://share.toradex.com/dwnhcrl6b9toib6
You can see the additional clock at the right end, after "0x17 + NAK".

Regards,
Stefan
