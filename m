Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B30347BC6
	for <linux-i2c@vger.kernel.org>; Sat,  4 Jul 2026 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783208664; cv=none; b=IyMFEan6FaWt6EMC7CEnH619Uqga84zVIplov77ezdA+MtcAbkmY3HgS/ycwpqj2q0YWqOUCMlpaSWzF+n4KWEz8A+seS0c4cFLT+sNSAp9GO+2YcdMIXU5Y12Mk0aU7G2QHML9J49h4y4d1uAZrmDbRgiX3A19KsvGweJhKGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783208664; c=relaxed/simple;
	bh=XIsNZqam6KN+ptafPrdhyS2Xv8HOzf1ASRI1tweH4UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdStBj20Q1G/aHwBf7H8NkwWNSsxcUdAOYYlZxJBgqNIY7sH/Unwh9fRjPvZDfueX4j9LxoKK+tZ1xi0bquYi4ijhAKmkF1pexXcUYMm/AwN89uEeOiUp0CJlpGQH1eSjpraUH6sY9nQrZCeLMX7S7FuWBR1aCzZV5sQQ72r4H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6uCffPV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6uCffPV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c7cfa17fedso17191225ad.3
        for <linux-i2c@vger.kernel.org>; Sat, 04 Jul 2026 16:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783208662; x=1783813462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ijJ32Xash5Jt49SnX7A5/BLB4XwCy86Iuli9undALZU=;
        b=A6uCffPV5VnJ4tFYEtayNLe3TcmhtfKdU2A3PIMSu4gSnTPgb/yvm3bPOcf7R7iXPh
         MWU668MhZcnjcOs65OYQ/QY8uesmkGPsUqTPvlAsb4dohAWIl9aNZQUterpxYXGU6J13
         o+5/GvU2jBQQEXpiK5k4Yy4ef/Ymkl4TBZKrFYC4UoRdTZlCOOluZujWO+iCTgdQGFlp
         qul/gf/3F31+Z7umsgEOUy8jIUd+/KplFB7E+AKH107TMAmhjvCXZerzCSXMb8UIiHxM
         yr0ehU0kGAr0CwndP6krnKRiC08O7J7B5TW+KO6dZyaUDXwg9RIH7K+oBqAe3Es7COs2
         GPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783208662; x=1783813462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijJ32Xash5Jt49SnX7A5/BLB4XwCy86Iuli9undALZU=;
        b=Ib2sZp+pTomrUEXYChE90w5+f2kPFssXR+Fhcx7HrYbO5ZWw4hQkTrrQQRWSmTtQTm
         ijfaEbAWCSPInXptKjKr2Iv/MHvofg2jpdqDhNxZDPboQ/ueQxsCDVC/9EjhY1yrkjFl
         eYWkR/dhbuXwIascI5ZIclPTAad/rGGh4YyQXYvqLdmLWwsE1iELGP5BlbdqMpSyCISP
         Y/IWZGEeoi6kJ8sQIuxRvlCYMbbdZachqIkHt6nUJzF5V/MverIp6F9abrOVqKMxtYh6
         LzUPxMYBHls1fA3gM2VGHw6v8OEck4pagoI9L74wGTYG6hcbD74qE1bTMsggDZWlSH1z
         WjjA==
X-Forwarded-Encrypted: i=1; AHgh+RpBDehNRrZ0EzUmjrOd9bzS7VrZZrkp207wSl27xv8NVOG8qdLweJ29ySbpoTeGnVTT0vVinTvacOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8qdRnPOxPv0+lkRf+J8/AQgqcRDaU9S4d9Mc7cuypQSNvsOMv
	dTttJC7ddUDzjE3HYttvQhcDmyspswF8XsnNJMsQceE4VsZYQMYxjgyx
X-Gm-Gg: AfdE7cmvF49QBE/bvxnRROmLexBYUXIXyuQFRsX4HgqFRsg2AawlolnADc5TU2SZI9w
	UKYW+WMuuyPqDxU+HtffJ6pG8Z8k7vAtO8aNbvOpuZ+j5BGEi2qfzCwG9Fh6Iy6+6OB3rvR+G8G
	33B587DLO/a/0HIePJzkP15FIY7AuHbx+7+r1s6GCqYGOObvA6U/OXVhYNI8biLtqiyxKENma8N
	H6QUsUX7h61l4Yv+jbVbUdrF3dUecWqjHsVdw9m/zSHNIdIO9CT2+LE0soW9iqi8VOkoVErDr+e
	0PECugPmYDrcYo+Jmx29eEXKgA5K8IWW7OVYtj9Gt4kVfGPfoyaek4paFczw6C9LBc96GD6lloH
	X1i/om2f+hgpBOj8w9tXRSswUlzue80bq1Ni8MnPZGasku7z754sSzcnwbI7NnpTmoWgo93n+n6
	AkVBs/4DParafP4+yUOm6U37pL2ROjg2HFTSu9A9iPQ5zxCz14jPg8RXZrTr4FboN0
X-Received: by 2002:a17:902:db05:b0:2ca:6c8:abd8 with SMTP id d9443c01a7336-2cbb74ff24dmr43520125ad.12.1783208662110;
        Sat, 04 Jul 2026 16:44:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3f90:534a:314e:e11d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef188sm34410696c88.2.2026.07.04.16.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 16:44:21 -0700 (PDT)
Date: Sat, 4 Jul 2026 16:44:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] Input: elan_i2c - Wait for initialization after
 enabling regulator supply
Message-ID: <akmZOC_J2ZTl4zLX@google.com>
References: <20260703115601.1323491-1-wenst@chromium.org>
 <20260703115601.1323491-2-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703115601.1323491-2-wenst@chromium.org>

Hi Chen-Yu,

On Fri, Jul 03, 2026 at 07:55:54PM +0800, Chen-Yu Tsai wrote:
> Elan trackpad controllers require some delay after enabling power to
> the controller for the hardware and firmware to initialize:
> 
>   - 2ms for hardware initialization
>   - 100ms for firmware initialization
> 
> Until then, the hardware will not respond to I2C transfers. This was
> observed on the MT8173 Chromebooks after the regulator supply for the
> trackpad was changed to "not always on".
> 
> Add proper delays after regulator_enable() calls. To avoid impacting
> the boot time of existing devices that have the power rails always on,
> skip the delay if the regulator supply was already enabled. In this
> case the regulator is either always on, was on by default at power up,
> or was left on by some other driver, such as the I2C OF component
> prober. Either way the controller has had ample time to initialize.

Unfortunately we do not know that [it had ample time]. For this code be
reliable we need to record the time at which given regulator was turned
on and then execute/adjust the delay as needed. Until we have it we need
to assume the regulator was enabled at the time of regulator_enable()
call.

I am not concerned with increased boot time too much given the driver is
set up for asynchronous probing.

Thanks.

-- 
Dmitry
