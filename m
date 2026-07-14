Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780C319A288
	for <linux-i2c@vger.kernel.org>; Tue, 14 Jul 2026 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783989181; cv=none; b=dcATD6Q6wIbWYpzeH/1HDbm/sZ4/FZ/x3X8VhFyzI+9cOJHOZaNoiP/Gz6gP9Yx/9AdwVBKTJgTkkn//HIczULGB+N4Aa+hGTr396Uk6aOo1HQOPBLQwlv209atWqmq18qwY1vH0sKT/eVm8pN5H2hKRA41NS4kKzd7L9pDvhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783989181; c=relaxed/simple;
	bh=D7sgG5t4VAWsPS+3OEZSVq/ziRSt9Wxqgo9E+hRoh4M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=s4RhFwt4EdYGIGyz1FHKkGyBg9CSTHL17oHbGxQRxGe0fvBviV+UphXJGlC640qPrHYAN7dQr9ZgBKwfJDRQdQ5sSXGs0edZ3rKQJEk47qXElbjnsw5OKWg3QRjBRadGXJBHkmCipsS5EeuZMdKynkqx27QtlcyZG5a3Y3j6x0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=k9/SDaNI; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="k9/SDaNI"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso2471801a12.2
        for <linux-i2c@vger.kernel.org>; Mon, 13 Jul 2026 17:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1783989178; x=1784593978; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D7sgG5t4VAWsPS+3OEZSVq/ziRSt9Wxqgo9E+hRoh4M=;
        b=k9/SDaNItnmMkaIrSp2Xx3xUZCtXViiU8YfK5zoQfmrdeLUnVAFidR7RTP4hOJSU9O
         IHAgMbfbL/S6BWejLpZ6TLbRscH5j9nreJjvCKF/bR7HocCuQm6mgKEwvzOaII+BHwOT
         ifc5smtfNFSaE34VU8skw7XUyrh59W9kjE5iN0VqazcekcsvuhYpgKmnxV6WD63tmvAD
         2m6SNMmhB9dDRepN4/z4gQFQjVtlsuPsery8M1iWFPNsZ5uEdx6dlCKgn4eXzGFfiNXV
         GIwpYirFo1kas4fogH0VqEuru4a84wdNAtiC2OszXk06zM+XVuvQeNhYw/jxbMx8cA+W
         7foA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783989178; x=1784593978;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D7sgG5t4VAWsPS+3OEZSVq/ziRSt9Wxqgo9E+hRoh4M=;
        b=FXpHUN3CjaW5lr+i0TAyLUqf0wYDADUV3pwrgbhyZfGfgqg10IipxpTgIl94fDfd/1
         Gs902PKT0Wp9/yX2aNrh/6qVfVKOKwYMrarhWY7jf5ehRZXGY1+16RHIgb1paRypJymV
         iB78mqR228lTj4xq7h6+w4MtJd3SVFTVx31sHvK9cj3BCRQUDyWQoaHavEMExzeeFfEK
         Kig5NDJQs46LwjXdVahSP5iEAXLnUnd+QWhH1LfxC+WY8xbasyAww4naf4EH/rs4mpDz
         hinimNSUyrii9SYqYqQnKQ70myVm7IrBtIh0jHtekTTI6CREIXIbWnpfVytJZT689btt
         39oQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrG8Og3I26XjsI2XobUAd2ZpGW8vhaLIBzv9oEtqp/VspHUUZfeHl57OIqbulBnK22VO0x8qQE68k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAoDVaNkYhBaXRgu4D4JCJarK0H+FoAnPKkDYN/7qy+Ybdyr/H
	fYg+Cr0pI0cnNdpp8DAe1VFLKvWdgqXgrqzuMJBElzxCS7E/2DYRXgxxJiRIfbzppK4=
X-Gm-Gg: AfdE7ckq1IYtONP3ixfRHF/nVVfebH9VG/HVyZd1Z2qAbiIHyLSq8z7N9ZS5xsrOHtT
	C5bvvAwMe44jfRSmxHLufikojX6wkVvxgJWKHpK4eCNZYXKb5fuXubYrza6PaLzc3Q/9uC8XR2/
	/WlqdLYK6TmzW6K1fVkN9PMgr1Hno45QvZb/hHOOuVboe045Hqry5ezw+Hk1g7hI6MAirqUeZ3U
	0p5AZDRnztFuW0cFu3daz/iO2YMXSe86XQn+ecBa1DanZxujByx35uCtzocC2DCmDKnpShvPGcW
	68csutKG61y+SzmJVsPNSmOlc3mIhV9/xCrNAQAGvm5tW1Gf1lKzL36xl0hZos0YkDM0aSXaMHm
	TGwtVapYGO4Nz4Hgnjokmj8LBBryGh4jppN9YwBVAjmHGKhKvbjX2x45pzb4D/gduN47mWoqOLI
	QyMbdw1kWTwAnFiytCx+lRRAQ=
X-Received: by 2002:a05:6a20:4307:b0:3c3:2e2b:29f3 with SMTP id adf61e73a8af0-3c34d5b6f8bmr1421177637.27.1783989177645;
        Mon, 13 Jul 2026 17:32:57 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm78865075eec.27.2026.07.13.17.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 17:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 17:32:56 -0700
Message-Id: <DJXVDTIP374I.31QKCXGTTY7UV@nexthop.ai>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] i2c: xiic: fix SMBus block read and PEC support
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Andi Shyti" <andi.shyti@kernel.org>, "Michal Simek"
 <michal.simek@amd.com>, "Shubhrajyoti Datta"
 <shubhrajyoti.datta@gmail.com>, <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260427-i2c-xiic-v1-0-e6207f9aa5ad@nexthop.ai>
 <CAKfKVtGztJkU_HXZTrb2h3hrTJp0SbRo-sDHM4Sj_1SG8ymOyw@mail.gmail.com>
 <0dec4aec-5a62-41af-9509-3bd9e2854739@amd.com>
In-Reply-To: <0dec4aec-5a62-41af-9509-3bd9e2854739@amd.com>

On Tue Jun 9, 2026 at 7:39 AM PDT, Michal Simek wrote:
>
>
> On 6/9/26 16:26, Shubhrajyoti Datta wrote:
>> On Tue, Apr 28, 2026 at 5:48=E2=80=AFAM Abdurrahman Hussain via B4 Relay
>> <devnull+abdurrahman.nexthop.ai@kernel.org> wrote:
>>>
>>> This series fixes three independent bugs in the Xilinx AXI IIC driver
>>> that together make SMBus block reads with PEC return -EBADMSG or -EIO
>>> on otherwise clean transfers. They only surface when the client has
>>> I2C_CLIENT_PEC set; non-PEC block reads happen to mask each issue in
>>> turn.
>>>
>>> The problems were uncovered driving an adm1266 PMBus device behind a
>>> Xilinx AXI IIC FPGA block and reading its 64-byte blackbox record.
>>>
>>> Patch 1 stops xiic_smbus_block_read_setup() from truncating rx_msg->len=
.
>>> The i2c core appends a byte to msg->len when PEC is enabled, so
>>> overwriting the length to "block size + 1" silently drops the PEC byte
>>> and i2c_smbus_check_pec() then reads the last payload byte as the PEC.
>>>
>>> Patch 2 raises the RX_FULL threshold so the interrupt only fires once
>>> every remaining byte (payload plus optional PEC) is already buffered in
>>> the FIFO. The previous threshold of rxmsg_len - 2 caused the
>>> bytes_rem =3D=3D 1 path in xiic_read_rx() to NACK a byte still on the w=
ire.
>>>
>>> Patch 3 stops the BNB handler from forcing tx_msg->len =3D 1 to signal
>>> completion. tx_msg and rx_msg alias the same i2c_msg during a receive,
>>> so this also clobbered rx_msg->len; and because tx_pos is already at 2
>>> in the PEC case, the unsigned subtraction in xiic_tx_space() underflowe=
d
>>> and the STATE_DONE check fell through to STATE_ERROR. Advancing tx_pos
>>> up to msg->len drives tx_space to zero without touching the length.
>>>
>>> All three patches are pure bug fixes; non-PEC behaviour is unchanged.
>>> Tested on real hardware -- a Xilinx AXI IIC controller talking to an
>>> adm1266, where 64-byte PEC-checked block reads now complete cleanly.
>>>
>>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>>=20
>> LGTM
>> Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
>
> Acked-by: Michal Simek <michal.simek@amd.com>
>

Andi, are there any objections to merging this series?

Best regards,
Abdurrahman
