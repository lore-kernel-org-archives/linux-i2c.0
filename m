Received: from carlos3.mail.rambler.ru (carlos3.mail.rambler.ru [81.19.78.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C363B14D1
	for <linux-i2c@vger.kernel.org>; Sun, 30 Aug 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.78.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788104366; cv=none; b=fEk3kp5ETq3OLGIlGv5sjPC4LYkVP6NDH/QfL0PLaKE/m/emMnvai8KYbHidQgTS6JWft/rFyxS0OrMxDxj/KpOGZteFS8LwVZPSpehXziA+nAPzYLJ1TkLfqMDWqj/+7Ix2x7XRuNjuAVvj8O8e7WlLRBe9NLLWpcd9pRMp+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788104366; c=relaxed/simple;
	bh=/eLp2D/9KqQGuvLpdmbyse0f3WS3oaaTB8NNSyshqd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtFP8qDqPxolZvXBw+WTHLVCKDr9CyLeuxzaCU6jcDbuDKINJVkBNcGa6G4QdhgleuPzI+op3UuQlRuN4/exdTYt3T33UTAiR12mRVf7T0DGng7zJ5LpTQzUhz8+4Wk+BxbwD9vS75RhtSp+Bv+73xTiCgbQNVyBQDg2//0Aa6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ro.ru; spf=pass smtp.mailfrom=ro.ru; arc=none smtp.client-ip=81.19.78.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ro.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ro.ru
Received: from localhost (localhost [127.0.0.1])
	(Authenticated sender: alma0@ro.ru)
	by carlos3.mail.rambler.ru (Postfix) with ESMTPA id 66BC3CFDCF1;
	Sun, 30 Aug 2026 18:35:58 +0300 (MSK)
Message-ID: <812847a5-5630-4d26-8012-c816e6d1db32@ro.ru>
Date: Sun, 30 Aug 2026 17:35:57 +0200
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_ee1004=3A_DDR4_SPD_cannot_be_read=2C_decode-dimms_f?=
 =?UTF-8?B?YWlscywg4oCcRmFpbGVkIHRvIHNlbGVjdCBwYWdlIDAgKC02KeKAnQ==?=
To: Jean Delvare <jdelvare@suse.de>, 1110749@bugs.debian.org
Cc: linux-i2c@vger.kernel.org
References: <ff6982d3-cf60-436b-9107-420924cdabe3@ro.ru>
 <handler.1110749.B.1754853823932687.ack@bugs.debian.org>
 <9ed6f717-a04c-425f-945e-7fe8fe3b5d7d@ro.ru>
 <ac700b24578663492aecd6d544bfc205b060c948.camel@suse.de>
Content-Language: en-US
From: Al Ma <AlMa0@ro.ru>
In-Reply-To: <ac700b24578663492aecd6d544bfc205b060c948.camel@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> if you installed your memory modules following the recommended order

According to page 1-5 of my motherboard manual, dated 2019-10-28, the slots DIMM_A1 and DIMM_C1 should be used when installing two modules (and indeed, they are used as per `dmidecode -t memory` and from what I recall).

> Please try unloading the ee1004 driver, then running i2cdetect again.

Here we go:

# modprobe -r ee1004 && i2cdetect -y 0 && modprobe ee1004
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         08 -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- 56 -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --

What next?
