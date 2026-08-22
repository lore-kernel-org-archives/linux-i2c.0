Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060791F5834;
	Sat, 22 Aug 2026 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787404382; cv=none; b=YtX9u95Gekg7WWA5yKG11cXMWBtN3aIxV6KSiKYpue99oYvHwcUtzoFZdx084k1ShP2A0a4TfCnFky3VV69v5eWCkE7qPNZUBIW3V3avedZ9DUeTcgetUrOExxGHtgcurRpZ9m5oOA/q7EVgA6d2TwJ87gzEkEpDLCnuD9bbpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787404382; c=relaxed/simple;
	bh=TXaSHPBu9/dRXp+Uj71jYVPtqHZo1/Bbl8pL/ImvVl0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cJYUeqdVKXb2muuwlhRXhpSADvNum5rF75t1dj/8CU4sseKxzDUD+0LRYabqJ51m1ukkhBb1156MRLClFByVErYU9zE4G11wFuCahL6fgobbFA19BMI0gBcnP8g2rxkUiPBvGeSr8bM95onOXQZVFfbierhDsjrmaikpDdDc99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rZXKbNFq; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rZXKbNFq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787404372; x=1788009172; i=markus.elfring@web.de;
	bh=TXaSHPBu9/dRXp+Uj71jYVPtqHZo1/Bbl8pL/ImvVl0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rZXKbNFqFiZrHDM2U4qftgRV7x/GFAQX8HlR/b6qIshpjQii+yQzr54H4LUr21pw
	 +RDy3hFxE2MtzruXOeVR4hMxrDjQ+hIBEUME8BLyq1Y3DyEPCbIdcsTFx9D9jcws0
	 bS33741tWJfhtmXtUn7rzIOWy8FYh1Kr2r2UfVmbzKwFT6SNy+K4n7NeIpn0IMDlO
	 QXCD6feGUPxA9vcIr/Grd3oz756jo0R8hly+BkzvtTmDqiVDpWy+KieU8ZGEfE3ch
	 4pv8gFIED2kpnYUh+mCsRux/+h/eJNB/6jAHNeTnwnJbWzXDAMt5IKesNJ9/WS29Y
	 B7K7nUmZXT0hGwVXVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO5C-1wOQmB3NPk-00elg8; Sat, 22
 Aug 2026 15:12:51 +0200
Message-ID: <af0eb54b-f0ef-4304-ac3b-ef70359d4169@web.de>
Date: Sat, 22 Aug 2026 15:12:50 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Rosen Penev <rosenp@gmail.com>, linux-i2c@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
References: <20260821230217.319418-4-rosenp@gmail.com>
Subject: Re: [PATCH 3/3] i2c: ibm_iic: use devm for main allocation
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260821230217.319418-4-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9JLcRi/2YfKpSTuydO+x2gzTScR7N1ElcnCBBuxDM5RNtLGc153
 zOzvyM7OCTxsKybK+UrXzyzE7yuEDPxVLwLT/FZUsZySzfmbawmYR595hwgX/n8zRY0JNRU
 s9V5OxyjRwzAqnnXmwnXFysmTekTKbyyuas727oTiDNI+LCZ+qPHyzZPw6bsGLdHzVhCKKm
 159yUixzgszTcfHekiu2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iC/jUObiC0I=;IcoDc5cnokvsQqSRXc3AU1XiKLQ
 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

> Allows getting rid of kfree in failure and remove paths.

Will another improved change description become more desirable?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.2#n94

Regards,
Markus
