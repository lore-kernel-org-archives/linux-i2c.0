Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792521723;
	b=YUIjg1iMmZTS0Irzl7FGcJjYhKIG6tMCfEVKz2UJWnSVsqTr87Uk89Gjycjzli6YFkwr
	 PgacMLf/kj2Ol3K8Kc3N0NHNl2u4nULLu8eiQEqPR8d4ISe0ALagXcq3FI78/ziI3wInl
	 pEG3biQqz8aO0+zCC4UCGCA2lkwypeHCSmxHPcuhFFDqoyUvw22yx7PoK84z4/bkS3n18
	 g6OqRArLqZdpi4dcXxOC2s5ixx+z66JxsgqVhMfW0PEvxZic4lI83LYgZP3V3iSIBmz9B
	 n1zNtamfH2AvSSeioYDsKQ/NQIvL2hYKBzCfn5takiKRRz05uNZ+oWiSIHxmxvU3Qhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=YwvR0hqKgY0QppCDRqvS4E1+yFhDfD+NCtMbvNXlcGU=;
	b=YR0Q/00C8Y274TuDPnqz9+4dwEJdm9KoG1IeDOnsO74BAXcnXj0FzuzeeCLLyjSYE///
	 F+OMwCLSjXxczNYqWXdG2O3p8sy1/7IWWaBrg4q6C37UacIPJBR/VSJnOOjN0zGg9ltwa
	 fpjbZYJ/Ug6UqcYbGLFIOCJyxnvqEfb7Jhbs1kF9T8sAJICHbU4ryvSywvtnllxNj9e0w
	 bh2AQ5PaM2xTZIfs2hQrmy+grigwj4SVLfDw+LLqQcAmuxDxFIrivQl/AsOamFou0/jBB
	 HY7vNKG4rmBuwZ/SG+S2SwcyRpzmX60qV/uO2ksWETzuLpddDPm60AvNnmjxtzC5SOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nexthop.ai;
	spf=pass smtp.mailfrom=nexthop.ai;
	dkim=pass header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=QhL3ORmx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31BF606A31A
	for <linux-i2c@vger.kernel.org>; Tue, 20 Oct 2026 18:42:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E31BF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nexthop.ai header.i=@nexthop.ai header.a=rsa-sha256 header.s=google header.b=QhL3ORmx
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36681e85e87so1391678eec.1
        for <linux-i2c@vger.kernel.org>; Tue, 20 Oct 2026 11:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792521722; cv=none;
        d=google.com; s=arc-20260327;
        b=XWsVgxk9wOxEnaap3ysmlKJTDIi/oBgeidQoXjQdEkURjGhfq45H9xGMb9iXrLTBKK
         vTUDBLL3MLiEBWdCflqWAzYrP2Ode5orIXnHrkEinZY47XketX3ysAfM1syMDs1BkXVs
         aCfH82+AeP77RotoxL9fxEoRVyylgqZDjhHkkEdAw/Zo+QB1JZfNtdQC/zdz5xXx2ZWa
         Xjia9rIFm8MXTic10EB5/PG1gorcYW1L+InLMiZlbGdAj3LE6xKNDdcShx2ioWyX2CgX
         Z56jzGwggJKt6AXNtCThFziw5iTAj5hDuphnM2T6N9IRVbRtN9N3P47CNUWC2CBf6Q0T
         QcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YwvR0hqKgY0QppCDRqvS4E1+yFhDfD+NCtMbvNXlcGU=;
        fh=y3u5fNyg4Cxs18pb3K1NoCBh/DQDdMMB84vZpD2pIZI=;
        b=M6DVAbmEw1qjjjw1LyqXI96sMgVoCYoLC/q/mbg2V7AvlSTDeXR8QGSdfS34NuGsuJ
         acdF355zuWlnZjXCzkfDw98WGS2RD2ejlx1pxejHqS2DOYQBzd2PaEFBog3dMiZ8Jpf7
         ube9FnUH84w+uQzEgEbzvAVaGUtMIhVazj4nJc+EjkULJ882UN6SikjRA6URHVN5WSMD
         q55n0cfzoHoKjEdotyPqM3yVRBCbnS1qKm0V6totUN2sPxHHu/q37xHvQ6+u0zEKwTJ1
         hIMBQQtBxeag4Ou53V2W68Isl92lQI+/PAK7WKvuVYowJwQqu0Od8/v23liPtJ3mkgRg
         Fe9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1792521722; x=1793126522; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YwvR0hqKgY0QppCDRqvS4E1+yFhDfD+NCtMbvNXlcGU=;
        b=QhL3ORmxarlU22wLJWF/w+12na8Bv71OTWBMGCmGh6nYC9t8oTNHCSpYbpB9jJB4YR
         GBdR2i0YIkJojp3Am9+G0hz8WJa+YBWaXorEh2FXUQ0p8le9BWJ+B8AD6XbL6FkhQrSN
         9/lKBLH1h1X6hcVGIAcGMhQKqoU+zafSQ4V1eQalLxZjojIbzPq6raCapl85AnGkyDqy
         DLioSm/mFCaRbwZUCFHkIprUtREUgHZLbSDL4Anlu2RU1QSdrB15YxWHoLDbnVPJQffW
         6X/VBZXKXfex4ImuB9fPqNJKtBKtKTILOjC8eSDID6H1LqmKXTAjYTm/t62pJEjeCuXw
         4uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792521722; x=1793126522;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YwvR0hqKgY0QppCDRqvS4E1+yFhDfD+NCtMbvNXlcGU=;
        b=Si5X/8AXESCCtT5RXo1FSoMiTRwFW27C6q6g0boQE4hEPhDX4z0zGfBn/z4QkkSbyg
         3csReNQBKD1EMwXZ31E14KUAfrfcf3wgT8cqROij1RP/6DWBso/YBvpea1OFhWAONTYl
         H01KzgerFDfcX5023+mDsLQXIzFH2xsh2u5CK9tVLrc6QSbUiHA+Z4FKDTHXKmmLATgC
         EuH0x7L6nd029qJHtww/VDjPbQDUTjElvxc4oo4Tn6QhD4VgG0eksQVEOrYSg9nYJk+R
         jl+mosaybEFrhAyZWFbTxV+8Tb+WiLIvj1iGYAnRHWN6C1MmJK2UkSzt67uMekpVu8hJ
         89fQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVXAnH+QBqAfAYwx4udMbiXK6Dl7Dux6FvCOHVagDiGfECAgplLbFL2CC8nKdvU7eD0otD6ARX+Nk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLK99V5Xl95cFN1solyyu3chk8lTuKsImCcA9Zv+k+G8cJehvzP
	gqSf61ba4n2kBqE5VmLQp4NONF3MFG2ekluyjuOT+PPnY/q9/jhUnx+ToWibD/yzIq/syqh6EWP
	bC1oTNpFUL4MQIUGT1wxdZ3DRP9RH6EbETPmceW73dw==
X-Gm-Gg: AYBFou36H4QSReegVw1/TLxjchSL+vsPm09AYWdqupl/zL0aOYypHbm0X5kEUuuK8hR
	NaSjCtnLwPzyP1jlbFdt4WuyafrJ0A8rRNWGATa7yFmaCKwiWthbKwjeh3yxPa4iL28sBpzdCBq
	VK8t/fPBSN/RUARWoL3FXpiZLklFvCblY3AnJNwkcE3tGNUOEAYWQJXndD6+TVAjfMQjqVieEPM
	kHJvnTtklpb98meH1MvF6lP94BxSMBNCWuyaywET7QY5LKMYYsqyz/WaJ5ZcRU8tLa21J8/VQxP
	kHkx1SQd3TeraC/hExbRYklM451fQujIBnTWYpLNdVEJIJKWV3SPvvVbuQ==
X-Received: by 2002:a05:7300:c00e:10b0:35b:d329:9f3e with SMTP id
 5a478bee46e88-3674e842a86mr135963eec.28.1792521721089; Tue, 20 Oct 2026
 11:42:01 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai>
In-Reply-To: <20261005-i2c-xiic-rx-fifo-v1-1-0177ac5f72d7@nexthop.ai>
From: Siddarth Chilukuri <siddarth@nexthop.ai>
Date: Tue, 20 Oct 2026 11:41:50 -0700
X-Gm-Features: AclHuK9vLMZF-AAKuV86zplYxOP7GeZc2vlcY3CCw4_yPy_9puJFU1MY3JTp13I
Message-ID: <CABAykku7MDTF7jTg3OdY=AWCqrBUTS_sNAoVTHUBM6yM=NKjUw@mail.gmail.com>
Subject: Re: [PATCH] i2c: xiic: don't fail a read whose data is already in the
 RX FIFO
To: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 5, 2026 at 11:49 AM Siddarth Chilukuri via B4 Relay
<devnull+siddarth.nexthop.ai@kernel.org> wrote:
> When the controller is the master receiver, TX_ERROR is set once the
> core has NACKed the last byte ("transmit complete" in PG090). We have
> [...]

Hi Andi, Michal,

Gentle ping on this one. We've been carrying it on our Xilinx AXI IIC
based switches and it fixes the spurious read failures described in
the commit message. Happy to rework it if anything needs changing.

Thanks,
Siddarth
