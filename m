Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547F35C197
	for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 07:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039071; cv=none; b=aJdTHKLuDA5pcxMZrHVPVM5PYmK3Q6wQ1CbB4xoPVGRe5/py89KNs+am0apNP9cZAyJM+VKLzMbR/U4FX1hL/GOMcGL0MfK8qVd4EjmleMloA2LSJcODjsfYZgZx/3s4J5d1g0YqpwTHjA+zG3P3dvdU1jLtwX7RIXcAvd0N46I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039071; c=relaxed/simple;
	bh=Jnu8+HdD9Vt7ZdPOykOBikIDA2ZwhavNakN8ubRtSgg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Dkj77DD5/pzwWw49crUjRu9EKYCoHygFKuz7kBJlHxhRSRxTmU7w2K9z8iztCd2Zki23p7gvIdhz40TQRJvz4yenGKNjPytZgdj8VF/1CHvsQiLbfxMory0Y93yVPsjYNQI0k8/d76vDpx9NGJRzOHwNMBzfBKg8nViJ6GVoHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=ZtbJaRb6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="ZtbJaRb6"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e88b60121so3290127a91.3
        for <linux-i2c@vger.kernel.org>; Tue, 18 Aug 2026 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1787039070; x=1787643870; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jnu8+HdD9Vt7ZdPOykOBikIDA2ZwhavNakN8ubRtSgg=;
        b=ZtbJaRb6ifncFogcwcxdQOQXItUHfLFbWeZQ8GGylu4N9jTSw4UuZf5UOZVYkH7nNX
         /SWFL5YZzsvIB+TlG4tUxq3LI/sPYroEToYsTsp0FgcUm19qtTvypwuHpN+tNDqNYOB1
         ziD2kNfyeRIso1IQjLp1ivPBtvD1dhv+njwODiVZj9/+Tej4LFXY44eIgR9TATRMo/LA
         syyuQ9qzCU6rOsSBkKDR51A9ry+Bjo0A0HCoK+eJCr/8QGUIP3ZsMSgdG8ZfyUs9PbNI
         iroP77a3m3yJVX68F92r78Eq5o6Rc44zeeohz9Zntd3e0r0XcQNyOdTgHJkU7hQYJiYu
         X5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787039070; x=1787643870;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jnu8+HdD9Vt7ZdPOykOBikIDA2ZwhavNakN8ubRtSgg=;
        b=GMIG/g0zIo+1XdeWvusHF4LT0fILIY3A/aHl4oHV2UBVjpOKMc0eXOiv2NPQFkubFw
         Gh/RNvzwgOKZVe44lK56cXuwP8nbWMLknghRIp/XZdPyIpLWStIoMaWW87yYAkgyX0MK
         GaYzVw9ddfSePDyXi78FNv9B1OOLkzEjJ1FcVvaNyWAooxMwUpnAn+DSBvjpbTdT8ZYB
         llRZbkCJTQDFaTlM2G8IoTMjTYRrKJUpuvJh57YArai1aHvwcZgxGm1QdEy90XBvpwp4
         2iJ/J6ZlnPiY7jWLkK9f0J0dpsLop706Yjqm29fWdZ5d6lrp6fWUfKB4x+g1ffluJSdw
         BGCA==
X-Forwarded-Encrypted: i=1; AHgh+RoONgcMr/nufsvg1XVdmhmLwF9xrhj4RL1aLIO/8iWXrmGjOgVp+UpW7r/FmWnaSli9kFmjcDDsm4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YybNbsMDDiXcZpShJq5ACEyk/dMnSmykxS8mHswXVmKmooNpit7
	1SvGRLTaYhHtQTEEQ29wOhk7xgAjcz+Fu1jewvZagiHIBnxnmGxZl43jxg/I3UACjyc=
X-Gm-Gg: AR+sD11NVZcLfTTYmRzgGYVDbS4aPz3K93YmeRe24JIkQO2v1BS8JhpUZNOjky4z+Lt
	s5V0Oool2pLVP/5BnJHnMSXtWB6FfPkzQPLVrL0iHwJ3iniySp1wV5WxW1+4F8Eu+gF4ACVnTXy
	OMPfpeKLjzlANXjlmC+TPQIXo8t00YREX2IK0qkUdQoVW3mtc0f7zK1AZmyDIRY/vKSekg8ARM8
	BVAmkJEi19fbW1BM756/lj9eaU39nSJYqZiqa6WF7iDlZK6S3XTCyJ+LVPFUKQsWvpuLb9PCvV0
	aEoH4Cc65vLs/+LGXmVSOWxtq4LagSlpfptdEbgijgKiyQunXX2mIANvP6xOSrHroKmN4fFuvYU
	kZpSWC5QOYk2MsPKxXVcB0Ib+NSwORfX6tjdvdKygIfupgDpNyFTi1uPqbcpfFUmWBAmh4sqB+5
	+g0zYsV0BBHjrBysI+Qi5yNatraWiqPq80a1wY68vC68W9ftibi/zXFcy1bbqUatbLh9TYFRE=
X-Received: by 2002:a17:90b:2587:b0:38e:9045:bac0 with SMTP id 98e67ed59e1d1-3933b741419mr33538684a91.5.1787039069792;
        Tue, 18 Aug 2026 00:44:29 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bfa0sm5056965a91.10.2026.08.18.00.44.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 00:44:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 00:44:27 -0700
Message-Id: <DKRWHA3VO9S8.3QNFPU0732I1W@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] i2c: xiic: restore runtime PM teardown in remove to
 fix clk WARN flood
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andi Shyti" <andi.shyti@kernel.org>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260814-i2c-xiic-restore-runtime-pm-teardown-v2-1-7ae5d0c30ff2@nexthop.ai> <aoHf6UDxD68YxLYm@zenone.zhora.eu> <DKQN4CNOESWV.2XRL8DIC87HYA@nexthop.ai> <aoNdskB_y8mOj5qr@zenone.zhora.eu>
In-Reply-To: <aoNdskB_y8mOj5qr@zenone.zhora.eu>

On Mon Aug 17, 2026 at 12:20 PM PDT, Andi Shyti wrote:
> A solution would be to drop the managed runtime-PM helper and
> restore the non managed runtime PM setup and teardown. Otherwise,
> this ordering issue needs to be addressed in the runtime-PM/clock
> framework.
>
> Does that work?
>
> Andi

Agreed =E2=80=94 that's cleaner than special-casing the ordering. v3 drops
devm_pm_runtime_set_active_enabled() and restores the non-managed
setup/teardown.

Let me try it on hardware before sending v3.

Thanks for the feedback,
Abdurrahman
