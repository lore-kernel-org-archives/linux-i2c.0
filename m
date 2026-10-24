Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877621;
	b=BhYbJVMDs007JEdTcdiMnM+Ea/8Urwt443WlDXvb1jpWlTA+Ek500N2dNZcvKq70dMAM
	 GqTYsMIYfSbXhIUvzW7edhtdv9cEIOlwxNRzX7zsOpVYLsp4sY2w9QDXzybrEI2nkCdUB
	 UH0yQaqLl9jOgIHfu3EJUHAdSSqA3lpBGBhBbQcbohjME6G+2UJmYyPVhnU3ye5NacFcD
	 QvFUjYK4m3RLUrt6siMdGhg/uBpjjB2u0YXPtNIEZYVtypYbb9mXkgF//09dkWpU7I1U0
	 4oiz77KoJeNlSIBO6jcGJej6tkZxAjJqujHFhr2sud5SmWtPLQS3ZSr+AoWNvvsw82Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0KswdmbKVSA5fjmS6TP3KWbeGyCgT1MgBNiKyDDfZYs=;
	b=LxvDuFIpY70m6YYQOij43LcI4BiV7VGa/FM7NvR1RDOfAMkmFxGFULDZfSi0K86Ia/fS
	 tVxV8uV7g+eeNAqVw40c5HT9A1ZfT2rj6BYQzJlECFJ31OPH5Hsqr5hh9lVCMQXn/d7yd
	 cyWSQEKsxtkMPX6f7LhNIpogyqnCkMMs7ZI6/bskdwrCSWnWAuU5HzdJ4B4kbO7pvCbDj
	 CtQf9DW6X9/1zmcEyKFdAi4Ta1r0bXt3bXluFLSrUT8Tt0YNDuLaX8oErj31T9CGtd5Dt
	 RP0pAlb1gV2FT9nozLH/bdvkCc7hi1mIB15hsSN9II42U93768wbi9DzYWP2D+lSeqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=zCt4oLyI;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B07606A31A
	for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 21:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5B07606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=zCt4oLyI
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so17867995e9.2
        for <linux-i2c@vger.kernel.org>; Sat, 24 Oct 2026 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792877614; x=1793482414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0KswdmbKVSA5fjmS6TP3KWbeGyCgT1MgBNiKyDDfZYs=;
        b=zCt4oLyIkkf1CqfeSXRB2mIw1vUURk2wMEQclBWujMGgge8xHAnWmq7H82vRauzL7y
         FAoerBqlzYJKFOkvh9Ejj4giXXpdZn4i7Ev5wI7xnyezfGiOdsRZ+AAGQdEc8q9gaayV
         k/cfAIp+VhKqscjhPf1Xn9g8odsIFHNKPHpCp6MFFGxo3Sip4v83pVWapXmdfIB2/ylu
         456rlPZwb6DVAzRr26myyhB6+uPJOEain+cKR9mpOXVbs9jeMyzm3hcJcoEPX8+82wSj
         k7H6pHmaYuMEbsDBCg5iqIEjpGworu3hpgfFHyvjNCu7joTAVwDp60xcOn8lZQvLwcby
         P5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792877614; x=1793482414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0KswdmbKVSA5fjmS6TP3KWbeGyCgT1MgBNiKyDDfZYs=;
        b=UF9Bjljo/eAJu9CuYyu6wVfsc53GwjSuM2N4gln3O9TDKIM46CInxiottnk9oWl8Cw
         OJKZqQMMRdQ8FYPxdLPTSWQ5sg/AthdXsNXaPuzb6KVRdLnCmoCei+YSSexMtDjZKmAK
         mOrxXuPAkNl/vHcLtJC4lAFSJ+kO6yF5NYU/DCOacAVqGeafGIozzEjW7kpqyS7uDbxO
         7v7ejDOaBk5K65gsFwzMsJbyttHQNbyGJqCPPxlPijaoU0UrqJBW+OISOhCwj6OVFatY
         aI4s5wA8JZi/BoVNBevczfHowt6tpx3Z0rN3Cz1fA0ujhFzJnWHk5HmOjL0zf/6KJKLO
         4cHg==
X-Forwarded-Encrypted: i=1; AKwUvBwJFlnqszw4vqMaa6TQHx4UpMb78q/uDlDoGu591EFkyC7vS/HNCB7ba0cM1ZBmR7VceuHXGuL7Kyg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqzdPniDpE0q3oj/p4K9BSPf694VHpPkAy9hfEEx0DGceP+gjm
	HwLHycXLqO3ry7HoW0h3j3fbW3NBqB2EzUXDQeFu40X7jmZJ/426snZowKNCMYXb4v4=
X-Gm-Gg: AYBFou1x5q4dKgV+cjeErYa92Rt/FMh2tiwAqazT/VQ7ZeEIFi9N/tvdFkL5xL7/YTN
	nO8gQb9gM74gIzAfLAjlGxGpSLsgn0hEDimbxKl2KV/h7tRmHAuoyfXk6Ki3Bw2FhWTxGdgCDbf
	QEXJhx0qlc7SqGgtFYXzoQYK4prdYl/StBRVyEog/tau2O4tdmegH+m3vPdlqnCaIidfghW7GhA
	ZdThbPrnf+/MsBtMeZveDnIGrZKhfov32K47p5OMn8yyFBEGP7j59CM49YJVZ+/ZMNClZvLlrQv
	hbH9Re1tHHp9TAxJxGAKBvIZ2UL1/tQjbgKS4JVAKu+a9vNfcH5VLzM5jBMRbW/UAOnNTynq4KF
	cBXlYmMYO2cQA/bErYIsJXbluHDbGd3XkQKMuDohcflikHVk3v27bpmqLbBkVz7gMecPk+MvzKV
	D/Aqfk7bT+6QxVPrOI9uPOsT+ebMfWMkYaY318de5AcjXbz9A9wVZXQKBNwj7JjlOCq0nV0OaLn
	5fNCkFM0kUQetjcuO6BZhUtfsdLkumAlukqOSvcDF331iae+lfFV1YNQlYpetVfHBCP6s98nUkx
	Sm7oQU9xBGG+oiYXSdU++pto7IuL8g1XsmHqg/ijdXGHpOWRtoSo12rJl3gBl6/DPuIel8rxW04
	=
X-Received: by 2002:a05:600c:3b93:b0:4a2:397:73fd with SMTP id 5b1f17b1804b1-4a35ac96004mr48075955e9.12.1792877614164;
        Sat, 24 Oct 2026 14:33:34 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bdd59sm50531495e9.4.2026.10.24.14.33.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 14:33:33 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: "H . Nikolaus Schaller" <hns@goldelico.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	Paul Boddie <paul@boddie.org.uk>,
	Andreas Kemnade <akemnade@kernel.org>
Subject: Re: [PATCH 2/2] i2c: jz4780: Add support for the X1600
Date: Sat, 24 Oct 2026 23:33:33 +0200
Message-ID: <20261024213333.51569-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <465127C9-AE28-4F01-8721-8D819258D45C@goldelico.com>
References: <20261023081452.44118-1-olivier@mgcrea.io> <20261023081452.44118-2-olivier@mgcrea.io> <465127C9-AE28-4F01-8721-8D819258D45C@goldelico.com>
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

Hi Nikolaus,

On Sat, Oct 24, 2026 at 05:00:10PM +0200, H. Nikolaus Schaller wrote:
> Comparing x1000 and x1600 programming manuals I was not able to  confirm
> that the registers have moved or been replaced at all. They even look to
> be the same as with the jz4780.
[...]
> So your problem seems to have a different reason than the setup time.
> But spike filtering may have.

You are right, SDASU did not move. The write to 0xa0 only worked because
it shortened the spike filter.

Measured on the R1, driving single reads by hand with the filter set to
each value: 1 to 100 APB cycles works, from 110 every transfer ends in
TXABRT 0x1000. SCL is high for 102 cycles at 400 kHz (140 MHz APB), so a
longer filter hides the controller's own clock. When I first hit this,
the R1 had been started from the vendor kernel and the register read
116. Its reset value of 1 works fine.

v2 drops the X1600 entry and programs the filter on the X1000 and later
to 50 ns, with your Suggested-by:
https://lore.kernel.org/all/20261024212520.91401-1-olivier@mgcrea.io/

> But I recently have seen issues with i2c on x2600 above 100 kHz so there
> may be a general bug in register programming which may affect all processors
> with x1000 and above.

Could be the same thing, worth reading what 0xa0 holds there. A value
left by the boot loader or a vendor kernel that is longer than the SCL
high period at 400 kHz does exactly this, and at 100 kHz the high period
is several times longer, so the same value still passes.

Thanks,
Olivier
