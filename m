Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492054F7CA4
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014965; cv=none; b=riJnldV3lR09PDu6JNnyHrFabYEFJRAM5G3fRzWgQo8XSrXWU0H6Y7mKvDDtpVPcbhvAkgTZgE1tdGK1nJ4HPbEnUpqT06DHZmvNY8CMZcsFsx5jyov0ozUPclpNaefn/1XDVYrU7ms5BF29Mc4eUUpMJYDssHDRmjEmQVeS6L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014965; c=relaxed/simple;
	bh=bKF4UxZmhcKzpEWLoceM6baLWUfJGcTz+x2ADfuz0KY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XK4LAE+EJETxO6yDAxzEmyL70ytpt4dWNxrA6AjNmuiSIUnleeb8HUgGnFYsDe4KHJZf/J0RuKdWHQVC4piMhXZXYv+Du+S9xSIwxVm1uZkzF7caKATq5jf4XtVEUn2F3V2QD7xtdsOczAyPmH29YvXD6cEiYtaxct9EVfrVHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=dyIpUxRy; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="dyIpUxRy"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f20513so2763002b3a.0
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 11:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1790014964; x=1790619764; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SVCv1PgC81o7TRBD5ycHllg8hQY2X2u55UwafrfWrG0=;
        b=dyIpUxRy07p7/AMtF3vm6RPCm+6a3PKW4p5cQrwVT4i08dBe/FHiGetF2newCnbYRK
         DmWT6dIohzc+BuR9xnbYeRrR7eyjnmlT4KUsrgCNQjQ/dJzMICKvT+k9+ex7LfNnTLTB
         frxUAMMJHjtP6GIs5UFgW51CP05ZqDQ4AXDaSOWE0C9t4PdTdqu+TXym9Yf5Yzy7gmhe
         ZNzU0fwb87N2hTwUoRkmF3cegTxylT1r1DKS77LbTY5XvQ5Tp9KDFcmYiw80HVXpciE7
         LEJ+IlreykdB3nhaQwaadvxTp/1NEOBomiieli9C3pGJggV54UWtF6YzSNScNED0k+01
         2WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790014964; x=1790619764;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SVCv1PgC81o7TRBD5ycHllg8hQY2X2u55UwafrfWrG0=;
        b=COya4tsIySjMsJ14GD2Gh136ejksdfaqJyLolqVElF21zXSBRdCuXmZMsJHQerrC9x
         2hXkEaW2yzKJMqCuvnqk9rEy7g/jTdGcwDZj8CnvIbQy+idlyAKeLvhNefE7GEFxH1mE
         106mYOnzvaQCOFqlSD4kP4UbyVM9xGYkoWl/xb/UL+1mrxCGc2QxOCHCpQn+rO60WgzI
         A0bL6i/eZaOjTmdtkJtW+1h9NRKIBGRhSqkA42d3mXlXmhkM0T+XWh0lM9yDFoNSq65O
         Tc/aEoAqIm06crlUml3Zb99HqJtJZ4RLpoEz3CtWzeVbIZn1k7JCy5o5l+ipJrHRg8fm
         3hEQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWtsP90dy+SGwc1C3OubR7BXZHYQ8ElDGQT7Toxm7L4i8xgERvyPaJzSjIMsmFu9+hoxxxJwtW2rE=@vger.kernel.org
X-Gm-Message-State: AFuF++nU42OUtun9ZbRWE5ymT7jRyjwR9/wiWMyKtBkBDpT9Jg/mbKJF
	dLWb9wLET5ywcsQGNGzxfbFTngC9uhyruSwiUriw9vfp0xsndZGCzlicoi8cDxBdGIo=
X-Gm-Gg: AYBFou1IsaWFmBeb4U1gzyIuX+9WhNoPl4MbjrjoVt2I6wsYuDxeEgHMt6tu6DSbiyJ
	qeGOFC529ubw/81OVGeP5VtWu7pRMZigxICk3f0eSo91lZGXOs3YVqMkk8iWRSgGW+f9R0nqQ4/
	cq0dQ41HS0gQoebjwoaLa94EQL/11SAzBmew73Xu9wy/Uo3P8dmjoSxXTf88oEkx64IR9JD3Fcj
	lCUrLYSjeqvSH8jMV7BP2jkVpL9CT0TvAjVqBImfdiKVb504gN1VTQCdOZurRIP4cYnoMTx7dFB
	aeQwKAWCTGGw6k+hrZyNXvbM1DOhVX+XkCe3T1xqJGuWm+uvDF2vrGZE2Ai0M2J5vzmriUpEEQG
	PPqJpCmUIBSQyuL8metrEsPwBOrKYL3TkthUt7G83SgWYOgTTkvQjJIEdb+/KcWpMxJjmGygSTs
	j7o8BEUHxW0r1ZGS3tMxPqqwBbBjlLUwqqvheinnPh0i/ck0CKytKbdT+8z5mABdvan+rZL/A=
X-Received: by 2002:a05:6a21:7a96:b0:3dd:a00a:c5b6 with SMTP id adf61e73a8af0-3dda00ac6admr12914266637.41.1790014963608;
        Mon, 21 Sep 2026 11:22:43 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3318763bsm19075795eec.19.2026.09.21.11.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 11:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 11:22:41 -0700
Message-Id: <DLL7CH0T2EG3.82RGWEDCQXZ2@nexthop.ai>
Cc: "Michal Simek" <michal.simek@amd.com>, "Wolfram Sang"
 <wsa+renesas@sang-engineering.com>, "Shubhrajyoti Datta"
 <shubhrajyoti.datta@amd.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] i2c: xiic: preserve PEC byte length in SMBus
 block read setup
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andi Shyti" <andi.shyti@kernel.org>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.22.0
References: <20260909-i2c-xiic-v4-0-218df31e9d3b@nexthop.ai>
 <20260909-i2c-xiic-v4-1-218df31e9d3b@nexthop.ai>
 <arDgdyG0QsNerDH5@zenone.zhora.eu>
In-Reply-To: <arDgdyG0QsNerDH5@zenone.zhora.eu>

On Mon Sep 21, 2026 at 1:43 AM PDT, Andi Shyti wrote:
> Hi Abdurraham,
>
> ...
>
>>  		xiic_read_rx(i2c);
>>  		if (xiic_rx_space(i2c) =3D=3D 0) {
>> +			/*
>> +			 * If the setup path padded a short SMBus block read up
>> +			 * to SMBUS_BLOCK_READ_MIN_LEN for the HW exit
>> +			 * workaround, trim rx_msg->len back to the number of
>> +			 * bytes that are actually valid so the SMBus core's
>> +			 * PEC check reads the right index. Must happen before
>> +			 * the rx_msg =3D NULL below.
>> +			 */
>> +			if (i2c->rx_msg && i2c->smbus_actual_len)
>> +				i2c->rx_msg->len =3D i2c->smbus_actual_len;
>
> We do need to reset smbus_actual_len at every xiic_start_recv(),
> otherwise this would be true for every rx_msg. Right?
>
> Andi
>

Right. Patch 3 clears it in the BNB handler, but the ARB_LOST /
TX_ERROR branch goes straight to out: and never reaches it, so an
aborted block read leaves it set for the next receive.

v5 clears it in xiic_start_recv() and drops the now-redundant reset
from patch 3. Patch 2 unchanged.

v5 also tags all three with Fixes: e4c1ff772e1a and Cc: stable - one
commit introduced all three, and a PEC block read needs all three.

Abdurrahman
