Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF8B3382C8
	for <linux-i2c@vger.kernel.org>; Wed,  4 Mar 2026 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636535; cv=pass; b=fxssL8/PNRqLg/SzVx3M6jV0PbqOVjc/43k9tQZLLgG8BpVyRxWxGnFRT7XJ4A8ZU4qE7yF0B7Jr3lzp5JkpC5vZ6/gPTjIDk9rOK2XA83/y4l8/NNC3/Jx4nKOPKmBN3zGHbO8+qiTI3WG3wRgvB9su8ZSlKbUaKzXC0FQUyAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636535; c=relaxed/simple;
	bh=HvZUHId3jvCqEWXcfw1WzgEIhl+2wFP10xKoDSa5dBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nTjgAxR9Ov7DixAUUrO/Bvk2V3Slk8V17aeZjT5dcAaKJKUeFh8LFkMYbQE7JPEiFUyh86s9rnNEBoCg3pq39triXig0FjS3uBF1JUgAjh1tJ4gN+yytFQNTI+Sn2FSFG1Xjq+SWQn3pYIQMzlKHKEFyeu92n6gaAMx5WTWjFwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GagjfwBz; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GagjfwBz"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-677bb1c3a9dso2401544eaf.3
        for <linux-i2c@vger.kernel.org>; Wed, 04 Mar 2026 07:02:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772636533; cv=none;
        d=google.com; s=arc-20240605;
        b=k00+ZuMZ3nt7HG+gbvvEl4ItN0UhvirJywrZ9RcPtrut1Ag7nUh0S6kB2oB49wfH3z
         Ea3Z6h/hfYcI6SBYAFgvpGrDG3piJBnk541Hgr3XZchdtiOLaFBEGVPnJBDYNBuN6cwa
         RMaSixHjPH8PZ31kmeGt2ONGpHTIn5EVklH67UCNYlTqwxn5/4SPQ0CNAXWVNDpG/HVC
         m5BvnGlk+/gv84SAM3u684ofBEUNCkzoTlpNM8YuDndZ7PLDlodOv3rvhwaKCtPGaOJM
         BJfXJdjtE3bt8xoqr3hHytMxRL7UUkuJOCV9c/2w24xyFP2AtmibICO7RGkZS8gX/toh
         1XYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=HvZUHId3jvCqEWXcfw1WzgEIhl+2wFP10xKoDSa5dBU=;
        fh=bzCIbAMP/Pi0UINroRoLvMkJUOmBk79Mh7UOj6YbYck=;
        b=FeRET4ACY0Rx5+mtk0XuK3Iyv5jTHELkgfSGtgkcXR0dHZqpul8+1YS1VzyCjliNj3
         YdHLTKcMATOd8RmDMjEy1N7aq5BdvjGM1MEGuQRZkG93rxISCJYc7TjljPZ1lxHrp5Nj
         a6QP4iZiVvBaIkkclQ6ltnSBbQu1pYaOUzXMhQiRTcy0sRTrDTfl07BVs6F2rGnyZOwC
         K3b2eXHo+PPpU0qOpT3G0k+9O70721h9z4BvsI0smeWLM4jKUR0VGfjIgQBPFPgu0Epp
         klH4qdYEsfEdQuMXpPCdceIn/Ds/Sf8TK9uQj8OsEwzDBvfQ3KdIM3TXgFbwU2bXZg0B
         SxfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772636533; x=1773241333; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvZUHId3jvCqEWXcfw1WzgEIhl+2wFP10xKoDSa5dBU=;
        b=GagjfwBzvPUrJUVgvH3hBHsrRDtB+nkej0xKO9BZNWIgNV3TGjDENKDbOwJvedun8k
         O6MOQ9eJyt2ZhCq+BfCmpm177ZPZpviiv194H1DLGkElyXxoS9Vyaoe/bVLK/qEOgubg
         qv4smHILv/4SX/aGhkyrLxD/pY3gd+ZZEnXTVgIOxGgX0qJHQY4ffz93t+8JY4DN+92E
         V4MzDP7oTKzVNezBPeVZAF/upsRYicX9vMemJPszTvLpbWd9MTItjFKwi8eQPPoLA7PG
         0h00/S1qUPVEygLIWN68l1d1r9ucThZC4TGNL4P0WAkT9nytf9l1AIehgtcZHzYEx31/
         BDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772636533; x=1773241333;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HvZUHId3jvCqEWXcfw1WzgEIhl+2wFP10xKoDSa5dBU=;
        b=YRQm0vL33NTmO0cjmjzyPKdoW3HYTHXISvj4uyp3Nhm1k9CfifL2MPykzFTZInB3v8
         z5UXDFualInQWGsFljM4cGI6j7qOThl+v56QK+NCT6PJ6sRjkAAeshwdtGGxsJMqFJuH
         oBZhJay9RFKjT9iqptIt1mpRnmbaTYD5x7MbVfD8q+HDsLZfzaTde0j7GFl0eSj4WEfB
         GV6m1G9CpXx5DxRfDM6Qyb+e1VlLKo/9xOcJ5pDw8JPz1V7/o+GMHLGOx2vkSi4kj6fc
         SiPb/wQmCKn2D9y/AcasrwHvoL89xJcpmU5W5UPbPAhOG3Eg5pDvZ3QakRYa0XgMm3q4
         4rXA==
X-Forwarded-Encrypted: i=1; AJvYcCUUnQRNO8cTDDbRgwtnakfLCwTeiVqGM7Kjq20Z1Ct/gLDWQLMPn45j/6IDNqPv7kiGKPB04enRHHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9iUHp7HL+REEuMAzg0J+/plv8hXStbBMEurzEU8bXXNieylYp
	JY8XdTZfDae8SZ1GOwDdzvPzQ/GtPYXrK5D3ZjL3MJaS8xhbwm9feDlH2mpqepDGQnUR5Dfzgxp
	1INBSdZfG2tnXy4S5JsRooyrEKO82CepHpTdY
X-Gm-Gg: ATEYQzxPlD5SXYGrtqi+uBPesI8/tj/zyfONtZVRYFPd+K4N2FCnLSAUxxlICQ4aKqZ
	jX8dCNfZkadrZGddJUxoWDSENEw30zNTlcLv2uu2eQExCW4AfClBryojYaCxOx1p1IkwmnHTSVB
	yCyk0aEDneLnP8oHDll0OKAVlCaF0MgJJI5yWUwVDSDD9cwBNi3lEsHXO+CMbdX9y246MH9FN+n
	zxeklafS+lYpccM1tTJMg7EuoYzM20gbjRNt2wU2fMHSA5mdrAVsc4KZb3SMKR8vXAgFeN7dpQZ
	Ck7+8rv3lYbKhXwrQIrr
X-Received: by 2002:a05:6820:4410:b0:65f:7470:38bd with SMTP id
 006d021491bc7-67b1e909f56mr888184eaf.58.1772636533212; Wed, 04 Mar 2026
 07:02:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANkKV92bTD11PCXYzz60WSxcP-0UCM8xtnY4_WraEwQx6TMjaw@mail.gmail.com>
In-Reply-To: <CANkKV92bTD11PCXYzz60WSxcP-0UCM8xtnY4_WraEwQx6TMjaw@mail.gmail.com>
From: =?UTF-8?B?UsOhY3ogTcOhdMOp?= <raczm0812@gmail.com>
Date: Wed, 4 Mar 2026 16:02:01 +0100
X-Gm-Features: AaiRm53WpMLirIo8D6jGIgns39aLQmDjbG0I0U5xvR78o8KaLNSvGnl4_G2CFPg
Message-ID: <CANkKV91Zfp_Bn_koM=Tb5vHQbog2Ja72C819aL-49kQ6PWA_Ow@mail.gmail.com>
Subject: Re: [6.18.] ThinkPad T14 Gen 2 AMD (LEN2073) - Synaptics touchpad
 remains PS/2, intertouch=1 ineffective, lost sync events
To: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This might be related to the earlier report from 2021:

https://lore.kernel.org/linux-input/3d6f7f74-3214-4c03-b352-a2a0d27ea42b@amd.com/

and a similar report from 2025:

https://lore.kernel.org/linux-input/b2d0af40-876e-4a2d-99a2-236b583e9497@gmail.com/

The 2021 report describes incorrect SMBus address detection with
i2c_piix4 on ThinkPad P14s Gen 2 (AMD), resulting in RMI4/SMBus not
functioning correctly and the device remaining in PS/2 mode.

On my system (LEN2073), the behaviour appears very similar:
- intertouch has no effect
- "SMBus companion is not ready yet" in dmesg
- device stays in PS/2 mode

It seems possible that the same underlying piix4 SMBus detection
issue is still present.
