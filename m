Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED339DBEC
	for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673459; cv=none; b=afq9CnDMg1suc/u73NBV4RSXDFq22vA2tnCdI/LhO32bjebvsu2z2E4BImFsxLiwQaKGm3FMDQDQ2mSy6F9NWiYtqK4sAvC+twYIlCaR/ZJieA1ziE51Zky8G6PCvviUGWcCYwyq/AprrCJirifCX9pAWbawjoXK75fGYeuNjhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673459; c=relaxed/simple;
	bh=rGewoBv2ScUyk29jPFBjVpjQ0sFVMwuXWUMDaqZZ04k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ao/YbLU3YXzD7q9Q++3RFTmAxQqNPZex8rWXnTWT3eKbx3fEWaFDpkqjaq15+rHl0KRnQRU/SZuuGpHgZR/yLtqNRH85Lh8gT7GooFHHr7B7bpV0Br9z+YFFiuJJcrYEFzWcXSDqIvE1H2r0j3DyMNlwExIJGsYLgQzRj1u/sy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGxFq+cz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGxFq+cz"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439c5b40f60so3670570f8f.0
        for <linux-i2c@vger.kernel.org>; Mon, 16 Mar 2026 08:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773673454; x=1774278254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGewoBv2ScUyk29jPFBjVpjQ0sFVMwuXWUMDaqZZ04k=;
        b=TGxFq+cz4sJV1LPt4FZhCwb8ZWtZubL9ZPh8wD513yTM9xRPIzTzg6iai2aIMqaJt4
         IxQfA3gZtCqCaJcqhNSFC7hLHz9Djmr2OEPn1+TN2q905XsvDRRDHu/N1U7jPxFla6nH
         TErrTEoNL7WSrhgyFnc95xtK9v+zh8z4HJV33NmhMJXdBVM5/yNrfVOK1R5j+Dy34iNY
         +C4ddYnUub1H9LMduBHm6+grXVkk1MVZ/VhsynI6q6KuKrMwVT729LrzzWE8N+D1TLsC
         JcPe6jrDJb8O26qCqj0DxZwcDVWz6nnRcx9E2iNmaCV5UPiUhy0nhHcBoS9jKHtTtl4p
         FkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673454; x=1774278254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGewoBv2ScUyk29jPFBjVpjQ0sFVMwuXWUMDaqZZ04k=;
        b=rx+vHrGN9qPS6Cu18qBbzvMSjwNlvb5W6vHxLiPMhKsKgGgQevufUqsPnVP49xE2vu
         K/r7O47DQVAk6Q4+QycQb2ZP7vp0IF5pd2Y7yJorp7sGD408sPPtzqemycJgwCLBpkQu
         /ta6p0aQi1539H/UaU35HWWEYXuLwPiOY50fzdnCh978GSyquvaLudMgPOgelPhp6lmh
         H6yfUePIeR1gAK6sI6MJ4ItxSpqRIF9iYpOATsZ4YonpfSrLKY6FuyssPgSDGYDM4EiE
         Ow6w+kdXa08x3ROEe8/GcGfuEVkZyqBVxyYPPcpvOloIoQH/312Bw9BEIwmZNAG1Jf4Q
         tBKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBvAq7ZT/E/RLdbdiOldMaj2dpdrNm2gkWmIpsTjFDOvXsnIpkmIyvVJEjcx+JIAROgqaDKgHuNZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSJK1D0D1Z3dfBgSAuUg1G9s2y8fWXhB/j5e0UyK7s9ht3qMH3
	uNy+y/BYxno+bKdXgP8TjGYl203cAPYb+Pj1bHkqaf81HLs7OJXpVrT8
X-Gm-Gg: ATEYQzwYkxvORBjxjRlWlaIc08BVeZj5o2ylKM0aqj7+WTnTPcDlo9Z6hJkXaR2Jtuy
	ePymJpyN+sw5W10cN8lBcSmGZIrvOLy8Xc48bmgVExmzdO+dq2JiBbgpxWQZY5GKi26bAuX9GHV
	/hiGI/m/a4hXpEn5mU7nywQlhnpb3DNG6BBtZ0jgrDPTp2xmzZIVZT7tKTJWfXQ8UQs7A4FnkKT
	z3TuSXwTRavHIfEICtwJ97Z3kUiHCfHxFSfA9rGCQPr1b/24aUywex+OQK88un7gKIGtuTE81Ph
	gj6dBjaVTyBPlBL2gVd8Tlu7f5wgQZQu/RUpW87bYYLI2EkH+OhEibT+XQ0mDHrJ0hpEIVIZBgA
	aZSAfNx5gkA6AHwo7Psy1YSZJ1G6fErPXGvVEpIAtnmlTN6jN9ThB57ayeea081KSHnhAgFVVjI
	J2iUhPt748Uw8fFpDVXAlPf0DGO6fvIAUrnEu1WkcUKNv/R3QUFtVrvNXBoVopEnujRiMqW8erC
	848wzdWOMim/t4fvRyvPqulIasrWvSnDMb8/D/WnFtM++mHONWDKIpF3epy6bWFSBQwpOLeVnIp
	OwzKJLm69y8=
X-Received: by 2002:a05:6000:230f:b0:439:b6d6:723 with SMTP id ffacd0b85a97d-43a04dc3209mr24334097f8f.42.1773673454171;
        Mon, 16 Mar 2026 08:04:14 -0700 (PDT)
Received: from scambox.localdomain (5-198-68-184.static.kc.net.uk. [5.198.68.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm45642278f8f.24.2026.03.16.08.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 08:04:12 -0700 (PDT)
From: Edward Blair <edward.blair@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: heikki.krogerus@linux.intel.com,
	linux-usb@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH 1/2] i2c: acpi: skip generic I2C device when vendor-specific sibling exists
Date: Mon, 16 Mar 2026 15:04:07 +0000
Message-ID: <20260316150407.30475-1-edward.blair@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316144510.GE2275908@black.igk.intel.com>
References: <20260316144510.GE2275908@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 16 Mar 2026 at 14:45, Mika Westerberg wrote:
> Well it needs to be somewhere unfortunately :( Gathering these into
> one file at least makes it sligthly more maintainable IMHO.

Fair enough, I'll move it to override_status_ids[] for v2.

One thing I noticed: the CPU match in acpi_device_override_status()
is mandatory, so each CPU family that ships boards with RhProxy will
need its own entry. The DMI check is already optional (skipped when
slot is unset), but there's no equivalent path for cpu_ids.

For now I'll add an entry for INTEL_RAPTORLAKE_S without DMI, which
covers all Raptor Lake desktop boards. Other platforms can add
entries as needed. If the per-CPU duplication becomes a problem later,
making cpu_ids optional would be a small change to the loop.

Thanks,
Edward
