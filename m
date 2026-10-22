Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640211;
	b=m/woLYeQsV7jVt6kVs1K4b3WKisvKd0yQ8sDm3oCzo/WqYMtq2K7yPy/K+xVDa2Pthrw
	 2rEX1eC/blqnlon0xmZiyr0ls2XjzNUMOtLnfHK04HcI7PAr2JeYYxuVpIHBZQSfst+4+
	 EqYwG60+U6ZhMBPxGlxMEELykp4RaE2JqCnhIqDluPBtBaEtVjEyHdEm2a9/1mI+wD5tl
	 b4WrBloW8K+M7kOUKQnihq+D3y72xA8LHZqlxDLdRmQemTlgATnuhEjK5sq/biaNqhYW0
	 2lbqHnYxiDrmbZHQAnXvJh1ucWgUF1o3XAz6gaU6Od0gXFv6GtTXMtg0ysHAf43X1Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=awwXifPb5aHvVxBftaP8w2SImHVCu8Aljuq6PIur9ho=;
	b=uU2S6OJAd8BmRXBI7dipd3IOb8kcwtD/puYsYMcji819dOuhdZjJPZfPHBRU/UXS8scO
	 mPnFrN+n+txkBjaww3bCab1hA6nXPBCNtU9C4gYLTaV/HZvgWEQqVY4PBDYQHpUn/VhrY
	 aT19DCK72/qCCAGHDzdmEZqIRCHIZBB9fdm+WZaP+fZU/JGBdIv2BpvNMjgRbuHqmse4d
	 DUyLwQMOVovdyXrsVtH46fmRqCwM2WN2vtcTg7Au8cCbtdzsYUBjqc3EzV5QsjoS875Zb
	 zLOZdxQd2W2ejuPpWom/J48ymuEm5uorn7cGSe6aUm/5bDMDtvJFI9JcncvlZQK+wlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZWowEBAm;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620EF606A335
	for <linux-i2c@vger.kernel.org>; Thu, 22 Oct 2026 03:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 620EF606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZWowEBAm
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53644ab1f7bso11551971cf.3
        for <linux-i2c@vger.kernel.org>; Wed, 21 Oct 2026 20:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792640205; x=1793245005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=awwXifPb5aHvVxBftaP8w2SImHVCu8Aljuq6PIur9ho=;
        b=ZWowEBAm3ZpvS9spxy+hCOtyHpZUQRXfMV7VGJrGBqePtMutqUsUT3HkHt6OkJuyNC
         Ua/alNSXjOarGoORxbJ2qdgHrZxI844ntFXlED5191iWqDiQQ6fBp4Uno6ME57PZ+ElQ
         FFZ1kzUwIWtk/jSENQ/ZfDpsbca7wUKdstXfRtJr4A0yMF7NNReaf1HW4whoef7z4ujb
         ZrV/9LgSehijvD+JxnDfj8hFR9bRlZSxyH0z8Ff649a35Kbuuxyt+ijoLnzjHT/TSCzT
         J42z2zn8NfpNI8AkL3HPkFh+4tzoJ3YcY5EGAVT5nbSPjH27mfU92/0RdKy6w0sA821H
         JF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792640205; x=1793245005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=awwXifPb5aHvVxBftaP8w2SImHVCu8Aljuq6PIur9ho=;
        b=WI/949w4uola76jwSeMcAgt3QRuvfqjndS2vQOK69eXxNDWUhleaoZUC404+IZk6ce
         QRzv9aXlJhSjg86MpQ0b/AJTArfARK3jQ0tY4RCGLZbOunuDs7wiI+mglEtPgPP+kPVN
         6NTY++Dlw4G/7f08CfxEPHg2rD7lgzkrPZ42hMu1rGQ3hlZCSG86KNvQBf6BoNK6LsDV
         SlQh3TpAgtWX3i4Q6PE2GH0znJTgkliwxwHd0uEmf6GHTK7kaTmVvq7WLhh82sFYZIJJ
         0h49PCbo6/20un9jQVh4K8TJ4qekiO1gcPxBcBzirmwFRRhUiUm0E15Ct+a0H9SGurBn
         7CLA==
X-Gm-Message-State: AFq9FYJiAQYcmZ6sjDE/2QnyFk17LjHbP7Uf97h70vilHqNwsJoygmxr
	0AvzAE8wT6KgHIlFFoWA48XDYUu9lzbCIOy5snyPXS3qMwFaBVPZNWkxJt5zeR09
X-Gm-Gg: AYBFou1LpxwVF12hMIKRrnPqTV4yacWBL0Ay8FSZYqOUdRxeWEtGsnulNVn4BBw0F20
	csxLAOJG6K1uZxlGMpZ2++uTBs7/x/ovSu1zZPQn706/qOAlh82vg+00bnRVszZGcQW1iz7nQDv
	N74BTGKfFFz/qgmz58pzX51CJzqjAq6F1ehP/yF8zoKyW/UdHU+4L+WLhfLdRFc82axbLzrhMY7
	GzHESHR1gLv9Dteuud4vps6PR9e9Rd0h5FWe/SF6Y2ftn2xXvRnwxkG4Py/andu75QPGlmphi6B
	tUlf0l/QDzCRMxxMK1LXqwtGafVHFP9InpG7OQ47B3a1uGPsA8q8GjvvU+bmLO8ZFq9JD+31ubj
	pHuedCNB7q6ipHJh+ipzjQ36EFTODSBrgIK7qURDCARtVUg9h93dqmin+I4SRwUqtsOlNkpymjy
	3YGyW0ygP9U3Y5S+lCoDJoHg/2G5DVyrdiM5foK9le6vl6X9O1HlnCgnkCvAGX/q9nmwRwYOMES
	B1qrXsnF4pBR34KY7R9sg1TorcdpioFDVQaqEiKvgjkvWY0jIqeKcYtqlmboucnbaB45+EDoeKV
	164=
X-Received: by 2002:ac8:5a85:0:b0:535:2763:16a2 with SMTP id d75a77b69052e-5369b8f93f9mr64806861cf.43.1792640205211;
        Wed, 21 Oct 2026 20:36:45 -0700 (PDT)
Received: from localhost.localdomain ([2604:7a40:c601:5090:676a:ee3:7aa7:5c53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10bd5d8csm40818286d6.24.2026.10.21.20.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 20:36:44 -0700 (PDT)
From: Saurav <thatsme.saurav@gmail.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
	Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] i2c: qcom-geni: HID keyboard fails reset on x1e80100 (Yoga Slim 7x) since 7.2.9
Date: Wed, 21 Oct 2026 23:36:36 -0400
Message-ID: <20261022033638.32460-1-thatsme.saurav@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Since 7.2.9, the internal keyboard on the Lenovo Yoga Slim 7x
(x1e80100) no longer works. 7.2.8 is fine. 7.2.11 still ships the
same i2c-qcom-geni.c as 7.2.9, so I expect it is affected too.

The keyboard is a HID-over-I2C device on i2c0 (i2c@b80000, 400 kHz),
address 0x3a, VID:PID 048D:8987, IRQ tlmm 67. On 7.2.9 it fails with:

  i2c_hid_of 1-003a: device did not ack reset within 1000 ms

The touchpad on the same bus (0x2c, hid-descr-addr 0x20) keeps
working. A USB keyboard works as normal.

If I build 7.2.9 with drivers/i2c/busses/i2c-qcom-geni.c taken from
7.2.8 and change nothing else, the keyboard works again. So the
regression is in that file.

Five commits touched that file between v7.2.8 and v7.2.9:

  82339215fc00 i2c: qcom-geni: release DMA channels on probe error
               (upstream 268aacb2e2a5)
  139efdb3ee6e i2c: qcom-geni: Fix hardcoded clock index in SE_GENI_CLK_SEL
               (upstream cb97bf3d4f91)
  6c3420d6ba34 i2c: qcom-geni: Store of_device_id data in driver private struct
               (upstream 692e0c84db5f, Stable-dep-of cb97bf3d4f91)
  4edab037132b i2c: qcom-geni: Move resource initialization to separate function
               (upstream ed4b34033db2, Stable-dep-of cb97bf3d4f91)
  fb54df3645d8 i2c: qcom-geni: Isolate serial engine setup
               (upstream d8d3bb127ad1, Stable-dep-of cb97bf3d4f91)

I have not bisected within this series. My main suspect is
cb97bf3d4f91.

#regzbot introduced: cb97bf3d4f91

7.2.8 always wrote 0 to SE_GENI_CLK_SEL in qcom_geni_i2c_conf().
With cb97bf3d4f91, geni_i2c_clk_map_idx() uses
geni_se_clk_freq_match() to find the index for 32 MHz or 19.2 MHz,
stores it in clk_idx, and qcom_geni_i2c_conf() writes that index to
SE_GENI_CLK_SEL.

On x1e80100 the QUP SE clocks are registered as DFS RCGs
(gcc_dfs_clocks[] in gcc-x1e80100.c). geni_se_clk_tbl_get() builds
its table from clk_round_rate(), so the table comes out in ascending
rate order. I suspect that index does not always match the hardware
DFS perf level that firmware set up on this machine, where index 0
happened to be correct. If so, the engine runs from a different
source clock than the SCL counters were computed for. I have not
confirmed this yet. So far I have only shown that the 7.2.8 file
fixes it.

I have not tested mainline yet.

System:
  Machine:  Lenovo Yoga Slim 7 14Q8X9 (83ED)
  SoC:      Snapdragon X Elite, x1e80100
  BIOS:     NHCN62WW
  DT:       x1e80100-lenovo-yoga-slim7x.dtb (in-tree)
  Kernel:   gentoo-sources 7.2.9 (genpatches do not touch this driver)
  Good:     7.2.8
  Bad:      7.2.9

I can test patches or run more debugging if useful.

Thanks,
Saurav

--
Drafted by Claude.
