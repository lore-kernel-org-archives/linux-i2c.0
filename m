Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2280933B6E8
	for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511250; cv=none; b=dFagBrf+PNxo4OAeIOGiNDeBpiedXnmYzZOLlzE3U7Z7czMo+wdsXdUN3whEU6U7jLOCF1dOJaaiZY6SZVU6PqS9ABuarHtWG913cyU29eBmW8NR4FHn9wGtNPwB4MZsr0mKyeJLJUsKUnWOZoFpO4iMJw5/DHJvJxRiIFC5Ul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511250; c=relaxed/simple;
	bh=O0eARiw1G6RmntTPXYAxLsbyESCE+Ern2D5WQkar8Lo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GAAHpZMN9F/roLarmX6GgEAAJvwcv71wIAmBhlMt4CFioO991LPAiHyd23fmG25O5TvS2GNjh3RCg2BO0Y3W9TdaeE70lWBSwoMmm26W1GyaBA6iRD1bvbzlC3XsiFjoulrKWCXPmNJMhfMg9XpD9gR6h2442cnN9IlNrKJAEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bR6jeV/U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlpuwW/i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bR6jeV/U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlpuwW/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774511248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jsqEMVBo618iREZvKPp9ckkBj0Js5bgevHsPaD2c9U=;
	b=bR6jeV/U7lN+lu9GnqD+zvtxQLb/qK0sBikEMF3JIPxQn5pv4n+sQWoNv7nX2JWjlRQjdm
	+jCi6AkvxVWvpcIMYEKXRE5C/DUbZeBOP1klggS3NaCDoMZhITDO/Qdxpduc29BvSNRHhR
	Q0kuRtM4piaemQmwOBpRRXdhfw8NE5A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Dw7MfP9uOiKWXhf1LJFHdQ-1; Thu, 26 Mar 2026 03:47:25 -0400
X-MC-Unique: Dw7MfP9uOiKWXhf1LJFHdQ-1
X-Mimecast-MFC-AGG-ID: Dw7MfP9uOiKWXhf1LJFHdQ_1774511245
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b4d3919e4so385997f8f.0
        for <linux-i2c@vger.kernel.org>; Thu, 26 Mar 2026 00:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774511245; x=1775116045; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8jsqEMVBo618iREZvKPp9ckkBj0Js5bgevHsPaD2c9U=;
        b=DlpuwW/i2APYEE+T67EIHWFHSVDVVlPHzscIcHUHCH8XS0rgRE31eLf5EfRvXTiwNv
         89sZsIVxCCTGmNYpWP4p6UTcdZoVkYLKQ4yWXCNnuzN1iwOhX75qXbs+6sS3PvlvoS+N
         9497EH4hMHXLEhIfobnEHVJoaMtWkb8H0c8pRsPz0wDUgh/WFNISKsc4FdeSbPIyRswE
         Bfp3pmPQnABe3wo69ARuGxijRJrEViEVcJ8t3Ej2HcjGBboIvSn8VWsqrYx5+fY1BAHI
         /+SbaxkPaEgp+kXBKDWQE9G4TIhO9fJMirtuu/5skHc7mfwj3xzKcaqOmr8pcSNKz5P6
         JGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774511245; x=1775116045;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8jsqEMVBo618iREZvKPp9ckkBj0Js5bgevHsPaD2c9U=;
        b=rD788ZZcoltWcHM+f6tZq/odIS2uJMLy9a2t2LEMnfRUkSW6wd1ZquwKurchB1Pw0Y
         M3W6beF/rFqU6soe4PmpbKluALY4ySQ2St1GsjmaunP7ASGcT8PAsB2veJai53Yl+umK
         FBs2IozJNUnllaHC9tfVpLdFrIqXK34CP9s53qQ5IA+uQUBocTFNIdkztW+1p39nwj3S
         wCUWb1Iu2cVjIcRCx0VRtFgAWfqlc84b8uUsePWnTSBHNfa7E5CJKoIzDruj0TNiwKRW
         ff7lslC2ANN1igbZgPIkl6DQyMF8RbEPh2adMGlSTtVmr2ORxeVV8IdRVJhDzIOGylPi
         kbfw==
X-Forwarded-Encrypted: i=1; AJvYcCXRmtXpaBuD56pScPlfKv+4vHXb+gdkS2Oa2kstx7ADTGGBOjiXRnmjNCpnknHnp1OGqmV5Mq3ycHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxECQRTRGcqI5KBriy3ErTqUNVZ5uGfW6vdOsSzpyz2IPfcCsuy
	QGXk0/CobfV+rrjtrgXHnxdeFGkKCbtkcsBVN2KwWl7BCvJw8UAG4icwDmCcZn3BW8hI2IgAqhH
	OpVJoY01tWSC6++7rzq07gP6fOhgKPRLShSUxukm63/qQOGMggc5PgdnzxoH73A==
X-Gm-Gg: ATEYQzwxzcgsN2qv/5Vypm5avzztuyRH/dZ6F5Md6Ypp2F1VG3WW415g58XXZAwJfbo
	4u1yev5gT9GnawjhxcIBM7H4iQg+a6gE7hm+GOMKNsl1I6cbTuRbvaJQfwbi66piSXNMlzE2mZQ
	pIengFLsVyW2p0utBvftiVSj8AccjWOWsphv9SVogYRpz/vcq19CU32DjBiqHMOCg2sXuLqz2os
	FKrlbq0bwXk2D3B9jKgF/9FNfKQlZdBe+JSKjC1SfyDiMSq0IxGPvl9xd1R25VLQMEJ52RJRUAm
	tkZTf6/chTjRE8+WzUdbN2J1wHBAJTlgOp5hXMgYyPH5YrefuCos7+gVEf+KgMPvBA8NZmYOCEy
	pGs0Ho2wuMqb7X9oodNs/qjufKLUJ9YcFkqlC7kfQkii4RObRq/cW2XRBL22VZBTZYNIdbYcieI
	2b296l
X-Received: by 2002:a05:6000:4312:b0:43b:54c9:85f4 with SMTP id ffacd0b85a97d-43b88a8ee05mr9887131f8f.39.1774511244669;
        Thu, 26 Mar 2026 00:47:24 -0700 (PDT)
X-Received: by 2002:a05:6000:4312:b0:43b:54c9:85f4 with SMTP id ffacd0b85a97d-43b88a8ee05mr9887076f8f.39.1774511244195;
        Thu, 26 Mar 2026 00:47:24 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e722dsm5509708f8f.35.2026.03.26.00.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 00:47:23 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Conor Dooley <conor@kernel.org>
Cc: Yixun Lan <dlan@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: i2c: spacemit: k3: Add compatible
In-Reply-To: <20260325-thinning-apricot-c156914803d6@spud>
References: <20260325-02-k3-i2c-v1-0-78f29c83d9ac@kernel.org>
 <20260325-02-k3-i2c-v1-1-78f29c83d9ac@kernel.org>
 <87zf3w6o6q.fsf@ocarina.mail-host-address-is-not-set>
 <20260325-thinning-apricot-c156914803d6@spud>
Date: Thu, 26 Mar 2026 08:47:22 +0100
Message-ID: <87wlyz6nhx.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Conor Dooley <conor@kernel.org> writes:

Hello Conor,

> On Wed, Mar 25, 2026 at 02:20:13PM +0100, Javier Martinez Canillas wrote:
>> Yixun Lan <dlan@kernel.org> writes:
>> 
>> > Add a compatible string for the I2C controller found in SpacemiT K3 SoC
>> > which use same I2C IP as K1, so make it fallback to K1 compatible.
>> >
>> 
>> If is the same IP as K1, shouldn't the "spacemit,k1-i2c" compatible be
>> used in the k3.dtsi instead? My understanding is that this is the meaning
>> of compatible, and there's no need to add another compatible string for k3.
>
> Your understanding is incorrect! What Yixun has done here is what we
> want people to do, because even if the IP is the same there can be
> differences due to integration that are problematic. Having a device
> specific compatible allows us to handle these kinds of problems if they
> crop up in the future.

Thanks for the clarification! It seems the convention changed over the
years then.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

