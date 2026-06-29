Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B703CA4B8
	for <linux-i2c@vger.kernel.org>; Mon, 29 Jun 2026 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723944; cv=none; b=PBIuelaeyRHjswYkhw9ky6Snzan8rGaYZH82+D7UhIBgWf4wHO7HUbxWRPYIUznzeXpFay0xbhAbuXeyngClAgOaGMIL9DBd/2+08O/47A+ZZQlkKYdh/03MyJrvYxncoqfoN0mImNuh275fcTE6Tdh7hmAPzWfU8TqF1Aoados=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723944; c=relaxed/simple;
	bh=sOYDeTA4mQfZCpnMHoK0f4awAW0/F+fADdnEvACIYf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlSWotKNoWt/i3tRjFkIoqTSzluraYuFel/RoOV0D9VPTqkt9TWgeIwFeZpTOHw0hNzitt3Pj9JRSAAGG+IBGCJPUY+8shf7k0R1oaYhON++m55kexslX2Bk1efy4Ot9YRY0j8r9bVMrRT16ztK78vau1uiwal8IqiPlHrLtytc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gVfPzPFk; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gVfPzPFk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=MRbI
	p09LLKd+2uIKhyExsegrMwLK0oBGcaPVBc4j38w=; b=gVfPzPFkCb5w98vvI9xe
	FhtkBCR1EvC2WUO3DwKG+oKDlg3wy5rJCG5fSS4BbcuPIe+J/nbGRMBt9OyaCyOb
	tzReBC/vXnaNs1AP4Jl9d1eQFDH3iTBlANqibI/Pd6h7BEcA8j5EKGTP/qJ1bdiI
	3xa+a2Q72ZNIVOayJMAzuOjeMz30SjXUpwB3R0HK858T/YZgtj35aZOgGTTPgGgL
	IraQVN7F1F9fHpA6i4T4DhG7T8gom998jT0wiyHcmErf6ktrFU0B6llKHXfL3L+2
	QWmjkcRDGwuEqNyRgmeZSCzymvT48ZwGntkYSVgfMlu7PuK4ZLu8hD7XkO4C2yTz
	Vw==
Received: (qmail 310747 invoked from network); 29 Jun 2026 11:05:41 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jun 2026 11:05:41 +0200
X-UD-Smtp-Session: l3s3148p1@hqE6w2BVLpMujntC
Date: Mon, 29 Jun 2026 11:05:40 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Stephen Horvath <s.horvath@outlook.com.au>
Cc: Jean Delvare <jdelvare@suse.de>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kamil Aronowski <kamil.aronowski@3mdeb.com>
Subject: Re: [PATCH i2c-tools v3 0/8] decode-dimms: Implement DDR5 decoding
Message-ID: <akI1ZOP_wccyC2bO@ninjato>
References: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-ddr5-v3-0-07f45075a51a@outlook.com.au>

Hi Stephen,

> Hi, this series of patches adds DDR5 support to decode-dimms.

Awesome, thank you for doing that!

> I'm not too experienced with perl or the JEDEC specs, so there's
> probably going to be some questionable choices here, but I'd love to
> hear feedback.

I am not the one who can help here because this is so not my realm. But
if you can already point out some 'questionable choices', it will help
other reviewers to chose their starting point ;)

Thanks again,

   Wolfram

