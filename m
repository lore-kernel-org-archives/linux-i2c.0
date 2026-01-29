Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1DF2882B4;
	Thu, 29 Jan 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680899; cv=none; b=XFcYtnWvnaUW84rXFQF0uSdNAQzcaQFeGW1JTOVNH8ICarZG6ScyoLdHgpjRJRaLTuhwn78WS8/1mUqbv1QWTzeAVqqseCjG8t6ja4VXbeOIlntR83PMfaEDMu5iVPC3+DvB9ykhy3r81dfXd0JPDlm+BqPLskEE/M9th6WK044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680899; c=relaxed/simple;
	bh=cg2tCmL1MnK8fEfGufJK/74nLuLeP7KQQPFGzywbCWk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HLbGAH0hRUfCK3Oa0kyN5ink0tFxZTd4WfBV+cH65bBTo13PdiDFqeBLJtxDi+Tyxcpd8NXeJ5t9/22/whw1vGKN0AZSwMGlCfLLr6jQChcik7ehEsoJ7V+sdUvedN71DC52qwj0v/8cB7u/ak+6+0JdxlqusO3uPmp1/FXe2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=vuYThn8U; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="vuYThn8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1769680734;
	bh=kSD46m1ogNc6zC/u0ZXCX57K0B/t6fYmWXp2hGNifYg=;
	h=Mime-Version:Date:Message-Id:Subject:From:To;
	b=vuYThn8U74BN0Yu/AvpQUIhw2sjpSDauoYx47je587NroJVJ1KMemGuf6sgerOqT3
	 gLcCg6YCGb27FBP+rj1VFtSXIxsiosv+Sh7FVHCfQ0gnYGYLLKku8NT/xi0F2qcO0E
	 mHZsOq5HGe2rkvQnMJS7WyRN1VgkQ4r8VdZE51fQ=
X-QQ-mid: esmtpsz19t1769680725tf47f9eb6
X-QQ-Originating-IP: NwNr+iF54gvctsdaQA7HUEs9uDmvl39kJiwn0igpLYg=
Received: from = ( [183.48.244.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 29 Jan 2026 17:58:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11216958157623042392
EX-QQ-RecipientCnt: 11
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Jan 2026 17:58:43 +0800
Message-Id: <DG0ZGKX13IY6.3798PMYUYKW8P@linux.spacemit.com>
Cc: "Andi Shyti" <andi.shyti@kernel.org>, "Yixun Lan" <dlan@gentoo.org>,
 "Alex Elder" <elder@riscstar.com>, "Michael Opdenacker"
 <michael.opdenacker@rootcommit.com>, "Troy Mitchell"
 <troymitchell988@gmail.com>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <spacemit@lists.linux.dev>
Subject: Re: [PATCH v6 0/2] i2c: spacemit: introduce pio for k1
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Aurelien Jarno" <aurelien@aurel32.net>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260108-k1-i2c-atomic-v6-0-41b132b70f68@linux.spacemit.com>
 <aXlBe1CHq_HbbpCR@aurel32.net>
In-Reply-To: <aXlBe1CHq_HbbpCR@aurel32.net>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NkXVHN8YrGFczZQ7FM3RkHP7vr+sTE0CKkTDV9CnTExoPslZtViOeYer
	w56BNkalZLAOO98MhR4uno5JcjbJ90IF0lzl/sKKQvKZPj1RTEc5zOAhaOi6W4rh2jXtKf4
	IxeW5+1FJ3bOXwsVRSGvaUsk7md+M1WhcTqZ7RwXimQD3cIg2Aic20RzZpMXxed4YfNkho5
	FDTMkIW9M1kfFLTlUXi3PSAwOSdUcjf2CMeZ8d4pZrxZxNOKlFxEhv9lV2xfXZcEpyr1TkB
	fJI4Z7q4TFj+PbOyYJYh7pDrqIPK3SvhBuoskq70SnlJfjtDjgGslr5D8y9+di0yGkXw3Z9
	tCQcTyY2igy7s7Iu91f0BBC8LscpzudT2gRzd9BIxFUmjV0eUzPddLGTnC7mH/RYvw531q7
	mnteJwmIosekp4PN7bWX59IjALmcWCvGGGAA5nR0c1Od5I94jW2mmin5iYbgYLMKHWiM09e
	yrw1BfD5o9+TUkXbe5a5dLeGzFQGtmwrcdA3nh5IR/85x1m80jXBjC1/t8OePAWb8N3ofFJ
	+A/I+J1++qW4y5v+vFsIQ2QLXq67eKsoqJ0iRq0cXHty6XCnpjSSx7yYNXTaadIF55/Wz5e
	A1WCK1qA9z+lUdmo6Ix74lzrCkr4UNHXoeUUblBboKvy9Qib9/GKz615VL+fcIYuoRu551T
	6uXchD7Li14LXmLn6OyT8n4jQHR60OPZAkyW8pjJW+KuJzkb2qb/o5hO2mfSdKo5NO1kZnA
	1+vjLEEyXmJgXSUzMlqQiuQyXisFdnRQpoaGDpdGEdy7TxpBf663WoLFU72lb+/xpcvQqoy
	hN3J+el5WhUHIsLoTJOmmLNKr9abvvh9Nx+gG/1m7Z9UhxP8I9xxhcr4pi8gP1+yDpsZm/h
	iQDQRWMUIylKK5eiWaSvT26pZ73/RPexYCoaAdKtVhpx9+hFwR7jKVxXwZnWFORB1KQj5SS
	70irZrJtozX2H3djB1nQnQ1PN4EpDcadqb3zaGRcM5YzvvV3QJn0rZ3DKAh6/spQflspO1k
	436fGMA6nZj18btAQKtHZJ43RaLgy4gZJHW2FQQ+VFZUNRyCvrs+2vQj/V3nqCTwD/gu2dR
	FyaIzzkq/R8
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

On Wed Jan 28, 2026 at 6:51 AM CST, Aurelien Jarno wrote:
> Hi Troy,
>
> On 2026-01-08 15:52, Troy Mitchell wrote:
>> This patch introduces I2C PIO functionality for the Spacemit K1 SoC,
>> enabling the use of I2C in atomic context.
>>=20
>> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>> ---
>> Troy Mitchell (2):
>>       i2c: spacemit: move i2c_xfer_msg()
>>       i2c: spacemit: introduce pio for k1
>>=20
>>  drivers/i2c/busses/i2c-k1.c | 314 +++++++++++++++++++++++++++++++++----=
-------
>>  1 file changed, 237 insertions(+), 77 deletions(-)
>> ---
>> base-commit: 003e84792ce811256114dee4f4ecc1cafdab2b0d
>> change-id: 20250814-k1-i2c-atomic-f1a90cd34364
>
> This patch series got a few comments. Do you need help to address them=20
> and send a new one?
No. I'll address them ASAP.
Thanks!

                                  - Troy
>
> Thanks
> Aurelien

