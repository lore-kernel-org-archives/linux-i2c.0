Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6879382F2F;
	Sun,  6 Sep 2026 18:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718452; cv=none; b=rNOR9KLzsXpq0lpnLRMVV+yqaT/l4O6qfQdbfmIzABzNljm/7qlB93e1KilRkg2e5Sepkpd8NFxpaAA2fka9HZrNUNF+JxP+x2hAt6KOOSqipMtIs8zMtZe827awU0buHdwwMWMo5OJYJQrcayhWNKDaIJ+/I10O1vwDmH/N31k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718452; c=relaxed/simple;
	bh=LrRMvtXobA1UG3UvX8m6g0GQk9yOqa44SDT2aZC65bQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=PZJRM6pKv+mAJ0J2PQFEVrkHezKs9/qeL5xD+RXvGD69ILt9b+V3mYQxBfNeZbOHWOs2PP5KPRczk7DfsjAdTIuOzyEEXRgQ2s05OH04I/LCNNhZZNqsf/cxtmZsWOH4QuRByM3jd9FbxHx5gwGCqlgFFYWmoo7rs4C5mEWEqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KCSF3QKf; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KCSF3QKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1788718447; x=1789323247; i=markus.elfring@web.de;
	bh=4PPlHudsVqMgHu+jqtagfs3lPGllieImlGPRjfdCNgg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KCSF3QKf3+1taudGfRpIgW+QpwwlWNXL/OnReh4ydPkuCzn0fLmf2BY7qBGck0fs
	 SS+MxidIWoklTn8DMTm2BYBW4IRJSEEmcq6B6eAgi38XJ2XGdDWdcpPvbz0L3CeRB
	 2UmEPYB1/ueW0/UFAa6Cs40zsf8rLoulyqmrZ0yDbNhaBwuFJWIFf7tB9r0ZXbgsf
	 yGosQFkccKo/pbGHimEOHBHWtlKJLcp5mbOlSpc6S8TGlqDLlR8YviSMfcNgJrPPg
	 A0NC+ORKQJ1xN6M9EyBnQUdP/R1Mvx5b1KslNthlLU3FpMTsEqJ2dsyq7/fMH5Pld
	 oPIawqc9y7OOSFW8lg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuSe-1wOSm62vmW-00p3il; Sun, 06
 Sep 2026 20:00:34 +0200
Message-ID: <8b833de6-0e16-4aa7-a9d2-ca9985a6fc24@web.de>
Date: Sun, 6 Sep 2026 20:00:33 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Triet Hoang <triet.hoang.dev@gmail.com>, linux-i2c@vger.kernel.org,
 Andi Shyti <andi.shyti@kernel.org>, =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?=
 <bence98@sch.bme.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260829042207.27323-1-triet.hoang.dev@gmail.com>
Subject: Re: [PATCH v3] i2c: cp2615: handle allocation failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260829042207.27323-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MkA7bxI1W2XgqtzHngkGVou/9MSTQmy7cWFx23LANVHCPxCaQFX
 MYecVt//kFGINIv9uL41nXnzVJ4AQsNyuuXXTf6K6ZymTncWc9Un5nQ7+KEhFkH9uWNMIaA
 s0mDUFWurwn0fytg1zsiaUVo3q6zikeYixzgfZ0M/NnQDsWHH1Ws6HCYcwn0WvCLYgil0f8
 OPvXAE9dLWpdUIm/RHjBQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zZ3IsMERSjE=;SlU5Iv6jH3XSccvIITtVFlYXQwb
 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

> Check the result of kzalloc_obj() and return -ENOMEM
> when the allocation fails instead of passing a NULL pointer
> to the message initialization helpers, which would return -EINVAL.
>=20
> Also separate kzalloc_obj() calls from variable declarations.

* Can such a source code adjustment relieve further development concerns?
  https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-stan=
dard/rules/expressions-exp/exp34-c/

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.3-rc1#n198
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.3-rc1#n3

* How do you think about to increase the application of scope-based resour=
ce management?


Regards,
Markus
