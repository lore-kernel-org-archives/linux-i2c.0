Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7AA3403EF;
	Sat, 22 Aug 2026 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787403939; cv=none; b=OkJBzIUzP3yxMoXDPI3j3DVTvGA3cfc2rI5qUFc6PoPfwKnlnvFwTwaXAIOAsel7QqwllpmY2hF94L6UfK5QqqcC5GL8ZhS3QqkDJRk/qmiIXV/E9HiM3KKZoe5ykpZeDPi7bRJPz1vL5O+ytc/FsgmS60JMRvf5//U4fiVqR6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787403939; c=relaxed/simple;
	bh=qgGdpjzDlQMAFFGA7aUwRJXu4HCmOXehC+erPj/2k4k=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hR3VPldhyo2WecNKy+pLurMUbLz+OSJpQAtIbTdqk88IGpJdZyQJKCF2nJJF9MXsrOrbESSOnFJIh5jAT1bENFzd3M7pM/FWuAuF65q3hd/VR2ilLoTUkb78YQv2rq/jYdVnv5XSYNXvMgnzWIReY0w63J/R80a8zs4NOzUJ5HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dqyn+1R/; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dqyn+1R/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787403929; x=1788008729; i=markus.elfring@web.de;
	bh=qgGdpjzDlQMAFFGA7aUwRJXu4HCmOXehC+erPj/2k4k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dqyn+1R/y3GYlaoiRfPzz2VJtnUVHFM/0JxWtR7NEgiX2PQszvmJa+a0C5krPVzb
	 S0KxfZEiePgb1+yum6tIa9H8lnzGOJcu4hKbrOAkOyqSXZ2Bk/ZhPgdfIo3yfO9Z6
	 FLe5yBC2E3XscMF5jS/ABTG78apbLtPhkCrEQI9NarY74S1lLotiDEihWiEYkmDs9
	 Z9D/WNPZetkf1oiD8wq64uk25OH71wv2BFi6cppkTP9Cno8944K0b9HBwpG9RW/Qh
	 dOuGZFIHMRIkHDzYnZ74RM/8Vkkn5fcihhQHpA8e12NizSDoMQSNdP3MQJs7t/J7H
	 elrqkZdUEmBQp9X4cg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MALeD-1x4fAp3P7j-00FcGy; Sat, 22
 Aug 2026 15:05:28 +0200
Message-ID: <7ca1914c-8f32-499c-8121-4205044e330c@web.de>
Date: Sat, 22 Aug 2026 15:05:18 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Rosen Penev <rosenp@gmail.com>, linux-i2c@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Shyti <andi.shyti@kernel.org>
References: <20260821230217.319418-2-rosenp@gmail.com>
Subject: Re: [PATCH 1/3] i2c: ibm_iic: ioremap with platform pointer
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260821230217.319418-2-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8AUxcyImoDVmfkYBwcHUv3DQ8x5/H1iuYd6NeVGllwRpNhuVwWS
 57O2OJKDWDvl8pUrZC+5oh/iYe21AfWgKB8gctqL1lP6kJnr5Cl8rlzAHlU+yUaxERl9FAa
 LzmPTlYUk3j95zdiYnf0J+Q95HmyB9R3yFcqf8Mu1EZRIGLgMqlTqwrS+kfqTNXLUjk8XH5
 yMz8gmvZnnh3ocN19NFEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m+aImcSQUB8=;ZncRoRkCDKvFBs6w4XfeB2mfPi/
 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

> devm_platform_ioremap_resource only needs a platform_device pointer and
> calling it early allows handling potential -EPROBE_DEFER.

I find the change description improvable.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v7.2#n94

Regards,
Markus
