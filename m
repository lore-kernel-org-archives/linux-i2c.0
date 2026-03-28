Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B12A2EB860
	for <linux-i2c@vger.kernel.org>; Sat, 28 Mar 2026 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774691250; cv=none; b=EXNeuXanQN+U+Afoqr3pdFS9QKuVoV9Nx4N0k0DiuHSmvaTLHhtUK2pM2NxnCkMcIl9qA1n8D8nrHNmxan+9Mvg+s/7CObWZ/p3MkaL+5m9e9G5yBN78D22/JCrA0W63LSojdTNLWCFsmWO/oYEuZ3rnWo+R6oPfNAo59Z7Ldeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774691250; c=relaxed/simple;
	bh=Jxt6Vb/LL+6x0BLPYxR+WMTw7Py82v9S57v6w1ZdW6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK5HoLTKe7GW9OV3RruqWC1KIpABOwuO+YNwRNVbWQOjg5WDEbXe1exsprE5LS6YrB/627cCiiL3j8S1BLrh7UQwd7N3xuA8ISNT/z7B46T1H7FIaWuYlkNjd7hd/j7pTCAjsAmkLQcYorXejh6nEBzVUHbet8H/aQSLN2QhLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XW8/ExsC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XW8/ExsC"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0603ee486so18181995ad.0
        for <linux-i2c@vger.kernel.org>; Sat, 28 Mar 2026 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774691248; x=1775296048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G2KVjx+zR6dP4AMcDHfWZnjTLG5qrt1ahEeg2hEXDck=;
        b=XW8/ExsCEmLvyvg0eY4nkTgPFNRWuyswV6wt+nFxXr4YPIyXnlT37d3HYBiejeihRJ
         d2uH6ImyJE1f6kxEJmzsFQY/baoF30Ngr02bgtqF8pQP5wAXTcEL209xtzK5WQKFTGYQ
         UrSW6VRWOD8sKosHoAWBbCsADZIcUpzp1S+FofRTXTqN5+aJ74NCX82/Vh652nt2O9eV
         8Dq2Zjv+8CRjykUuT1xUYhe+FMcWSirhDdbej+efkVbFPB+9GFiXeYzojpVdXdj7mx50
         B9h4thPSfbmp/+m0aw0B3EKQUhYb90UGydZ7x6Pde7UL3PBI5XCPJ0E9p2zpH5DUQX9/
         Irjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774691248; x=1775296048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2KVjx+zR6dP4AMcDHfWZnjTLG5qrt1ahEeg2hEXDck=;
        b=WDLYSNZauQUQVhhYAGAG/d8ePsuD3OXVyjG6wLGcGN95zGeMQhAX4lWj3cxHxWAIW3
         bIZrJ/Dazb8yEVW3VW/J7IVZYcXCuiv9eb3ZY/pmO4nJyJ5QCfQVEFkIyB350nWBLe33
         gsLccQdFPnSRzrB2LWEXgmRgxlAOFOo/YxlcNjY8QOuMzH47Lj+1mqTGGnLR0qfs8iH5
         EPs6XNWBBrR01tRfihvuP1xpuqcDsb2jm1Iq92smEby1ft8+YxpQZr7NnSbqOZe7Y1NH
         8zYkJdYX1xd6s2JBhyr82+cYHsQ8kyFzrzG9vizd1WKT1vvGRHWz47WUkFeR/jgIjetD
         PdmA==
X-Forwarded-Encrypted: i=1; AJvYcCWwlOaIFYClF5EPug4b7FEE87P2OwkBf3tqOTYDGHDci0re4Jm1QLRWB5cPhNJhwItNh3GljBUfjbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhwMIixPW0FMRaoo9hlR3VsrRx0wBY5TaEctk3IZ/2UCTw06VR
	pT3o3VyM1jvMu4n0br0qBLslQY40m0X19F5KKDAqrpZRHD4sioKKoPAl
X-Gm-Gg: ATEYQzwPeA5EWx7/fcTdNkp5w+xl2B3gUUJ+EXt87OQfJktkfMscAj57Evhx0H8Tw8e
	YmV+FqftmetFOkybZL83eEXUFeYrKOB0mWm6kipX7DzK0V5+Aom7lWaw6mF3uFrvX+kDC/2pEQz
	p80uV+XRhtRH2P+EArVKVGgD2uqXfT0Ioav7L5L/BrfyhAyrBZ4rUP8LOjF+756uiZ6yYRRDPwT
	lgS3D2T5u1uvXX6bFBDTYMTAtttU+Y54M33J5PasNl7xVBZGX/2EhT6Reoota1pqJ8tTM+7G526
	MTlsS2jBkK7o01vZgT65r7d50Xma3eKcrQIJu+9iSw/bdSKhDNv4UyBNiIhhfaEHFdj2Hoy8rXD
	lOxlySHLNQfCqes8GkFmYlvUn2sgTVBzlr5WIFcJt/Jf/lqIpvUSIWhG5qEi5m4VFbizKHb+KFO
	+LHpYabcA6pGmpsbFhAb0=
X-Received: by 2002:a17:902:ea08:b0:2b0:6e8f:8e73 with SMTP id d9443c01a7336-2b0cdd9260amr63454695ad.44.1774691248291;
        Sat, 28 Mar 2026 02:47:28 -0700 (PDT)
Received: from fedora ([122.173.26.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242787bc7sm18789745ad.59.2026.03.28.02.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 02:47:28 -0700 (PDT)
Date: Sat, 28 Mar 2026 15:16:49 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: andi.shyti@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org, linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: Re: [PATCH] dt-bindings: i2c: intel,ixp4xx-i2c: Convert to Dt schema
Message-ID: <acejiSOOcHmqcouI@fedora>
References: <20260324135010.17730-1-i.shihao.999@gmail.com>
 <20260325-bulky-mushroom-of-science-8c95c4@quoll>
 <acP69aM-euL7wl87@fedora>
 <c9b68d56-48f1-4ade-8711-fedd8acf0666@kernel.org>
 <acQqE-iW51fOJnTJ@fedora>
 <1bda00e6-a3bf-4890-8982-4d61a4b4845e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bda00e6-a3bf-4890-8982-4d61a4b4845e@kernel.org>

On Thu, Mar 26, 2026 at 08:08:06AM +0100, Krzysztof Kozlowski wrote:
 
> By running, I assume actually read its output and fix it, so please
> share why each one of your patches has the same mistake reported by
> checkpatch?
> 
> > I will send the next version in the coming days after properly running the
> > checkpatch.pl script. Also, you mentioned some guidelines regarding GSoC
> > could you please let me know where I can read them?
> 
> I gave them to GSoC folks, so they should be in the GSoC DT
> guidelines/description. It was also posted for more than a year on
> @krzk@social.kernel.org and some days ago I updated it as well.
> 
> Best regards,
> Krzysztof

Hello Krzysztof,

      I hope you are doing good. I checked this binding it has 3 warnings
      one of them was  from the license text and the rest two are this" 
      WARNING: DT binding docs and includes should be a separate patch.
      See: Documentation/devicetree/bindings/submitting-patches.rst". I fixed
      the license warning but not these two "DT binding doc warnings". I wonder
      what warning you want me to fix please let me know if i need to solve 
      this remaining two  warnings because they are in my every conversion patches.

Thanks
Shihao

