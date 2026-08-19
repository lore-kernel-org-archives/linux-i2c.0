Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A2400961;
	Wed, 19 Aug 2026 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127416; cv=none; b=G8x3ozjj+EFmzuywwsxMTiUMa2V8b5nmO9t9eBLkm97Vv2nq0aBJpkOAM5gmZlwFXIWJHXnvmq0ndn5a8Mo46FdTnMzU9d+VsSpXfmKSHpmfcDu3VANLTUjCUIVOjdfRQ4hmj0liXgc95W5s1ue8oAPDU4qAFq2+i1PbWZqwCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127416; c=relaxed/simple;
	bh=EBmbWwZxp0OaNetwArjuJsJ+InRY6P6uLODn/oIfbd4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Bv8UWz7OR1QoUZv+0+9QEnGGVjxqYIyG3+tRnBaFa/E+ZdrdvToGdz89B73ah+b3/WowbcCWRfeke/XZVwnteroRtRgcUBUtC7niB9T30peqhknozYh7h1fz3LX4RLHNgBlsumBc/XOTpMiv10S90fHtlf86qow/oi2NR2W8+fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CUXm33A3; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CUXm33A3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787127394; x=1787732194; i=markus.elfring@web.de;
	bh=pNS2tgc8c6KlY4XHUGMTvJmf/zZq7QBLyLKdanUr7d0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CUXm33A3/+Okno1Y9khEjaulIoLU9Xme7t41OM8dVMDRYOLikf67GBtnKdoO80Ka
	 CUpvo8CukzNMMB+P3xBm3Lx6aARkTe+oUhbhWDDQbgGhxiRetpIVvZnA9hNeaNMTv
	 bhaGg0Si7VRVWPlvJ0f2ZrwiP/wSp4OuGEe04m1RpRoBlxDKmHLUC6vCDlauldtAN
	 Bn7h7X7Emjp64Xl5MNtZQQuTonGF+WX7djiTU0s+5fcUcOjPGzj2kjY/vSK3x+g8Q
	 g7jods5SP13Uhbzq0fyNCxJDWp4zLA7nRrLruRmmAL74th+HYXLziPh4sqWR7yQwO
	 R34OabGniKHIlTMDsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3Eut-1wxQxL2KBZ-008VE3; Wed, 19
 Aug 2026 10:16:34 +0200
Message-ID: <40e4c72e-5bc2-4663-b39e-bf6f140c0d54@web.de>
Date: Wed, 19 Aug 2026 10:16:32 +0200
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
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260818124737.64478-1-triet.hoang.dev@gmail.com>
Subject: Re: [PATCH] i2c: cp2615: Validate read length before copying
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260818124737.64478-1-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5xrb77ey9D6eTQmIxIpqrGwaYYcOZQK3xluBX3BHMPnnKAafboz
 AQrKtFVDMZe6vpJInRmhr4njzzvru6c+vVQfkL1de+E8tpnL3HzA46eigZPH8Lyl17vOreC
 lWLR7t8O8DLNvr8fdtDLqlIURQYC3eOPWjf2eKFUWdU7/R5ZOx/tgTqh6vmgmHvsO9Rb5Yh
 fSiQxBL4KqmjxvpLt6pkg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cddIBRwhNnc=;SXW/3p9Jfg4DkB7eGI+0B6+5+xy
 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
 K2Q5wCw==

=E2=80=A6
> Limit read_len to the maximum size of the response buffer and return
> -EPROTO for an invalid response.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv7.2#n145
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34

* Please avoid duplicate source code also for improved implementations of
  functions like cp2615_i2c_recv().
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?h=3Dv7.2#n526
  https://elixir.bootlin.com/linux/v7.2/source/drivers/i2c/busses/i2c-cp26=
15.c#L138-L169

* How do you think about to increase the application of scope-based resour=
ce management?


Regards,
Markus
