Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4CA550DA5
	for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792098284; cv=none; b=ZT17AbMZPVqknuIE0Pi9bDUsaniIEb2rE6JwLGevkIhGSfu0THALVRt7miU7+Yk0bnxv1H7TjNZ48PunsYjYeOatgMwarZX/Ld0drzhgg/+bIb4N5ajQoKZvnUYF+FP5fcEBp7a6DzVYC1IjKDB/3Gb27jvKeVJyzz1pmTF8Yqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792098284; c=relaxed/simple;
	bh=7H04CVxxX4x8yKDGeGsyvBX1tcUcpxtXmtydhBTctSk=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=j4lPLRdwH5aRU8U6B2U13bR8MSwKP5Z9ZEyx362xc3eh88DwYTr4lhu33dqAYLwsf7q4Vt3KdhJjktx7C09mfErO5on88pfQwl3sRmLjwFo9ietjTecj/3aQ7I9Zc0UAmeQ8DWLivvisxlnwOK7c9+2UOgw4Ssx/eu+x4GyWHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=bxyXm997; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="bxyXm997"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-17bc533fda3so2747948c88.1
        for <linux-i2c@vger.kernel.org>; Thu, 15 Oct 2026 14:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1792098280; x=1792703080; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7H04CVxxX4x8yKDGeGsyvBX1tcUcpxtXmtydhBTctSk=;
        b=bxyXm9973MrNM6E+YfyDxQdxF+50u6SOgQTLnuW3aUdFqm5T1cspNxYdTXnus9hz7I
         6ECEoRVRp1JzGy/fIpN0WafiwMCDmWyZU2DCU2yqXV5UbGobas/xkUU8Jltxk20x16Et
         yyniftTkFujlXGKC2hZ/UMF3SNDv6XCsG1JVn/s3Q2kgGDBCwZ5dek+c/HK8n8NdX6x9
         DHfu5jNyyKrik8/dxhRfhGCVxeqFM684v83WUyZ/IvxQ1jjwY+iHK7HMU0IH1pU36oSS
         S0x5wnT+e7ZhQigjjCoQQTuRWijt1Ds4BM+SxzklIbTHFfYwDaShnGQHPcmFAIyQh6R3
         clcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792098280; x=1792703080;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7H04CVxxX4x8yKDGeGsyvBX1tcUcpxtXmtydhBTctSk=;
        b=j8+8Fw0K33S9z17Ol327LP8zLsjd9cpgxxvJ8VpC3PEZUnS43LDf62CzebFrM4vUfb
         whrP5RAoXI+GDEN1cv2OkhbbT1UI6pVr2Rwuo8BXTb3iTp8h0+7B6olqXNGoSW4vtLPA
         Fjgk1+1pVispSY8NbHp7jSZB9M/noqCltjjdzdApTml0xZOJSfDp8+OT62T7vGoRhfKj
         vybE1qpxFFbvxr2msjwZpOwsEbjgJmm22uJB3Ci1K3VdDCa3d4T3bLYZS9og9TFEmHJg
         lOXueRKbNSPpNJfTD+3slu3H3eQIpP6KyCPk8tAxExEtj2nUfYGsCHAaPueAjrWkNVkK
         YwNw==
X-Forwarded-Encrypted: i=1; AKwUvByrfhuP4kTl/bpZnkfYD7D5KtiFOQLkabt3tzMsfS8y55VpgRTU2bPDxR0dLd1HT44fldfJL9n0XdA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4UJ37W9Ts5PxZXkhsoNl3vIm78OoVt5XYjprGho315HlBPy4M
	9xfhahQZGntuVGtzdoqji7Opd6XqxRIdJ3Fm3HoIC17Yu8AWZ5ojEUfW9MHdDz91qrw=
X-Gm-Gg: AYBFou3PGi0HkVyobtAVWU/THGQX7X+n6GHj487+XAhzp8TGqtDVThXr9Et7KCEowcU
	EbDKsoZmu91BENegdpZzgAdm5ui4Hdf3+hkDI08RjLjmRMUuwlrYC9yvvQbfVcMJRbYXdSP0kcJ
	jlzIICV/41mB6PepLwaA1ULfsyI/27IxjvU+ZIVR159Xf8SFpr8T2ss75xEfSNPi10Ne/HnrlF4
	8SZZzwQd8ICoGWUAwR787APmYLBX9/Xa+i9zpSis9hdMnb0oYKYFXdLfvS9Nvt8AIZ4SVjYCF9f
	8OsY0h+dr7oQ6PLvUH18DPyQlYCn3WAJo20y+1czBs2VBpf1Gqm0WD6uijzmtmt288Yi2ZqqUzi
	0eniMz1Xoj4Sol3W2FtVyvm3emyLrFy0Egr96cS/i9JZgqUy5Z4miRlbbqxf5aD6frP5SMhmyhj
	kbxYEWf9bZ3QhVXhmvzr/HiNsP7EaTHZlNt4xrKcgXLTl+dvknNSJEs/h2W0c34eTDDh+SrXg=
X-Received: by 2002:a05:7301:b13:b0:35d:a0cd:e4e9 with SMTP id 5a478bee46e88-35da0ce0d9bmr8413450eec.17.1792098279540;
        Thu, 15 Oct 2026 14:04:39 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm814741eec.24.2026.10.15.14.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 14:04:39 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 14:04:38 -0700
Message-Id: <DM5PTJLL1Q7I.3LGRGXTNBA9SF@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8] i2c: xiic: restore non-managed runtime PM to fix clk
 WARN flood
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andi Shyti" <andi.shyti@kernel.org>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.22.0
References: <20261014-i2c-xiic-restore-runtime-pm-teardown-v8-1-40668c270069@nexthop.ai> <atE6LA8SFpFvZfzZ@zenone.zhora.eu>
In-Reply-To: <atE6LA8SFpFvZfzZ@zenone.zhora.eu>

On Thu Oct 15, 2026 at 1:40 PM PDT, Andi Shyti wrote:
> Hi Abdurrahman,
>
> On Wed, Oct 14, 2026 at 04:56:55PM -0700, Abdurrahman Hussain wrote:
>> The devres conversion replaced manual pm_runtime_enable()/disable() with
>> devm_pm_runtime_set_active_enabled() and dropped the remove-time runtime
>> PM teardown. The managed release tears runtime PM down in the wrong
>> order: it calls pm_runtime_dont_use_autosuspend() before
>> pm_runtime_disable(), i.e. while runtime PM is still enabled, and devres
>> is LIFO so the devm_clk_get_enabled() release runs afterwards.
>
> ...
>
>> Fixes: 50c63491ff26 ("i2c: xiic: switch to devres managed APIs")
>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>
> pushed to i2c/i2c-fixes.
>
> Thanks,
> Andi

Thank you!
Abdurrahman


