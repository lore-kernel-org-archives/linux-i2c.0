Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793596450;
	b=kx03G0OyVyySNxzHgf7yfDuhXtJCOIvo9n/4VxwmYwrPl/V65/zPqeaJPSICHl4pYd4h
	 Fn/g2pfhqm+EmXpJtDmbZfJcJ/8km633ASa34k8DUtTufsaxIKxk1wy50LRDlY5JfF5Fy
	 5mrWfIT2Jq7fjzv6HMGgPg1X8dA/QlLzrg6i1AVdOQ69hHx5q48jzLbs5XEPimvSnAlib
	 yVRYnDgjefRKi5MixDbYolJnKUsTb2XVqQkN+ObgbXF90xYmQbRXcSNmC9dY9kp7fDWia
	 VsGYFdhG0H0ZCFRJnU5JRN2AIkY9JoW+igqImg6LIAgkLr0HpmMp9FEDqpKojriT9yQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793596450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v8urwWaa4j6MLfo3l3z4XF2xgg1WktAvkm23PO6lNZY=;
	b=Px9q7oezeAnP0XA7OKIuryzQxchUc4unNVNTp3XAcwpbsiBgM+A8t+Q0r1RQ8/pgpsnl
	 lAw7SVwruYA897pzQ8KXKHqhdp51MA91JkKtlEgbpaCniRrSl8u3jbFdfk3BRLUFSjGHr
	 KdfnUxvZDAsXBVCXZO5Dufh/md+2A3LbhTyzDPQrAih5kn8lPY++abZtuMIGd+rRRzHoP
	 vJAIuwNR0jG8eTRicHod9dmIrotaQ51QUi7fA5cBi3yW/nTI4O2mzRwCWRh0Vrkj3Xoqu
	 09D1D9aTvRmVbBm+bWMXALJ3hYfRA2fXWPFD8eRmXZc3nexLhHuhP5ekYkgMPL3D8OQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzxiRlEY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1859606A327
	for <linux-i2c@vger.kernel.org>; Mon,  2 Nov 2026 05:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1859606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzxiRlEY
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-679965fb848so2490952d50.1
        for <linux-i2c@vger.kernel.org>; Sun, 01 Nov 2026 21:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793596449; cv=none;
        d=google.com; s=arc-20260327;
        b=g4S1dRVYrbP6suVoyJ9tZYY12kILidqVHObWgpIefEKG3dr8qsZZkKTVDbc0dARl/9
         ++99MwUluqJOYuMGtDngnJgEkqygsSFY5zVD32D5l64zlX3Ngqyy4O3mYtuaMPz/RuT2
         RdpL/RD3YBo4vkK6lVMdakzi8HKduWZ6EGK2fuqCcEt7M1qSJwGKZ3hjU0QubdYOtlLD
         iMo2WToZ4+D/Ky7Yu8wa0Y9NvKzdJvB+zpHuS16fh2ef22KnEHMijV4DtQ0mBxGjoMzO
         zw9xjoAoQrOSwKhrZg805xzm6085cVatCwMjH4NZhXnaqRlmwdpylg9DeWEVaJR2taxv
         /obg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v8urwWaa4j6MLfo3l3z4XF2xgg1WktAvkm23PO6lNZY=;
        fh=DV4HLdGXMe2fWfrcUmud9p+OYwBp36Y47IVwC1d64B8=;
        b=LGjeuA75a3MhvlgPgYF9LfYe3eldaeDkq2SL8WvcWHYzdkYaelAVvogOJEloxWdCwQ
         eomIsplHmDjIIzojnDijJ0vgs+xHqW92pL2q3fRQgc1iHL3+mVf+9z1ILpCs6aZ3MgjX
         FGxYcHxdwcCnQqn2qHTONhbzQBJuiDx8K7ipZt6kyhyUF1rcXA5Bs1JJ2EhWSUiuuq9V
         E5oBABL84EG6N/7Xk7jvyNqiCINKVy6qdCkYvCTjte0Ozni1RwZXJa9csOZdtXrPOUCG
         Z1DnzLf10pf/T7StwXMJv2N7Q4YhAARTTXkeNNIWXjZwBj/eM5QZtr+QLcv5j/QXt/oi
         I3TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793596449; x=1794201249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v8urwWaa4j6MLfo3l3z4XF2xgg1WktAvkm23PO6lNZY=;
        b=pzxiRlEYo/Ud2clGm92Z2Nc+nPMSTo5A2jvtHpEqc3cpTfPP/45gQBmYZvBjfwZrES
         7xSCQRe+Fet+9w3qh6Ex8XRsZSJgLfxOKRppVXDobRX4J+o1qhJydRf67EkYzExP2Uok
         ENjdP4oWITjCEGdcahatfIou+Zfw2DByx0xQmPLKJGvekvC9I0xg9/T6MV4kZARwL37h
         ZTvR9O+fi1A//KgIKF59HOWBU+YIcXBRJHp6qacYZ50zcUR6diwPqH88gJVPSmko46VM
         KXClWOTa74D4cnflESOCBfsRI2IXwDgPJruGK49ryiSvcf3rkcdhy/nXJwl6zx5h/jSJ
         C3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793596449; x=1794201249;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8urwWaa4j6MLfo3l3z4XF2xgg1WktAvkm23PO6lNZY=;
        b=N7YSOJ7295xB70PtLOqncv3AsQtmSnCQ9l63hI+VwPXfaKgUDStg2zwqnfocVg+wAx
         5srnhs5vAOlAUSJkulDnMYu2Ds6Y4YUSL7bxKmIRPKZRTEH7p0Lp2E64OnyxWBhC2IcY
         anGElP/P0u/4RIIovi64c5HcU4GcpYLeYuUbtigWC9suHU1DzBJ6KzEAPEQEQUgi8JK7
         MKy/fp5juGKaOKGIpMMWAXd19boV2b+c3zojRKhVj2OHk+jWyRODjHtq6xROx41KQSZ+
         YxX1h+eE4T1rjrPVFKxhTpoMzV5PCO2BR6rg9VEI/nH9OPu7xkFJ9Nf1LoJBhQ9oqtYE
         1SGA==
X-Forwarded-Encrypted: i=1; AKwUvBxcUgxZ6cqtfNtXNvyayDp363iunxlFy0bqy/INLKbt0hI4oD40VmBA1S+ZrHjy6GVv3IGQG/zrUSk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zgLLt97KGWLdwSUQaFY1pR/Z8H0NmYZCPaodyTiyhGE41cszm
	Xa39lu6G8bBRJYJ5JW9BKPBxuhlf7Z5o0yrIAh7CKXAGqrQ7tNal6cKg4iqqzG9+bsJMjQrs5GJ
	kKPovyl/ZllxRkxuAXZZzmdFvOLVzKHw=
X-Gm-Gg: AYBFou1ZSnmwOjNPkJPum4OQrNC/dEOyJGg7JiTxu/IptTpUQcysLU8tXrm5LVotlKP
	s0G7K85K0A46ycSypaD/CzseB6PwhodWZFLoRvM75sYaeFLNIxbDKogku2Z+P0PlwjNqAmTH5hA
	ky2AgPOQsJ5QA9J6rJUvpWxtndVXVA4glKl8ZP8DQZreIxyfWyZjhORWkMbHIhGpPHrUe6eVf6l
	l7BuYAVVgaMb/kzKNywtFKASX0y5J4J8eP2ZLtiYBWOSTz2FvIZiPDmKsD8tw8udGvLkHbf7vrB
	i60OBHBkflSyZI6KadYiDN0OXvD7yRG07skndCg1oC3wDrrlFkKlr3ezP+qH19XgGeI8R0mfh4f
	UWIQvAAnPIQoC9snObAbJRAP1+f5+LRGgEI5z
X-Received: by 2002:a05:690e:dcb:b0:672:bb7e:c919 with SMTP id
 956f58d0204a3-67ba4c909d1mr4822552d50.2.1793596448567; Sun, 01 Nov 2026
 21:14:08 -0800 (PST)
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
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Mon, 2 Nov 2026 10:43:56 +0530
X-Gm-Features: AclHuK9Mvr8Imus9GpDjhEHLlkYTTfWG_3Dm8Qn9Rw_Yjm6XgiZ4JHgA2iLl30A
Message-ID: <CAKfKVtG4oCxJEvsQEDMxZSLbjSgzTxwMQ8Ky2Q9FtN3=6F+_rg@mail.gmail.com>
Subject: Re: [PATCH] i2c: xiic: don't fail a read whose data is already in the
 RX FIFO
To: siddarth@nexthop.ai
Cc: Michal Simek <michal.simek@amd.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:21=E2=80=AFAM Siddarth Chilukuri via B4 Relay
<devnull+siddarth.nexthop.ai@kernel.org> wrote:
>
> From: Siddarth Chilukuri <siddarth@nexthop.ai>
>
> When the controller is the master receiver, TX_ERROR is set once the
> core has NACKed the last byte ("transmit complete" in PG090). We have
> seen xiic_process() run with TX_ERROR set but RX_FULL not yet set,
> while the RX FIFO already holds all of the remaining bytes of the
> message.
>
> xiic_process() treats TX_ERROR without RX_FULL as an error, so in this
> case it reinitializes the core, the data in the FIFO is lost, and the
> read returns -EIO even though it finished on the bus. The next read on
> the same adapter can also return stale data without reporting an error.
>
> Fix this by checking the RX FIFO in the error path. If the message is
> a read, there was no arbitration loss, and the FIFO has all of the
> remaining bytes, handle it the same way as RX_FULL and complete the
> message. Since IISR is toggle-on-write, only clear RX_FULL if it was
> actually set.
>
> We found this on a system with several AXI IIC controllers in one PCIe
> FPGA that share an interrupt. It only happens when at least two
> controllers are busy at the same time. With 12 QSFP-DD modules being
> read in parallel for 480 seconds, the failures went from 2083 -EIO and
> 1158 reads with wrong data (out of 11.2M reads) to none.
>
> Fixes: e1d5b6598cdc ("i2c: Add support for Xilinx XPS IIC Bus Interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Siddarth Chilukuri <siddarth@nexthop.ai>
> ---
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
