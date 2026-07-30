Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97CD39CCF9
	for <linux-i2c@vger.kernel.org>; Thu, 30 Jul 2026 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437009; cv=none; b=oIiMtYbAuOb22VioBpx81g1CJQx//v7CsXbr7Trle9pFslPfCtaFOCHwvPekhCfS5yqyT/xCBVZCnbIkMHjtVYHPEDZ9F4D8YvZkosbxFmGEh90tU1ugQU24QqRkIflPbWQtg8SwrRY2qcmMR1t7mXcU/eej9i6qg/y0NO0Lmo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437009; c=relaxed/simple;
	bh=4xFtkt4SqgrrsbihRYg7+zsmObBemKDSQ0N/M4YFj0w=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:Mime-Version:
	 References:In-Reply-To; b=bJ3E1V/obcbWdo14aKjTmHSrcW2Et/e+XUwgv1HkXwUMHwLR6XZ5VIblsmuSHRgImUPrlqcd3mvSIu2EJwQuZEKhhp9b7OPSy6hY1RfJ6yzFBeBJn5nRPENDUY14+GzvxmxA3dzGeTvcZ9AA8djqk6z7Gt/Q3YG1kR3rrwgh62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=J3nKrVaC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="J3nKrVaC"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so99218a12.2
        for <linux-i2c@vger.kernel.org>; Thu, 30 Jul 2026 11:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1785437001; x=1786041801; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QlS7RV+1d0UdZ7kkR4emrD6is23fEjwNoBFFfOWF5D8=;
        b=J3nKrVaC/T1tCJxYym6JpOLrwJIq/tL9wC81jF710qOCuB7lJuK0y9PUEZZR7Ho/o4
         PrT7OSTyuRAsgDHo+0CM1jwIXq0wMZAhq6FOM/XP9Ti1WUUWL35toiREvWjk7YoZXzJO
         hQxk9NuEQUTTah5i+rvkVQ9t6vgOCBMEKCB3WKsYbAWUaGfoZb7dWatunxZJ9M2+v9Kc
         SaVCkNtIEBq0MZEk9hbwpPw97hVEUJ46nPfxsT1QPeBDHToORKoYu6zOuxZa1Yt8sOQG
         p9GWwFOXYRCwJMIo5ApyRKZ7WYB2/yND64WjvmtSHRWvAccSzmsPO7DvKZdNeiuojdHI
         CyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785437001; x=1786041801;
        h=in-reply-to:references:content-transfer-encoding:mime-version:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QlS7RV+1d0UdZ7kkR4emrD6is23fEjwNoBFFfOWF5D8=;
        b=Os5vl5BRGnJizRLJzsCJ3B2/npKenabYBGFdSstyQ2c6FAVtXyrXk3eoCToF5dwoMm
         m+US9FSr1Nh4Gu8a7YnVyzx+25n59/MeEJp94a8OkIeFGllQKbYyayYABS3Hf57mrKYO
         PCM+gGPfyB+o25YTS9i54CNO34ngYeApXGJ4jH6M9Pb73C675ezrEdrNvU+sNly+1wfo
         DJ96mN3LR58oY1x0tt2cQzyOzVvDK8h6KycwGT0sT6khgO04+oPUHCdyR3GKGPKdVGjp
         /Z/peM9sMp/pRg3TeYzqCscPIVRCxrPoybunHtO6ieuQOnoAsH1ldZ++/5jLj1Fpd/Kw
         LKKA==
X-Forwarded-Encrypted: i=1; AHgh+RqjfA9x2flm7BYVxh5LDzQRyAQqCCGd6kSMPfrcLrKHZZBtS7LaCeG+LFb4qNVvVuoxzacVt+rdGDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztXKb5nFd2p4yai8Ijvq/DcNS8VoRropDREtsBA0wncPEgVhKj
	9EsUMtZm3e6qdpgxSaBQmWSspvuvEn/w72s8Wo4oOSdF5Cg2I1BAMyQ8pgxaXL/UyOQ=
X-Gm-Gg: AR+sD12Peie/FrhWQ6iUUy95DSlRFey9v/I109i00+ftcAdiJjcYxXJ4b+0JkclOS1b
	GwE29D+qQF9v0+FtAVWio4KK3LoGPcead8XiLtAuqLpVt1EB9MCSkjOalOrsZhfNkWgiUJqhxnw
	YYnW0jloYmUf0W07HWsN8YSMMdVwuSFoqf3aFyRmqsQwu7rmzeQCBjS9Q0Arw8veKptmwwrdxHX
	UUm7Kbd8HmL5aWywu34HCgTFpIjvxNnhfDPlJOuAWZyoOfsOlmuEfFVd9eXJc+6YUp47snNqSA8
	8SFDswy68u9jUIJnh4ddps9jZiopfs6u7kwaU8SqRIxPmxEYgZmt4pVwOz8uO4SfFrAEtY5oMZa
	Raonrtt8kv9jHnb1TenFT37FHZCSHYVNnFeTyTNqUXNrKrKi/y1p2AaVqa0gWQMMgd4eOeneUIk
	vJTjopIpbRU54FDKvyUTw2hLzkESyPr2SDERjB4nPqEOB3tS0q1Pekz5GFzse8
X-Received: by 2002:a05:6a21:70cb:b0:3bf:6c08:fba2 with SMTP id adf61e73a8af0-3c900978720mr3358115637.54.1785437000995;
        Thu, 30 Jul 2026 11:43:20 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm44493802eec.22.2026.07.30.11.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 11:43:20 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 11:43:19 -0700
Message-Id: <DKC4LEBVE3DK.29E8XONGJDS14@nexthop.ai>
Subject: Re: [PATCH v3 0/3] i2c: xiic: fix SMBus block read and PEC support
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Michal Simek" <michal.simek@amd.com>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>, "Andi Shyti" <andi.shyti@kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260513-i2c-xiic-v3-0-ccb3cf70ba03@nexthop.ai>
 <7a967984-9979-4874-b636-94014487ea11@amd.com>
In-Reply-To: <7a967984-9979-4874-b636-94014487ea11@amd.com>

On Tue Jun 9, 2026 at 7:41 AM PDT, Michal Simek wrote:
>
>
> On 5/13/26 12:09, Abdurrahman Hussain wrote:
>> This series fixes three independent bugs in the Xilinx AXI IIC driver
>> that together make SMBus block reads with PEC return -EBADMSG or -EIO
>> on otherwise clean transfers. They only surface when the client has
>> I2C_CLIENT_PEC set; non-PEC block reads happen to mask each issue in
>> turn.
>>=20
>> The problems were uncovered driving an adm1266 PMBus device behind a
>> Xilinx AXI IIC FPGA block and reading its 64-byte blackbox record.
>>=20
>> Patch 1 stops xiic_smbus_block_read_setup() from truncating rx_msg->len.
>> The i2c core appends a byte to msg->len when PEC is enabled, so
>> overwriting the length to "block size + 1" silently drops the PEC byte
>> and i2c_smbus_check_pec() then reads the last payload byte as the PEC.
>>=20
>> Patch 2 raises the RX_FULL threshold so the interrupt only fires once
>> every remaining byte (payload plus optional PEC) is already buffered in
>> the FIFO. The previous threshold of rxmsg_len - 2 caused the
>> bytes_rem =3D=3D 1 path in xiic_read_rx() to NACK a byte still on the wi=
re.
>> The chunk-vs-defer guard now also accounts for the PEC byte so a
>> rxmsg_len =3D=3D IIC_RX_FIFO_DEPTH PEC-enabled read does not push
>> XIIC_RFD_REG_OFFSET past its 4-bit range.
>>=20
>> Patch 3 stops the BNB handler from forcing tx_msg->len =3D 1 to signal
>> completion. tx_msg and rx_msg alias the same i2c_msg during a receive,
>> so this also clobbered rx_msg->len; and because tx_pos is already at 2
>> in the PEC case, the unsigned subtraction in xiic_tx_space() underflowed
>> and the STATE_DONE check fell through to STATE_ERROR. Advancing tx_pos
>> up to msg->len drives tx_space to zero without touching the length.
>>=20
>> All three patches are pure bug fixes; non-PEC behaviour is unchanged.
>> Tested on real hardware -- a Xilinx AXI IIC controller talking to an
>> adm1266, where 64-byte PEC-checked block reads now complete cleanly.
>>=20
>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>> ---
>> Changes in v3 (addresses the sashiko automated review of v2):
>> - Patch 1: handle short SMBus block reads where the controller pads
>>    rx_msg->len up to SMBUS_BLOCK_READ_MIN_LEN for its end-of-message
>>    workaround. In v2 this branch left the PEC byte at the padded
>>    offset rather than the actual end-of-payload, so the i2c core's
>>    PEC validator read past the chip data. Track the on-wire length
>>    in a new smbus_actual_len field populated in the minlen branch
>>    of xiic_smbus_block_read_setup(), and trim rx_msg->len back at
>>    RX_FULL completion before passing the message up. Addresses
>>    sashiko's v2 note about the pec_len adjustment missing the
>>    rxmsg_len < 3 padding branch; that branch was indeed the cause
>>    of pmbus_check_block_register() silently failing on zero-length
>>    MFR_* fields and skipping debugfs auto-discovery on affected
>>    hardware.
>> - Patch 3: defensively reset smbus_actual_len in the BNB completion
>>    handler so a subsequent non-SMBus transfer cannot see a stale
>>    trim value from a completed short block read.
>> - Patch 2 is unchanged from v2. sashiko's two other v2 notes were
>>    investigated and judged not to require code changes: the concern
>>    about removed padding in the chunked-vs-deferred drain misread
>>    the patch (the padding survives via the else branch and the new
>>    PEC-aware guard preserves the original semantics), and the
>>    flagged unsigned underflow in xiic_tx_space() is unreachable
>>    because tx_pos is bounded by tx_msg->len at the call site.
>> - Link to v2: https://patch.msgid.link/20260511-i2c-xiic-v2-0-c16380cb15=
94@nexthop.ai
>>=20
>> Changes in v2:
>> - Patch 2: widen the chunk-vs-defer guard in xiic_smbus_block_read_setup=
()
>>    to include pec_len, so a 16-byte PEC-enabled block read routes throug=
h
>>    the chunked drain rather than writing 16 into the 4-bit
>>    XIIC_RFD_REG_OFFSET register. No tree-level change to patches 1 or 3.
>> - Link to v1: https://patch.msgid.link/20260427-i2c-xiic-v1-0-e6207f9aa5=
ad@nexthop.ai
>>=20
>> To: Michal Simek <michal.simek@amd.com>
>> To: Andi Shyti <andi.shyti@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-i2c@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>>=20
>> ---
>> Abdurrahman Hussain (3):
>>        i2c: xiic: preserve PEC byte length in SMBus block read setup
>>        i2c: xiic: defer RX_FULL until all trailing bytes are in FIFO
>>        i2c: xiic: don't clobber msg->len to signal block-read completion
>>=20
>>   drivers/i2c/busses/i2c-xiic.c | 67 ++++++++++++++++++++++++++++++++---=
--------
>>   1 file changed, 50 insertions(+), 17 deletions(-)
>> ---
>> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
>> change-id: 20260427-i2c-xiic-2aeb501ec02a
>>=20
>> Best regards,
>> --
>> Abdurrahman Hussain <abdurrahman@nexthop.ai>
>>=20
>
> Acked-by: Michal Simek <michal.simek@amd.com>
>
> Thanks,
> Michal

Hi Andi,

I haven't heard from the list on this patch series in a while. Could
this be added to the next merge window? I'd be more than happy to
address any issues/comments.

Thanks,
Abdurrahman
