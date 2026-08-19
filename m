Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E33D1707;
	Wed, 19 Aug 2026 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787120934; cv=none; b=PaeMjj1S7XsvZhPCkgGVtK9Y7EBcyFmrflacMbHf04qj3mJxwgVMMVEKKezTPFenmajArvOoB3j4vjO/iU94ZLOZwy8vZV/CVWv7MVgnED4KT4ZbPQA1e/S1Xiw4mFeoxL6oLBzKzFOnxyVSw+zWYZ7lDnOqHIbW37tz990/gZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787120934; c=relaxed/simple;
	bh=npUVSlerDKG4ukkjgAJoXr1rRJgYaIwfsYrJ6MfjfHY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=HoPddmV97kIOtL24TjpV1ippJkdDRh6nDbmDJxKxnEESH3/3Q9Bsn52FIQZnCr3toS8tuYRHEvhYGPgMtm3X8i3zv6p/eM9Uq+pMkylkiqlpIAYdlBVSge4dRdz+jLCC3CGcO0feDSdbPKZzpCywZYAkHnc592cQBooRlEFjm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=eU9dop0x; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="eU9dop0x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787120929; x=1787725729; i=markus.elfring@web.de;
	bh=vet7OPT6PwHQuiVQi7BpcuBWcyhZSUi1bVwc9DzIF8U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eU9dop0xI1exodKBfuhuWPejlXY6keUgmncNrzwNsIw7oEgawIYrK4/KrjLsV6je
	 5CcddRfZID5KTuu4Pb7Bml02gzfKphI2fgu7ytfVYv7mhDt+S9O6nNBICfwu+2ogl
	 +0m+Euh3W+/IlmEWSTGVAfyxqqLAuyVt6ju8wdIy3TljX/zw0meKiDpdP3dqV0qfG
	 MiLU4JvAtyERj5DTWgDNKJmDocrCW1c4iBGFbMQ141yvP9odZz1c/DYes7ycmJ1Y7
	 ++ov6YbhUBH2pdKGStUVzhzwhoUfVUW8FPev80Livc4T4qV1gyykYJTwjnxmT6bwV
	 vWzIE+tpiTi7/93hvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUl9H-1xMfFR44ED-00XAiV; Wed, 19
 Aug 2026 08:28:49 +0200
Message-ID: <cb4985df-edec-442e-8882-060a3c2e18bc@web.de>
Date: Wed, 19 Aug 2026 08:28:47 +0200
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
References: <20260818111703.19604-1-triet.hoang.dev@gmail.com>
Subject: Re: [PATCH v2] i2c: cp2615: handle allocation failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260818111703.19604-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ATvA+ob1Vzq7b/dS5iclVZBpQpDwIl+/9yWOJAvVjqyu8eisjGx
 d6xvgHbjm2B5B9ge6gZc8nJF4urw8FyireROjcyFlogjzZ8Z/66FhXlD83F90JLocrAXKgQ
 pcweE3inaV8MiO8u3qs/zWksaMpXYMEQhPqYjEa3wQ1w+E3KIWCPayRwEX3oMMBavIAZOG8
 H5sVCTEssaaV9zNNdop7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:28GX/dSkg2Q=;MriOxvGVmjh++oewTf0ME6q8oPs
 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
 IVavWFQ==

> Check the result of kzalloc_obj() and return -ENOMEM
> when the allocation fails instead of passing a NULL pointer
> to the message initialization helpers, which would return -EINVAL.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2#n145
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34

* How do you think about to increase the application of scope-based resour=
ce management?


Regards,
Markus
