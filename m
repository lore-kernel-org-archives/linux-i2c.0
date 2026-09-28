Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1DC39DBD4
	for <linux-i2c@vger.kernel.org>; Mon, 28 Sep 2026 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790574087; cv=none; b=eZfFuHebWavqqgsB8WquHgMDnJKIJ69p987VW/METfgb4G/ArW/uJot+HivGqJ2G6e6MjfKACmXE0UjBQriXdyNAMfsQr3MSvSbqw9eFtAkxw9ONhgrcHCLVs6kI9u81TSmhZs0FHFwqzqia788bgI8rhHEMEG/3lugjRvchPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790574087; c=relaxed/simple;
	bh=EZyCEhmsrPJ6iqcgPZcq9Join/xMTLiw1rD3Av1IrCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWuqHkSFgi3eImmfrKwPj6AUtlvxoI/5Za6BkTAwqHNh6IEtv5J9Lk/8wnH3wF66U9VKhQwkeI2RLu21c8K6ouIhMrexqTDP2fctAjOepxIwxpB+UDoQ6jLMZH/blason9GyRwaPtjyyv95MuwwTzpoI0DKjuDhr5/duykDJh20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAdrYXB2; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAdrYXB2"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-347866278b6so166225eec.2
        for <linux-i2c@vger.kernel.org>; Sun, 27 Sep 2026 22:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790574079; x=1791178879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fuLB2WbMYaXmOTNLj5UMb1tSxTygqKrNl56AOMg1rmU=;
        b=iAdrYXB2Ovn7wEOFpOYqhuLNtxoz9bTxq1NSCNlAl1GGOV9qZJAq4Zj+6P6kVsSEwk
         SLmiuRGWRAYphVidV1+uvFB7Ywk2SySe3Vjw3226xfzWlzeeGSM/gIOgXKu8mUSrIJpg
         tBhWX7EIdk3XX82UXQi7Eh22wQAgN5qZrj0555lpc5Y7js66hiaa/U4ISduwKrgLxnvT
         7T16p5AL5vKnHTH9vQYBl3BwCJ/P5ukgoLUQfNrezv+bRpc9k2zZVnZLvAgs+96GCR49
         0hwEaj54u0ZKtII5BFyY8O6lR/POCNhaGFEXPeR36AnH0vu07cP0Ict8EP6j5lR3pQzS
         0tPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790574079; x=1791178879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fuLB2WbMYaXmOTNLj5UMb1tSxTygqKrNl56AOMg1rmU=;
        b=1HXSLDn7bD+2x9uvf1/kgm6em6TIN5o1t2+XageZkxP5ygQaGvz2owAvKgW43BRwXc
         c5tfPJnDiZQyTCz+yA1gKyvqdKTYvGki7AJY/uwpo3aHbLhfNF4U+aU1PGKtrZN/2lao
         qImPhCEWoPC4fRbDVpBaWDEH4X670VtS5gT2czZvQPBkkQkZVtCZxjpf7CXA+K/csOfP
         yymr/DwPD31idRNng8hnQ0DhbnICLVIfUXP0hx5hpPDvqxr1/eph7UqrdoefYnqB+ZyH
         d7kJutUYwrpyF7yFImWoWixIXP3tBW2YU3zRN8vcnyRC8wQ02lNilg8LipP7ZwtSh+hI
         /fXg==
X-Forwarded-Encrypted: i=1; AKwUvBztOxdb5CFBgkUE3R09V+docS3sUnqHvr3Q+a9BvMEEbxmRozE/f/EQCL8DvQaKmbTthPFHX/nbFIE=@vger.kernel.org
X-Gm-Message-State: AFuF++lFSa5iep9wUj3eJaMWuqtlPu7s9pT5XXjnkoC2QCUg6wWu+kd2
	ZvAmYe5J8uZj9V51Ll5ubXVNTwAqTCMSlUdrK0mi/c6MEtQvK4Cjcov4
X-Gm-Gg: AYBFou3sJDBHCBe4z0XDwWLNlAQbRL8k+4+Ax7l2YuuobC3xcNXzbGEQX7u5KzFttXA
	wvDVm41DVFmB1CGu6iYHVS0BaQl/AJwEeYVAGI9etI7YAsF/dMQfzmTtA255+vtYCtsEOGnq0+o
	VXiiksNhf50n/4gnPJ7cwh85Djmdwfd3gIulSHyHbrDSNuhmE++ygLW+Ip1c8r4ucZQZBH81gLH
	4AEEc5eqlgSV/xbodJLNTa1+KonIlqFfJ1kloyMeFo1kyoMQkV+1QkAauLNND/vaEN5ZAMlLeXi
	t9fByhdHuykxZVx4o4HMiSDj+wA96F4TuxXFSh27pVozFt93zx9giKRBwKZP4DH3JnTrQOmWx36
	0aFi4C7cQpeawjiLRCJSOCvkvdpoq3K/+dKoM5Y2p6qiRKV68RD5yOpJJAnvXRFjZytn7dlmAI2
	/7dOZDIiQtXurajq2lv3mM6hEy1TnDzXySU3Ld4EdIMyX3uxlX4AP1KsO2Yh/F5a0ZpE28ykiP0
	uTvRTSL2XeS5V0f9oeKui2oLGDy5etYVJU4ta1s87vpz0nWWTk=
X-Received: by 2002:a05:7301:da88:b0:33e:a173:4aab with SMTP id 5a478bee46e88-34270aad672mr7959353eec.14.1790574078226;
        Sun, 27 Sep 2026 22:41:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:526d:2f94:503b:aada])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-343580930e2sm16277258eec.16.2026.09.27.22.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 22:41:17 -0700 (PDT)
Date: Sun, 27 Sep 2026 22:41:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Bryam Vargas <hexlabsecurity@proton.me>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] i2c: smbus: make i2c_smbus_read_block_data() safer
Message-ID: <arn9x7nwovm85HfY@google.com>
References: <ammWUROtUGeriY8G@google.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ammWUROtUGeriY8G@google.com>

On Tue, Jul 28, 2026 at 11:00:23PM -0700, Dmitry Torokhov wrote:
> i2c_smbus_read_block_data() is dangerous to use because it may deliver
> up to I2C_SMBUS_BLOCK_MAX (32) bytes, which may be surprising to the
> caller. Callers tend to allocate buffers of sizes big enough to hold
> data from a well-behaving device and do not expect that
> i2c_smbus_read_block_data() may attempt to write more data than
> expected.
> 
> To make i2c_smbus_read_block_data() safer to use, change it so that
> it accepts size of the supplied buffer as another argument and ensure
> that it will not copy more data than the size of the buffer. Signal
> oversized responses with -EMSGSIZE.
> 
> To allow users to gradually transition to the new API employ some
> macro trickery allowing calling i2c_smbus_read_block_data() with either
> 3 or 4 arguments. When called with 3 arguments it is assumed that
> the buffer size is I2C_SMBUS_BLOCK_MAX bytes. Once everyone is
> transitioned to the 4 argument form the macros should be removed.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v2:
> - dropped incorrect changes to Documentation (Andi)
> - signal oversized responses with -EMSGSIZE (Andi)

Andi, could this be applied or would you like me to change something
else?

Thanks.

-- 
Dmitry
