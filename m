Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB5933120E
	for <linux-i2c@vger.kernel.org>; Sat, 29 Aug 2026 03:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787974960; cv=none; b=Q4nHLlUZKB7jFc5R6WH0X1hS7gGXqzHvR1JLzzQffVH2xP2qsSs1DmxanYuUsydO6FtSn5yC49sFL3wRRkU78Y4ZykU1UWugpRGc9+3z+ghcaGQE/0wk5WkxwTXYyR7Lps6jND9HfSsIiHYpCT0u1E3TPsDdd2IrhYbcP3XxzTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787974960; c=relaxed/simple;
	bh=cLdeMh0wt1YIoFsO2977qzjVSR7CabUPv5BfiYz3NmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh5XGPHVJcS7Lz5HynNF693xGSHsDyXnhHSsJoDy3HRbN5dV7iqat7uA76Cr0uLP6PliafHMQ0KMHlgg0cuCP9jFGSmJeui6yCGoHSCJFn/QDa7XP86a2LLob5OWp2zMPDZtscE5U+DPBwMQLD+OzzXdT5HHKlaLyzkDL5wqbFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKibKuvd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKibKuvd"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-398a5aad413so366343a91.3
        for <linux-i2c@vger.kernel.org>; Fri, 28 Aug 2026 20:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787974958; x=1788579758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vWxpWnPJf9MfbGvBdDSI3OBheqNWUEBDYq0AJGNwOhQ=;
        b=kKibKuvdEuVfdZMLcRtQgMgtI8S54CTgOmucnVQmM8cYkDLewzxIxGWF1d3qGImxet
         uEvlBajsngq5KNrfOwINoxkprGe5UCoU9b70tnZw3xjE9/X7a+0yC19dXLOov419iWQH
         W6uCr/ZwRnJlJ1wcJsmS68rfbz3e/BeOKCtrsNTwweeOThpPp9w5dazcnP5SHwuCsaeJ
         gcRi1tTVM6emD4DOGNPEACm6MPZVZks3ZBQFkbMCUc8upN3c3+MnOiBeZyaxrMz2MsOu
         LQuKuzyMXJKuix/bYFd/0hk1wi4lzAYalZrKdFgT/We1ShrEPDpWqqcUNQHr64/6sjvT
         FmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787974958; x=1788579758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vWxpWnPJf9MfbGvBdDSI3OBheqNWUEBDYq0AJGNwOhQ=;
        b=dUxfXeq7TfFebXBqstq9/ZcfQKR4WpS71BJ3zwbC9PtVt74KH02mccni2fGWElYpfz
         Bzp2C/2Ns1iVAqCj5P2MftBJ90wgG3HE/Ej1HgpWhvA//FWbcyuDAqH4fCflkxPvA7qo
         rNU6y/Qt50OrgbVNs3fPG31vQN6mhdIEhRw/U0tTi4X4/GtT/yHEFRZ89V5Jo5gi1FOz
         5U/gEKQvH9XE2aWHT0uKhqoKotp0mCsdf4jXSVcj9V8889+6yrBKxdwTFITuwqrbgzHc
         8Wyw+Im/ZUvjJHTAgtrlq+TXnMgeQ2fORJqh/DiEZMGIpcaU+D2NWLb2qvJ1ItyAdsXN
         IbJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYKoPSK4YufmKeoLG18mqiSRJs+r+Ddg74vw4EWmihCUf1pt0GLsS6unA7LEYypcGq+A6/h8zfUCQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kIr6ELN0mnAeunkac3OHDD6RsdD79bX7G0O1m8O+YFlSF6cWns
	pAI0qZ2yVK8Ud6nUvSZWY1xN9/pI3gqauNB31++jJf68KMnThk6EOT0=
X-Gm-Gg: AYBFou2GOuglIXEuvBCKlnSIYPWvw3T9rn0Gm/OlRAAHu4XgZPAmQQd4vCRWojhoYmc
	TLU7CRgbbiUvoR7GIY1b/ZhCr5is8iRc+qnSfBbvsxNKcSRaCBu4am6dVC5S4j4+QzRABAPu+h6
	DmyxT/d1BEWcCwNxLC/5ehcF7/FGalbrOfHVB9vsKoPqlgs0s2hr1ZeF7ohwox0Bw4eDwsPwKdp
	/SJWTjufvuv7eFgXk+1HtN2ndrFQh52EjWqx7rjXXTs2OEW/3tqnCoAa/ueZXCeua/E+rtA+oqk
	IDSvfSrAefxjTDJAUNXpEccPFkGeZ1yO3ZHbpovIpWkgsv8Ta1WbfYVPdTWme3bV9vaJs5Kf0wC
	ly7AYshH/WlEgx9S3WNIUSLv5DvAIFyHoV2b4EOsTjqUciaBXAb7P72JjDg3VhjouxckDgwYhq3
	gftByF5ZOnHAuierbm0nufpqQUcFLBEO71CC59DInqiMubN7iKIVq8SF3FHmtNh/rVMIDW+3MEg
	Y0MfLrAhz24
X-Received: by 2002:a17:90b:17c7:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-396d0fc1b2fmr19853921a91.16.1787974958550;
        Fri, 28 Aug 2026 20:42:38 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([113.185.106.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b186803asm9716747a91.11.2026.08.28.20.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 20:42:38 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: andi.shyti@kernel.org
Cc: bence98@sch.bme.hu,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	triet.hoang.dev@gmail.com
Subject: Re: [PATCH v2] i2c: cp2615: handle allocation failure
Date: Sat, 29 Aug 2026 10:42:20 +0700
Message-ID: <20260829034220.3053-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <apG_qiYtTQvt9s-y@zenone.zhora.eu>
References: <apG_qiYtTQvt9s-y@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 28 Aug 2026 19:09:03 +0200 Andi Shyti wrote:

> Next time please don't send your v2 as in reply to v1. It
> confuses me.

Sorry about that. Will keep it in my mind!

> Your patch looks good, but, as you are at it, can I ask you here
> a little effort? Personally I don't like and I find unreadable
> the form:
> 
> 	struct cp2615_iop_msg *msg = kzalloc_obj(*msg);
> 	...
> 
> 	if (!msg)
> 		return -ENOMEM.
> 
> Important assignments, like kzalloc_*(), shouldn't be made during
> declaration. I prefer the form:
> 
> 	
> 	struct cp2615_iop_msg *msg;
> 	...
> 
> 	msg = kzalloc_obj(*msg);
> 	if (!msg)
> 		return -ENOMEM.
> 
> Works for you? Do you mind updating in v3?

Sure, no problem. I will update and send the v3.
Thanks for your reviewing and suggestion!

Regards,
Triet
