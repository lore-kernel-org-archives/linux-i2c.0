Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AD22F531B;
	Tue, 14 Jul 2026 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038234; cv=none; b=Q+apva/cdPmiajfRyb9AbraEHqy0S/yc2g6s0pPheZgtv05dvnmzMvkjSCyyMBzRcNs2VC4ZaaoavobOkQrNBYcTEt2+7Ed1nSSTSmSUuxeSuRGeWHl1LPF6A3KomAO7jIuCy1j39zkHoKvFT4x2d7Zx6dQs9m9mqyUk9Lh1HIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038234; c=relaxed/simple;
	bh=ascMDR/Ps2MvuiSNYkmFcXEUA4EMf0q+f3hkluj3fBA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FlQpphJnQgX9RNm09Dt6VmU0gEivUGEHkUPgoOGcpy7Xwc0KAxBGmE/OXbd+8oaAtVAoDmx3YnvcbSqWQ0OTwC83UqzP/Jhz0inmg8hirg3iu38a69uXD4YjkaS5ukHgsdai8dR7Y8F78XXnL2cxthq09PzOW7ilIYm3EXu6MJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Cv2vXPpo; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Cv2vXPpo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784038223; x=1784643023; i=markus.elfring@web.de;
	bh=ascMDR/Ps2MvuiSNYkmFcXEUA4EMf0q+f3hkluj3fBA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Cv2vXPpol4JlKitNk3D0XeswKZOlTeNs+r7mkn1nYglxKAV/uzyvO9SYkemx3hNJ
	 z6XEDoIsQzKVFyKgnrb27u1g2wkq9HC+Ev3BBeQ2im19ImLGJmWcknsarvhL1O96P
	 BPwkD8wHQ/E1PbUA9+DeqyAO3fsUcviw1+M63q9FU12z/vXa4pvn6IvIuv2mpAVDP
	 pF09ujC5enBUpeNitcAAg+z/c2yCxCWUH+g7tf2EynGBiG6mVbups63EFmN7xEg6N
	 3icn296dkxpAU7D7ivQ6/O818tMZ+3LryrAXeR82JfC+Ucuy6rb/j9+osEdVmFx8p
	 jMJC0LMZSUdQu5AgZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbkWK-1xJXPt0oFa-00cBGP; Tue, 14
 Jul 2026 16:10:23 +0200
Message-ID: <f6284d81-75fa-4418-b4f6-531163bd02cb@web.de>
Date: Tue, 14 Jul 2026 16:10:20 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Carlos Song <carlos.song@nxp.com>, imx@lists.linux.de,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@pengutronix.de, Andi Shyti <andi.shyti@kernel.org>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260630105223.3687516-2-carlos.song@oss.nxp.com>
Subject: Re: [PATCH v5 1/2] i2c: imx-lpi2c: properly unwind resources on probe
 failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260630105223.3687516-2-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QjSzDH8dW/yLsPenC9/HgxeriAeQCWWMbDZuZGIPkWtsdo8kWa6
 fUozEQJeA3kzHeC877B5Y73BHvBu01OjyPsPnnmPcmmgz2OG+GLLJBtvw+ubhTvfeRLbASy
 dCS3G3frwd2qY+bcskMGWo3yqNGsrtpsNPmGEOIBp7Ky5wNhb7+QJk+AAqV5teL7MtMOXPK
 tlpYrsYXH0bpXaJRXV/kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nFtwprKICKw=;5bRlh8vrHduL7PoRahhVYl9s7xF
 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

=E2=80=A6
> Introduce a new error label 'clk_disable' =E2=80=A6

Can another bit of duplicate source code be avoided in any if branches?

Regards,
Markus
