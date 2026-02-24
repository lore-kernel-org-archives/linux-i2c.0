Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7D42512C8
	for <linux-i2c@vger.kernel.org>; Tue, 24 Feb 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944176; cv=none; b=jdZ8p+d+zOWC0H0vJRbgfBV4LbUR0avM6J74zRQVULVxwwQ1AIwv6oZotb8fP5rX6sipWikRwOJURx7CtBuLEPGeppi0WVGKaKGy/2WJshN4EbtspX74RlU+baSkWSKFB0BRbEpKyGoRocdBPN1bgt1iwv2X7Ggc562qld+psWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944176; c=relaxed/simple;
	bh=TRs6fgkQYCZmT3snZ+87Qz6FxsRhtiQwZHuPDvKLEcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgojtWpVCFKVSQcuzCOonnK152UNbUe0t+dQy9x2v/RswQKj56ZhRegfU+rVm4MUutBnTecKeiPzoxfpplIeYFADhMX7WJbBvyk2q6irGua5VcEbpbzzS2JkQ91IG9TmdJG1e7fRs32Eqfl52+qMhuXhwRVxhGQanbDYhXzVrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvSvfMxh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvSvfMxh"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso42330535e9.1
        for <linux-i2c@vger.kernel.org>; Tue, 24 Feb 2026 06:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771944173; x=1772548973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRs6fgkQYCZmT3snZ+87Qz6FxsRhtiQwZHuPDvKLEcM=;
        b=fvSvfMxh4oLcgJO9kOPO+iboVdl7woS6DAdDmISdjnuWTjuTDz2W1BbwyncjiB41i0
         xqA5bK81c8dbl2AFLiLv6zjrYbtjn5u4P8JchfBWS52STqmUCsajOlKApBEX5jjbJygJ
         dzwy5dMFHO4iMOR9AzZtMoF60a8B+9tCVvxeV9nneFPSVyG1c1kdlaBI1ovKA3JxFuhc
         GWvTaXeB4iojeDTBJaFdhV2JtKBHMAqcoUKSa7vatb9l829vST1kBDo15mTa+91Us14w
         aFwT9wEIqcd3lB3il7le9wJUwllsLuR3ZTcTETxh5dZqTqzAhPGjtO96l6xbirYb/NbT
         zLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771944173; x=1772548973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRs6fgkQYCZmT3snZ+87Qz6FxsRhtiQwZHuPDvKLEcM=;
        b=WvS6NRth54LR9IWiUlDCR/4MqGNzfF2nbr/Yp0ymjTOsp2Pm9WElyHF0rwJODwct07
         E8RQGijA5nLHlgrg3/my7WWyNxDx35d8CWO/UKOvjWQD4ktNJ0IwES0H5flrMMOrif8c
         TkbLuF8+KjHBavm4Dya4+0BymJ5LTvw+kyHd0PIsvajmIKzcbZU+8u859Atgi5xR68w6
         qX0NFeeUOQXs8V4v50qjjDf+YKNGkCmt5NhatHFqs2BSrtUyAnkNekruNJQHerYw/y1h
         DEsMW4ixFhHhxmbPQOcqhm/45nVXkBd9NT8AwMq9IHU1Zu9vCteEMPynw1Am8UYF08Zp
         zcNg==
X-Forwarded-Encrypted: i=1; AJvYcCWxYxnKKPfrW8BqFkGQLpRbCOsyECwAbcrEyjXwF6LQzUyOBfV8wJvfYnp45slbQPGHOtGLd+rsLTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhyyM8rKA+tjEYPQGBwau0ThnJqhXo+5FWg9qtcNzh5lrJbNPy
	NlajCtvdB66x04/yi6xk856ahDapkcDGA8G1QyofgN+YGEsr2mBysItR
X-Gm-Gg: AZuq6aISwOuMrn7veOC7kUHz1OQY9p+dSOsDijYeHddAvsEvbrCq6ksw6KmEDa8VqIb
	6qhYBp34uVF2r4fAb2wb84LZwauo0N4fT79Sj7Cl8J65Q9pWybAmTEdF/4EIO15+AnxKlLxfA+R
	JNqfEA1kE3AesfTlN1cPY8p1Cu8TrAP94CwQUy5s4ghw43EZvIH98yyXU2ODwsVZlpOszxZ2On2
	jEVIU09kXei0QBRCOhVWpSRKqdBkyux3aQfFxgO5yWEWgdyWTEJ1xndlRoCWKHXnNEmSCKo3VWa
	huD4s/mdBqtB5FVi+397EV29ucV3amDFPjAUjllaxDnVcUNM2+sBGeKSbbqp233kYb90MV9ckbD
	q4/2pjZa0PkX1AhaqXFHZ4I9avcAw2TC/JkFe53RSQTr+2mKIouNJBaZ2yG5G9fl7cv3JOqZ43g
	I5rGmdrGjssRzh+0P0IPWnMhHO
X-Received: by 2002:a05:600c:3b10:b0:471:700:f281 with SMTP id 5b1f17b1804b1-483a95e5b24mr202226015e9.25.1771944173275;
        Tue, 24 Feb 2026 06:42:53 -0800 (PST)
Received: from fedora ([146.70.134.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b8902ed2sm20141925e9.20.2026.02.24.06.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:42:52 -0800 (PST)
Date: Tue, 24 Feb 2026 15:42:49 +0100
From: Filippo =?utf-8?B?TXVzY2hlcsOg?= <filippo.muschera@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jdelvare@suse.com, andi.shyti@kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: amd8111: Switch to pcim_enable_device() and
 pcim_request_region()
Message-ID: <aZ22mN9uT8xq9EQf@fedora>
References: <aZx_Yvo_an2_13Lq@black.igk.intel.com>
 <20260224102216.17606-1-filippo.muschera@gmail.com>
 <aZ1_lZLd37VyREHY@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ1_lZLd37VyREHY@smile.fi.intel.com>

On Tue, Feb 24, 2026 at 12:38:13PM +0200, Andy Shevchenko wrote:
> Looking at the code now I see the difference this patch may bring.
> I was under impression that there is pci_enable_device() already in
> the code. But it is not the case, which makes quite a different
> enumeration flow (it will write CMD register and touch some bits
> that might be sensitive). While the code looks okay and I can even
> Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> the change needs to be tested on real hardware before going in.

Hi Andy,

Thanks for the review and the Acked-by.
Unfortunately I don't have access to an AMD8111 system to test if
pcim_enable_device() causes any regressions.

I completely see the point you're making now. I was focusing purely on
the API modernization and I didn't consider these legacy implications.

I leave it entirely up to you and the subsystem maintainers whether to
queue this patch for testing or just drop it to avoid any risks.

Best regards,
Filippo
