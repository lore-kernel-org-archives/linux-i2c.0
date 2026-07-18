Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A926738B
	for <linux-i2c@vger.kernel.org>; Sat, 18 Jul 2026 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343713; cv=none; b=fAKsPULw4TLX37ejAp81qi+12tDvLCGIovhL4Wu/wSYaNAOYSvufhloK7Oc+TQMudilygzkbKHVcd3JBpc4HJoelIQcXFV+LZ3DEdyzX+iibjsPNfspYMVv8kZr/Iro4oRXsK2P9Q1UIM2j1D0iWd7r2AOa/yI5wa2/XAEukY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343713; c=relaxed/simple;
	bh=72VpdzycToFx5jYXpTxGZ7WwbQARvNnQ0l5lLRfOF/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WolzUj6NK98BGPG8hNl5XDrhApaq1ozgRQQh+uiIjWTWpwbq+6UkaToryIs8DO3hlniXf2HAYfO2ADvXoQ06NJutVrBEJzN8ZtJh0IKV3TBZfbYa6P3qgpRXkqvpIzuaLgagNt7tXp5SKIXlJXD641BaMEtwm7qBxuH8QL7CAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5mWB3i4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5mWB3i4"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc73e322dbso101758475ad.1
        for <linux-i2c@vger.kernel.org>; Fri, 17 Jul 2026 20:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784343712; x=1784948512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72VpdzycToFx5jYXpTxGZ7WwbQARvNnQ0l5lLRfOF/s=;
        b=L5mWB3i4qi4xkobO7fZowrtwOMgXzsK3LE0E5vnqPFBD0H8dGWAYfZQC9+L4Jk6J3a
         Ra3ZTMBO12W9loiu7OIkSoVGwY6p41OJHOYkWSx2NEvIgW+2azJABGPfjS+vreHebJaN
         owL9eYmBbJwiHlicyWVx15tgoA6EYQ9NNNoVLlmgSz60aU+m8FlBq9SYvrIIN5niluDV
         uJgEaqohd2NY8Od9QWYxyIfnriFFt89HTtWmdIbSXLAqHqOC5aB5nnUX7XdBlypr9yJh
         9oEbCy5gW/KsVohLSUJLXcbda/brHRMz4qOOHt30elP/nHESzqvpzgZH5ja0Hq3xY+OX
         /Dpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784343712; x=1784948512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=72VpdzycToFx5jYXpTxGZ7WwbQARvNnQ0l5lLRfOF/s=;
        b=ZYarrieDFDw4oB2SbSx3twGkVeEri+S5d3i+oEdJ/PshIYSxw2H6X6PvPCgY2q7DUS
         hMch6Uvm31w9A7blYhhRg/FOVHmRf0wKrty3LG3g9N/ODYRgJtWLkHlTi47EU+iUoa6a
         DwBeQibtXYO9wEHFTYyd1PmNlvi3qWyJ/ZvWQuI7SpEaG+GTowtDRm0/zM5tOYCNzoqj
         L9xfXyMJu0clt1gwguRFHOkSqZKLuFUANlEaT75MMvD2FyBEqYhXxIQJMAHYfIXu928E
         pZ+lxRR4ZWIEH1kZCnjjY3SIx5qKBbeCBq1VDpv9utuaUrNU+obLrqIxLz4yDln3atMG
         MWmg==
X-Forwarded-Encrypted: i=1; AHgh+Rpbz1DGU07uI3qo9K9oVKAUsytNOcqaN75Lx3ZY68IcymHGDHvh7Ot58o5jnOeUw5+Jy3UBKKqi2N4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUcd9fA8oZC3QOvI16iz8KlM/zCMCNRMyVAms3GI/p+1dRuJg
	nCX1p1JkDfcCemCoM7OCy3Ld3To367tdzfvMMnxHvUWF0+dxADOsoqU7
X-Gm-Gg: AfdE7cllKwfx0XEnzz5Qq5Dt2mbSwWucKPGl4ePCPAgv3OK/zdSnkdCh3NJ8bSA/c2F
	ytBOxgYw0mSkKL8It7nH19fY8cynd0xzV8ihgmoYEyhgKOTHK1EV/gO0z3WJL6HibM1GB4dxhg4
	9s+mtdVfeL7F0RM7NnwxlLTWJygCr/e+5kzxr5nRIS47quFgGdTFJCfan0dUWUQRkumdghhish0
	xZAL/f61tOLReEMNTdBIzPeUao0of9OcfaRvkvhi4PpGeIKoJq7SOzU9nT4O96GgbbxqnwNLY3q
	vTpBEWbNi0bYcfiJJBM3jDoyR83uMiuaquS7ZnQyp0qp68UHnnTv9qQ1Rh1McywMT554J++WEsa
	DoWVQDsP1I1PVHpEE/id5rBjm32aXLy6dk2IUOx3wAzYW8iGyOtHHxem9otg/yxe9yDtSlMwVNr
	odvkbP8TUClEkqLZxyJa507iyd9BY7/PLzIXSoGOZvHz/BKQMgtoTYVD76t5lsCOgV5iaun1Zkf
	/mCCZnnzdN8Hsr8OYrquALjNtUba5NWYtZNsJnUUdOUej4CR2jS4Q6xNzWFI/cz2oHStlg3n4mP
	rfahWVNxI4e7iHRPCNfD6EOvVd0V6AT1Sika6+z73Cxl4DiWmYsLMlGnLyDLek5I51VSoNxeuj6
	s9g==
X-Received: by 2002:a17:902:c950:b0:2c9:d8c6:1dc3 with SMTP id d9443c01a7336-2cf3463299dmr56325425ad.0.1784343712078;
        Fri, 17 Jul 2026 20:01:52 -0700 (PDT)
Received: from ip-172-31-21-198.us-west-2.compute.internal (ec2-54-213-160-35.us-west-2.compute.amazonaws.com. [54.213.160.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3474100fsm20456615ad.66.2026.07.17.20.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 20:01:51 -0700 (PDT)
From: Bruce Robertson <brucer42@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	ojeda@kernel.org,
	igor.korotin@linux.dev,
	gary@garyguo.net,
	tamird@kernel.org,
	boqun@kernel.org
Subject: Re: [RFC PATCH 2/3] rust: power_supply: add power supply class abstraction
Date: Sat, 18 Jul 2026 03:00:58 +0000
Message-ID: <20260718030058.1677-1-brucer42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ak9kAP1SZF8AchQT@google.com>
References: <ak9kAP1SZF8AchQT@google.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026 at 09:04:00 +0000, Alice Ryhl wrote:
> > +/// Register a power supply backed by driver `T` against `dev`.
> > +pub fn register<T: Driver + 'static>(dev: &Device) -> Result<Registration> {
>
> Should this be &Device<Bound>?

Yes, it should. That also lines up with Danilo's comment on the i2c
side of this series that I/O-capable operations need at least the
Bound device context. Will fix in v2.

Taking &Device<Bound> also helps with a lifetime problem the cover
letter flagged: the trampoline currently recovers the driver's private
data via device drvdata, which the i2c core only sets after probe()
returns, while power_supply_register() exposes sysfs before that. For
v2 I plan to pass the driver data through power_supply_config::drv_data
at registration time instead, so the callback never depends on drvdata
ordering, and to add a Sync bound on Driver since get_property() can be
called concurrently.

> This looks like it should be a ::new() method on Registration instead?
>
> I would compare with existing Registration abstractions and mirror how
> they do it.

Agreed. I'll rework it as Registration::new(dev: &Device<Bound>, ...)
in v2, following the existing Registration patterns in the tree, and
look at tying the descriptor lifetime to devres while I'm there rather
than relying on Drop ordering alone.

Thanks for the review.

Apologies for slow response. Was wilderness camping.

Bruce
