Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE373DAAD2
	for <linux-i2c@vger.kernel.org>; Wed,  9 Sep 2026 07:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939733; cv=pass; b=UhFMrYZR0ZA/hSR0VWb3l74uosJyLvriCsr4uBqc3kJAYaCBIya+OScJeRgiQFBWp6QQi6T1uItZioc9n8855b1MzejuzjyHNPSBR7nFAzZkdyoML3IVWTW1ktApQxvT3Js/U/xQMsOm+bmeYjwkix1EYbL6S/qdJH4cUQ83OQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939733; c=relaxed/simple;
	bh=3523oMidcQmtypT8PpooIe3em0q+Lkry14jI2PZd6R0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=phelLjm9egLCG0Li6L6SOYDWKeNJkpllSeV8VcsKQDWCsMjym0Ac7wuYrIgDOyTfv1HZ9KuYtg5SMcNME5WYWkNfDMxz/V4RJrPQt+y+g4TllXVLvASr2Z3ZKhHduA4MTajSjDsHEmaG9ycHqi78B9p2XP1yedH4SYDW4oxsM/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFOG1k45; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFOG1k45"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-86162c086f8so52916037b3.1
        for <linux-i2c@vger.kernel.org>; Wed, 09 Sep 2026 00:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788939730; cv=none;
        d=google.com; s=arc-20260327;
        b=UvgChqi/TBQMYTXxVs1O+UEaKNjgjla8b2ZtpBgp45uDIzTQMaqlnlSCEVBLqDbK2u
         B1Sk2FcYOVc9672qBRA0E+W94qGxYPtxnlcwj4B7H3F5HiyYv9D9UivaSXO/ZVM9VmUK
         f9NaQFK1MU1BjSymBiTdedgm1OxSCQBO2r5D+KfzyUk/GLBhrVSmdtjrM7gLVOaSm5UZ
         eaLkJwmzdpQz6/s6mL6mdyTA8VWiaT8xZGYwUtE4SHkX7ztwu1ojX8cUN7cQ/KgDMHfD
         SZzqQJE3GWQYM77fGYFd+HlOKDHrtw8sgPacLchR/Beelh4WRYgMyDbjGood1MaL0o0P
         Hiog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=3523oMidcQmtypT8PpooIe3em0q+Lkry14jI2PZd6R0=;
        fh=un4e4l9AWOAxcI4ZlhXiDKYrr/tZh57YYP39AZVtIVw=;
        b=PJOL+wQ7XvvdasxT5VjPGEQc2KnxaOg0IudPym10xjXTYyInuU2oemW6yafb6bOduR
         lrc2wZYwk98srZckHbo/1iSpc/oJCXU/7qRc6JPcDLCViItBuQBTsjSn2oGi2D6r1ELp
         /0o7h8rmkL915WRyF30zjrZsQKY3cfULqjb19/Z++PSjcPCvFnoBqvZjEEVf4ce1YQ9h
         nSxAWoIW8Cm/tFqv8k+nPy7kDP0FrGCgTfxBDMd6BAn3fVp8GHXBsAUgsrECAkFh/hoB
         y5OKxvvXFDnvuyWt43U9Q25xdrKOGsykNQNFL42aaF+fCRoO6N3GNmu04WNKGWOP1mLR
         O+ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788939730; x=1789544530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3523oMidcQmtypT8PpooIe3em0q+Lkry14jI2PZd6R0=;
        b=ZFOG1k45Lpv0l3/VgXMTjunwQ6GTosElQXSzDo0Td7+P+Spq7h2dDBZvcOYJ0pNQpo
         ypdlakuzJh4Cgxn3xMnHjpkNVs6grFtxV9a02RxvDR9IJgnSAJcafLnmp5vrEt2qJP08
         EfWrPeiNuK9P06U+dWITqQwq/xmgRxYfGld/N9/h9GrOy/v4JFu2s05hEzzBEwyT/XF1
         T4qSAhlVrJF15l9FpGoKKUm9rCs0XR2/4RI9tBtm2b+W6fdD0ImU7ixCgUepGfZPM8ij
         m2on/qUN5X3sNR9RyIEqUy8tDuKkgmk+nohu3L8E0hSndwkSqfjBO4lmkmMVjgYnPbB+
         eEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939730; x=1789544530;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3523oMidcQmtypT8PpooIe3em0q+Lkry14jI2PZd6R0=;
        b=QH8P/sajYy4S+OUdp4Nnf1mUshs25Tm4VmWeQ96YyS69QwTvJOPH+v0JlFdOlKz4zf
         AjK5NFTQbI0rDC8E440JqumkLVQvbslaZYJ4Q0j6bBfEETphNIxAdLS8BpRqcapOg+e6
         LxQUvpugkiyZOYB1VFpYzM5u3aPBgb0u/L73HPlr4BaiZ3m/kmsWBqG+QtSygPGH6pLp
         kbPcTokB8zHW39G+WDxudzJiTKpxR3APsXam2VdjzuZKAPBoXWR9s1Q5fG4kKrfXSni3
         5OiGj5NJQ+4syg56qfv56ct3bb+IQxmZROABGU3U1khRDd1vwtIOv8VoReVAF6jf+mh9
         ffVA==
X-Forwarded-Encrypted: i=1; AKwUvBzDSjD1e4WCa2Z1SjUWXcMipBep2sit0yPlnBVPk/82ND+AXOs/8/pl51cqVkOMpQSCj1Mkyxh6Evg=@vger.kernel.org
X-Gm-Message-State: AFuF++l+UKdtnMRF5VhuRAttMrr/qQe9voh4U/8A3Yz8H3VOMY7tEHSe
	qTPeJffjnpjpnkoCE/TBfREo0ROqOpIzjJfuhHBxmasAKN0w5524vRkJtemXhT1WPKj69xu7X/h
	Buom+FZP8izcAyVDb6o8Yrvgsg/hMrPE=
X-Gm-Gg: AYBFou0ftxt3+V+fweI0wDVWNwMWybtJaVqjVf/BO5q6apGdS2Y10ik9/Pr/ZsmLh/2
	piaQJejE62WOMDgZdMTZMtryvZ650F1uDdqnOVxe+Sh+3yCBmHsGgAIzN7HJZqn2S00XKFv3yLb
	uCeECdIZqJINzfPEe6bT3c7yNSwJeKgXWm7P5wTlW2xmOnt7eDH154HecDy7DBiPEhgR11iSRke
	uk3zPelAJrN2g0caEG/evx9ctcvZnklK9XeDX7NbE9RtyOOopXbCV4dYyYE6WhNRaj3l52rlgQ2
	JObQeNo/+mDzxa7uNsxR1m/NAy/wjwuyHHxEl4CX/FfIATHoTduPVxtWgp9OfpmshdmSpv0WFXi
	or3dSTBPhCMdR
X-Received: by 2002:a05:690c:26c2:b0:853:fc17:6054 with SMTP id
 00721157ae682-86e6c41ee8cmr133970117b3.3.1788939730075; Wed, 09 Sep 2026
 00:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: AHMAD YASEEN <ahmadrandhawa01@gmail.com>
Date: Wed, 9 Sep 2026 12:41:58 +0500
X-Gm-Features: AcwNN1XiJtBTcT3xawx5grusG2FkFugR3RRjLRX8Nh8TiraKn5Uhw98BhRMFfcE
Message-ID: <CAFJ6yro2PRQAsNwDMRmU8sve6nrXXWVruStgyYVRMcYeksdufQ@mail.gmail.com>
Subject: Acer Swift SFG14-01 Camera Support not working on Linux
To: loic.poulain@oss.qualcomm.com, rfoss@kernel.org, 
	bryan.odonoghue@linaro.org, vladimir.zapolskiy@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Acer Support and Qualcomm/Linux Camera Maintainers,

We are working to enable the built-in RGB camera on an Acer Swift
SFG14-01, board Bluetang_SX1, with Qualcomm Snapdragon X Plus
(qcom,x1p42100). We need assistance identifying the correct hardware
configuration and Linux enablement path.

Current environment and findings:

Ubuntu 26.04, kernel 7.0.0-30-generic; device-tree boot.

No USB camera detected; the internal camera uses the MIPI camera path.

CCI1 at ac16000 and CAMSS at acb7000 are disabled in the live device
tree, with no corresponding platform devices.

CCI0 registers adapters, but an experimental HM1092 probe returned
timeout -110. This was based on an unverified sensor configuration and
does not establish an RGB sensor or hardware failure.

No RGB chip-ID has been obtained. No media/video devices are present,
and libcamera lists no cameras.

A controller-only CCI1 boot test has been prepared but has not yet
been validated on hardware.

The Windows driver files available locally contain multiple sensor
profiles, including imx688 and ov08x. We have not established which
profile applies to this exact unit. Existing experimental GPIO,
address and power settings are also unverified.

Could Acer=E2=80=99s platform engineering team confirm:

The exact RGB sensor and camera module fitted to this model/SKU.

The CCI controller/master and 7-bit I2C address.

Supply rails and voltages, power sequencing, reset/enable signals and
MCLK requirements.

CSI interface and lane configuration.

Any available Linux device-tree configuration, driver patches or
supported image.

For the Qualcomm/Linux maintainers, we would appreciate guidance on
the minimum CCI1 configuration and dependencies for this platform, any
existing SFG14-01 camera enablement work, and the diagnostic evidence
needed to investigate further.

We can provide the kernel boot logs, kernel configuration, baseline
and live device trees, minimal CCI1 patch, and Windows hardware IDs
and driver-profile details. Serial number/SNID information can be
provided privately to Acer.

Our immediate objective is to bring up the correct CCI controller and
obtain a repeatable RGB sensor chip-ID before proceeding to capture
and libcamera integration.

Please route this request to the appropriate platform or camera
engineer if necessary.
Ahmad
