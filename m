Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FC43612E7
	for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993497; cv=none; b=t6xO+fq/jIbFOA6MBBhYRVLfOsLSjAG6ydW7WHQdOYV4DRG8fnrO9GHn5OyGYbV7r2vYUCTJxA8lLU2lzAs04s0eyBNADoRDqA4TVGCbOA2zI0ho39heJnR5p4BE/rIEoqirSupjL5mciBlBSGEPbqP5f/FNOGCBmOruoGPuUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993497; c=relaxed/simple;
	bh=9eDed6TPehI0qw7uXAXp2VHk1yY3TdAoNKukjEeQP4U=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=lsCzJuVMDBWs0ohLVnwQDFF2fSJtuxdCi7ouPDcyhAAZ7sQDXdW9sImKQWndeI4uvj5ijM19jnU7Mzlap9AncY6f5RWbDU2sH1/nU4caJk7oqxj94cIBlXr83nj0CcFDS1k8vixumXkTHq98mR4O7dofoEQQjGvWnbZYNOrgwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ESQtkPJh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ESQtkPJh"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b97ed4ad579so55153966b.3
        for <linux-i2c@vger.kernel.org>; Fri, 20 Mar 2026 00:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1773993490; x=1774598290; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eDed6TPehI0qw7uXAXp2VHk1yY3TdAoNKukjEeQP4U=;
        b=ESQtkPJhQT4pk5U+DgbtjMfLeXxvR8M/HtCVxCfaZkx7k8Pw4S9z9NISRDUgrmjCXi
         VGx6CkgW+ME4yG8v8tpYhH8KGqhZg0B84OVm1drfOZS6X+L/CKSlTsBHL2c7jlttwMGZ
         W5UZy8SObvq/NGmZBm1+d9R1pp+e2JmUEmpLCuX4u2UuNIONJecDj6QAGiCTwceBiQEZ
         eqISmnRFmuaj3YWLGK8UTL4ingazOqdjkeg4wmd6QSxSgSKHooSLfDbRxYOrL7KjPE7p
         cqso/AAH8aVjVmFoH9/LkbycXymfKWCIpeh6MQdtmdWWQjqy4WDGKAN4j88KSSJFLpWL
         WGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773993490; x=1774598290;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9eDed6TPehI0qw7uXAXp2VHk1yY3TdAoNKukjEeQP4U=;
        b=E/DB7ooXS3zVog+v2L46VbFWjwM29Y4vjdWD4CgWUeMiLuh0e5bS/x09FUQl9GNgla
         AiKUp3OTd/q9jWCMKGyp8Kx6w2lHcVIRJSVyY/Nj/aQDIirS1XctTcMQSvliugseMHvt
         O9B6ulav+59UKcmdquO0jR0n2gdoTTZUKx2IueydFwYXTSUXexj41g6qcr0aQyiGgmlI
         yw5SHoL9bBxYJQIwH2SEmAJMJZwExT8HsMpsMJ42b+iaVSRU8aegpfn0tc7XVxEpOIrm
         TKtjNOjOJAqZfG4x2Gz2ndvx/KbD5t6XGx5XirdGQu1oV21cdYCH42kDe4mQ8FHSbyB6
         TFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWojEooFcQx+yilgH4EkEjuFU4hJskjESiLKBLaY2DCLYqU881B9sl/xANFJeIHPVUHQZQtlUZLAIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgXjfDg1CINqJUB8VjKpLIMtPgIu3zf43SxjZXITRJ9xKxNrV3
	EVfnlRD77aKuejsqwYjx6Pslm+DctxqD0EXIPdQQXEE4+2P7N9EgvOWhdoTYdXqs1iQ=
X-Gm-Gg: ATEYQzzlc76jsW3jai304zKoSGAitOmJKwoDgHqelACeMjzgYxzquhh+765i+FVWLFN
	ZY/BLJlE4CGW2+cu97aqwOB9MrIhGMcKrZkVBofXLpkTBzvt1Htaz2EqmqvKpEohGFCebT6BcK1
	nh2TKo7bE1u1mqhp/Qt28+rq/WNJV9JrjHeqjkMk3M1ldMYL3e5MyAWq1IwD9FQM+w4dCo/Ep9g
	dPlGuRJN2sndpKqU+3HKnXmDesmpOMHjt+EGcKIv4AwqK1Wcl63ka4dqven1l4HzuLpVVIQBRdk
	gWUbawtK90udXMXJIGXsR06kazNiWbzVUgRCxiAIkbGoWCEWZhxrgB+nHiJU9lrxL3BIzLQRJe/
	hxfc/2m6Sqk+A6V8ePb33qv9NTpJfGOh0LmyhcplDPY9+kE0tj/PbJtsEkR/B9K8Q8r3enJSLlR
	RD+Q3LOKzwHWZ0vDR1n5sXYkBizEMRS5XDd4J78Ezyx0kNXBVEj4T7tSUGwLWzxmhDgCo9
X-Received: by 2002:a17:907:6b8e:b0:b97:b6ef:fc8c with SMTP id a640c23a62f3a-b982f25c0e0mr131299366b.23.1773993489994;
        Fri, 20 Mar 2026 00:58:09 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b983365dbe4sm118826266b.47.2026.03.20.00.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 00:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 08:58:08 +0100
Message-Id: <DH7G7HV3PUXB.16AVBPYQDC5RD@fairphone.com>
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>
Cc: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Bartosz Golaszewski"
 <brgl@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Loic Poulain"
 <loic.poulain@oss.qualcomm.com>, "Robert Foss" <rfoss@kernel.org>, "Andi
 Shyti" <andi.shyti@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>,
 "Konrad Dybcio" <konradybcio@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: i2c: qcom-cci: Document Milos
 compatible
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260116-milos-cci-v1-0-28e01128da9c@fairphone.com>
 <20260116-milos-cci-v1-2-28e01128da9c@fairphone.com>
 <20260117-obedient-galago-from-eldorado-8e0ba4@quoll>
 <cb2430f2-8601-4c72-af6b-10f1ff16c188@oss.qualcomm.com>
 <DGDV2EMXHDS3.2377AQBNDDHAV@fairphone.com>
 <DH1LC0C4QD0Y.1XKV1PWFCBQRN@fairphone.com>
 <jexys4ypbizesa3whuvtq36t6hpqm4httlbwtzkulz5pld4yul@lf3joaistvfb>
 <DH41T22PJEW9.3EO3P50QRXG8H@fairphone.com>
 <7d3f650e-38f3-44e3-bd70-319a16d142a1@kernel.org>
In-Reply-To: <7d3f650e-38f3-44e3-bd70-319a16d142a1@kernel.org>

On Thu Mar 19, 2026 at 5:58 PM CET, Krzysztof Kozlowski wrote:
> On 16/03/2026 09:03, Luca Weiss wrote:
>>>
>>> I went on and checked. No Milos's soc_ahb !=3D camnoc_axi. They serve
>>> different purposes.
>>=20
>> Thanks Dmitry, appreciate it!
>>=20
>> @Krzysztof: Could you take another look at the binding then please?
>
> It is two months old patch, so for sure you need to resend it, but I
> gave my tag now.

Your concern was addressed in a reply in this thread, so I thought I'd
ask for your R-b here, instead of sending another revision where you may
not feel like your concerns have been addressed.

Neither option feels perfect.

Regards
Luca

>
> Best regards,
> Krzysztof

