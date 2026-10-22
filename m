Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792698082;
	b=tb2FDqaBHx1P9srETXZ96YYHGLpVos+KLQwjTqijbO+KLQcoNE+fIdFAAPwcM05VvTYt
	 oeO653VIWqBq2t3NJE8lhDXvrYamywfKIaKxnuSgUWtZFYBclr9IwXG3ActNVKmdAr9Zc
	 MdeIxNzXfqSU8c7lPooBXEPHBcfpRfS4IVanagqnhqljPCRS+Oi3pj/V/s8bNpUCom/pI
	 YH9GBkqjqb2HPZ84p6spsennz7G8/lgGYeYeXaNcNEAJ2nih8C8ngV89sqXLVhu25NYGN
	 pBHmKm/NSo4TlRjdwbLUBvcImTG645Zy9GF7dEDUcoQsIkfShG/mmaNctOHbVfx5yAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792698082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/uPf7O7mV3UVcLoPpg1h7SlQrq05lwr9QUgDlZZcEx4=;
	b=WHYe2+VKK7mCmpQO+AvcjoGFjJb4eD0t1YPrt9L079MlFpV0XG/azn0mFV4wUrDjz5XF
	 4HcLd2a93b3uTNjnmskvz997UmRw3InOfqd3MxSDejJmKfJZ7P3shmqDclt6Kb5pPaG1z
	 KyHy+tMRMF17muN7nhM25d+98PO2xV74NJiBkPsAxa5QLsRtLBZ1Tm/MvEiA9CKysJR/T
	 R2xPbSsBqvvZVtsLL7sEmPEFvRFUyU6H7NLjYWQwn7qDDydQu7u6x6j/LbV2AkD0ut99m
	 Og95hw8wBfniqxAFNekKpkQDcCK67VWqkpyWYmZbvwf1OReib1558lzbKlMyhR3e/4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eGuW2GMh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9A606A329
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 19:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0A9A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eGuW2GMh
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93ece7a73b9so14461785a.3
        for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 12:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792698080; cv=none;
        d=google.com; s=arc-20260327;
        b=fD0+45qO7e+m40+nS74UR31W1+3iNtny8r6+okFy80xjOZZd1jcmLyxSoLQKGwOcre
         oSCP28g3F+uo9J3hbpoW2/KmZ0AEKlvseqxe3Uyqe9fO5s8h7u3PO5o9y5HioBlHIU+6
         B07sp0zvfaaGe3SUw+ykpcAQ+Mc0Uxm9C4wx+COXtZ4+29qXEp5qkXHc5z1xRRiTgGVc
         wmp1zpUgxEWVmGRCzRk/J5GuSpVRTvBVM1IBQl1yqSs3UjkWSmVNghlGogTmvwrroWn6
         2eDcEK88a0/oxqPpsf7Vyc5PQiEel0syXcfn9w6IiJ2pu/+mG1SFG+SJeb3Wh3pXl96Z
         rFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/uPf7O7mV3UVcLoPpg1h7SlQrq05lwr9QUgDlZZcEx4=;
        fh=2XX8/fzmnpv+RW7R9H2XtVNct9qjWG044CxsAuV7s84=;
        b=jxDDS7i2B4ImesdWPdRZp2GCwwoVVimo4csXRukJTNd0fIWCIoFU73tBvyxsJSf2rO
         phy6Ttf+QrJwAQiHXG4mD4SC3jZZ6/gdQ7Ql027llUwVfQJFuSXcFmWN7dwW87CNSWvh
         kOJeEFQ2hUXi6IR8oHZjo52bMwm+wJD8Nfkz9GZ7qoj4MPe5O7lAYr76PgQ58uUdOYmI
         wZmSTef2uCWi1ZbyA7vewcbKeirANXTfLWMr863NWUH6Vpu0xi5lQGrl/+PSQZwprYIN
         qMw7j3w51gJidwjiCnfijsvhhQrx2x9EzZR4o0vGpMZRhzHq/ufq3NX0NZB0h9LRdmEi
         8RTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792698080; x=1793302880; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/uPf7O7mV3UVcLoPpg1h7SlQrq05lwr9QUgDlZZcEx4=;
        b=eGuW2GMhQSUXWyk5IeInmdud2HJMQfOnVPXJmOeMh6VxFknNuNoa+qkDlXNZeYEkHh
         GihGP4ebcfdPfN4VzbHut5Yjoa6IcOBeMy9rnplGsEWi9IuRHabuVA7BBjEyG75zGxKY
         ELkZwKuLUwjWElR8OJSrpVhetC5zDhZsJ3kOQf8gEdEsM9T/Ubax3hCr6oCIkXp/jDBR
         6DMtOBdOyD6Z6vKAMC++ATPdyDAAsFGJAcRengfX9XrZfxpmTXMeJA4bnOXXgeSmAbTy
         ANdKXuIkPnv4E6ycQtPA7DstjA5ZpLHYHAOWY45xmxWGB8saWofUe8lrvcSH5cSwZlDz
         +4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792698080; x=1793302880;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/uPf7O7mV3UVcLoPpg1h7SlQrq05lwr9QUgDlZZcEx4=;
        b=1JXAHIPzsyf13NmsHPos4DeNjuhFc9I2A2eqfPmbeDxTDirG8kvHoOx1lMqFEjtFWX
         CDp0ULvioMVnB0oh0SWFjRXrvMci+sCzHU3d2vytrfKTyapC0YdjTqd6zOLiwLm1upAx
         lcuPtixalDX+tk/1m8JNTdLAl83rSpzJL6TlfUyzDIVAjwqEuDokjI/pHt/95dLcA12Z
         5YBrFCftgfIOayripgHcHuquiAJr7OpYX9vsslt1lN1zJ6iZA9UogoOGiXlmWfujhG7M
         /84TDBRrBLy/laZ9BX1baqfj6a3Nz7Fz3MpqgQFKY7p4Q7QPN/MMqUNpWn9B5el8LHDP
         Q3cA==
X-Forwarded-Encrypted: i=1; AKwUvBwl+OTN9ozJ5FqBOjth+gPBsyfWU1N2lQ9kYOiOFB3DMLNMEOegtm1LoXrWGVvznKVmluaNYJYn/pM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWMMwsogynZ0H1qmeYsDQACuCULBz6NXtMXBApk4AOa8e/XV0+
	rJgNpRmHTBvOI1WWT52gPIWXWiYQy/8NaNjjnoroTrVPOoIkdaBPeiS9VDhgFKQpWbRgYGQ8/AD
	8yJdXkRBhW2mmBmHJFEoQuUsj1ea/z0U=
X-Gm-Gg: AYBFou0RqCCa3IXskijPUzJxhFLO2A1wmWOMUYBPEEXaYLgJKFZQNmf2fbROxOTM6qY
	T+JnKgbg2Xi2bV3VL+VR+dnhW8NpAknbOFwxBDwBtCzULEhfFR63dxqyaEqiUCQkat48oikmBmd
	YBKeu4H2N8kYAm65tgoTfmURB8sVs/PV27lhW2nP9Tp9UZmoiXcZTUW8ftS05o2gC6HMqFitwRu
	OLO5WUadAMh3OBEhDyYVJ1dah4SoACavqmnhRwVm0qXZNIGEhm1LXT/VDDGqshNp+sX90wZUSei
	+P/GZ2CpSlqsq16gTc3j2sAm5dJqil/Zkd77DTdHPR/LK01k9st8wNos0Q8ILbVTKzr6tEHh4kZ
	0AqPmTX68dHNgZi+F5CxWE6gBBpe47VOEBedjYWN+ry6k9d2lVqLqz1w9PV36k6EG6EbsP9oZKb
	+SBk1V9xOvLavEgQc=
X-Received: by 2002:a05:620a:7001:b0:939:b057:daf2 with SMTP id
 af79cd13be357-93f6f7fef1amr89402385a.45.1792698080536; Thu, 22 Oct 2026
 12:41:20 -0700 (PDT)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022033638.32460-1-thatsme.saurav@gmail.com> <16d56f7b-6295-4ac8-b0c9-8b490dd0d582@leemhuis.info>
In-Reply-To: <16d56f7b-6295-4ac8-b0c9-8b490dd0d582@leemhuis.info>
From: saurav kumar <thatsme.saurav@gmail.com>
Date: Thu, 22 Oct 2026 15:41:08 -0400
X-Gm-Features: AclHuK8DakwZw0LIt6ofHcRsAHS0pyqF6XCOnFZsjF1b3JyRhz1B6T7MRSrjzRc
Message-ID: <CAHmbrkmPc5+NrKUn-Bfi6_U4nxYNsUZe0xFNackUS3v2rbWJjQ@mail.gmail.com>
Subject: Re: [REGRESSION] i2c: qcom-geni: HID keyboard fails reset on x1e80100
 (Yoga Slim 7x) since 7.2.9
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, Andi Shyti <andi.shyti@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	Praveen Talari <praveen.talari@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Tested 8cb5c17be3a2 ("i2c: qcom-geni: Restore the source-clock
selection policy") on top of 7.2.11 on the Lenovo Yoga Slim 7x
(x1e80100); internal keyboard works again after reboot.

Tested-by: Saurav <thatsme.saurav@gmail.com>

#regzbot fix: 8cb5c17be3a2

On Thu, 22 Oct 2026 at 01:44, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 10/22/26 05:36, Saurav wrote:
> > Since 7.2.9, the internal keyboard on the Lenovo Yoga Slim 7x
> > (x1e80100) no longer works. 7.2.8 is fine. 7.2.11 still ships the
> > same i2c-qcom-geni.c as 7.2.9, so I expect it is affected too.
> >
> > The keyboard is a HID-over-I2C device on i2c0 (i2c@b80000, 400 kHz),
> > address 0x3a, VID:PID 048D:8987, IRQ tlmm 67. On 7.2.9 it fails with:
> >
> >   i2c_hid_of 1-003a: device did not ack reset within 1000 ms
>
> Searching for this error msg on lore found a change that fixes such an
> error on Lenovo Yoga Slim 7x Gen 11: 39e8e085710a2d ("HID: i2c-hid: add
> reset quirk for Lenovo Yoga Slim 7x Gen 11 keyboard")
>
> Could you try if it helps? The stable team plans to pick this up for
> 6.18 already, so your feedback might speed things up (and get this into
> 7.2 before it's EOL, too):
>
> https://lore.kernel.org/all/20261019135441.1420968-216-sashal@kernel.org/
>
> Ciao, Thorsten
> > The touchpad on the same bus (0x2c, hid-descr-addr 0x20) keeps
> > working. A USB keyboard works as normal.
> >
> > If I build 7.2.9 with drivers/i2c/busses/i2c-qcom-geni.c taken from
> > 7.2.8 and change nothing else, the keyboard works again. So the
> > regression is in that file.
> >
> > Five commits touched that file between v7.2.8 and v7.2.9:
> >
> >   82339215fc00 i2c: qcom-geni: release DMA channels on probe error
> >                (upstream 268aacb2e2a5)
> >   139efdb3ee6e i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL
> >                (upstream cb97bf3d4f91)
> >   6c3420d6ba34 i2c: qcom-geni: Store of_device_id data in driver private struct
> >                (upstream 692e0c84db5f, Stable-dep-of cb97bf3d4f91)
> >   4edab037132b i2c: qcom-geni: Move resource initialization to separate function
> >                (upstream ed4b34033db2, Stable-dep-of cb97bf3d4f91)
> >   fb54df3645d8 i2c: qcom-geni: Isolate serial engine setup
> >                (upstream d8d3bb127ad1, Stable-dep-of cb97bf3d4f91)
> >
> > I have not bisected within this series. My main suspect is
> > cb97bf3d4f91.
> >
> > #regzbot introduced: cb97bf3d4f91
> >
> > 7.2.8 always wrote 0 to SE_GENI_CLK_SEL in qcom_geni_i2c_conf().
> > With cb97bf3d4f91, geni_i2c_clk_map_idx() uses
> > geni_se_clk_freq_match() to find the index for 32 MHz or 19.2 MHz,
> > stores it in clk_idx, and qcom_geni_i2c_conf() writes that index to
> > SE_GENI_CLK_SEL.
> >
> > On x1e80100 the QUP SE clocks are registered as DFS RCGs
> > (gcc_dfs_clocks[] in gcc-x1e80100.c). geni_se_clk_tbl_get() builds
> > its table from clk_round_rate(), so the table comes out in ascending
> > rate order. I suspect that index does not always match the hardware
> > DFS perf level that firmware set up on this machine, where index 0
> > happened to be correct. If so, the engine runs from a different
> > source clock than the SCL counters were computed for. I have not
> > confirmed this yet. So far I have only shown that the 7.2.8 file
> > fixes it.
> >
> > I have not tested mainline yet.
> >
> > System:
> >   Machine:  Lenovo Yoga Slim 7 14Q8X9 (83ED)
> >   SoC:      Snapdragon X Elite, x1e80100
> >   BIOS:     NHCN62WW
> >   DT:       x1e80100-lenovo-yoga-slim7x.dtb (in-tree)
> >   Kernel:   gentoo-sources 7.2.9 (genpatches do not touch this driver)
> >   Good:     7.2.8
> >   Bad:      7.2.9
> >
> > I can test patches or run more debugging if useful.
> >
> > Thanks,
> > Saurav
> >
> > --
> > Drafted by Claude.
>
