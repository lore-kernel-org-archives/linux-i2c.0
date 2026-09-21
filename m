Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF864E325A
	for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010304; cv=none; b=gCZexX1xndsgAYBCmv+oh8glNQw8Em48vc41ypN/pEm7oRVay7nwdu2RKKmqbfHf6cv+g5M5A8906u2HhAA4buPROryigxrGScDf0BL3Dxyr/vOSk/PF6zTrVNBu/D+JUNcGCXe7JR4IY+3xBu7zdCAAADgvR7pBO/gddo2/IjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010304; c=relaxed/simple;
	bh=UE/E6CwtSRO5jTRXSvtyJcHoke+D2mQVa9MShYJdIN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUJRKeplunp0uwHkXZXs3XsgiLujvYd0LSkfVJQiTYgTKFluRBeq3KMTPY1SMdpNK6xNJ+H6Z05ok3KRd9KCtF1NWqDPvw4rMoig7Mpp0Su/hd5u/TioGsIcD3Bm6oIRQkhUe8TuvxBl4f/gY04+VI/Hn0gG62r1VWacVsSz1lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oQs6olMD; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQs6olMD"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4e4979c47so248450a12.2
        for <linux-i2c@vger.kernel.org>; Mon, 21 Sep 2026 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790010302; x=1790615102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uus09vYPEXHFApWCOovYoZZLizLBAtxcjeR9wZ/FY4k=;
        b=oQs6olMDkgYai7RNIo5dyusYz7X+5LUrKNH13iclFv6tXIWrQgaZ8+7J/5iZ41h3oa
         4fAbJDp3Hgnst2HJM5CJnkKSDBRWqUMuESuvCZM+3FR5gUuH7jKHWDuDKE9AJnloMktc
         rGyxh2QQ6G6FjuIkk4QldRtsb7LXNt6C19R0bTZWE2CUx57nqyGNwyJFd9nT3F1NsHPA
         OBs0qeauDUK4hI9A6Nc1xraGp3V+Gbdrb0deVfeJeYC3nhBdsmQeLhUw+X4NR6cLBEBa
         WI7+fBBZ2FVRKPtexU8Z553LunxzYy6C8U84oTiy8xpOBLHuJk7vfNCSfLRSv1V0YMq6
         iHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010302; x=1790615102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uus09vYPEXHFApWCOovYoZZLizLBAtxcjeR9wZ/FY4k=;
        b=Frlb3snbxPD/qswJSGzjk+ebAmFInbA6oUkrO5D5mNpkos9FHl2pXl9IYcP/55njhC
         m1aWcAfwYyVMV+S9lGJzhYwQ3UMStSfRFHZWcZV0Pyo9gQT/XU0+AsSpC5PL7+PgjJdh
         FqyIsNXR112cBwJ/Pkojnt+u0t43hCPoQC+lOw/CxoR1BvdYpvGcomHMzvnjvtvhq3td
         MtFeiYZ61xuo11RKdOW2+tFfdu7VhocG80awJH0kNy4s5PhMjPyAS/Xz2JBukDiffaDw
         G7Jm8tqyc2qZhN3bxZixCGrKloCMe2y0mPDss1GV6dTtkUTKVI2VNxnhuFLwouyGX6Ve
         H+xQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRdvOrE+rAEzKudfwcUSzel2ipYjJeWZjoraIyYQ82npW4aeXUAWegY1CtNV1DNcdQNHh0022pIKY=@vger.kernel.org
X-Gm-Message-State: AFuF++l1hLofaArnd6e6i8dFoJNcL8VlAQiDoebjgyU8xFsVSQ/hNbA1
	EU7FQfg9m8Bbozbvn8sJjHGwoXdKeGRSj8CbzlwRYIUrrkIL4BEbsTYx
X-Gm-Gg: AYBFou2/etVaDKJu7RqinuYWcuP7bdlRHx7ch0ygPSjiXFLabAZ8mg2C8/7EjWHXcmX
	l3CNQpdEjvr7oXczE5u2hrU4Lb1zcW083t0XyQWhDgtsSbHsIjLmwNNmmzoSZs3h2fD9pfnDBxs
	qvV7y0T0WjkzQGYacrlIbQ3vXgabYKVgrKVs+dTrIJRv/n0IeSifr8orncak8gcxQ7170X0olTV
	weG09d3K9zGF1EOLxCaznwJp5i0S1BPRAhxBIFp/A3tuBnnhAd+t1Buz8S56O/myV3O1U/A7JCm
	+WhdYHIzQKoRMQM3cUPYLMKCe7uslj0VwVqbr4OC7/ZpR8/Fo5QOoq6/z0Isd+6648SSoUr6S7U
	8aQbbqeeyrQ7vqRqplt/Ckhu6uR9ILqyiywHXriEbYeOngWXt74osQUvuzwFDakyn5t9w/seXDB
	tGGIIsZFDhjoistF9K7mQw2DqeKWstJ8JkM9B/nikgU/lWnBFtuC9WXXn04Z1zHrvSTPFFZ5jiz
	gAJ/p2ThKXfVDsS6zat+PK+PUlrNFcAxisd2ksd6TZNIYhW8ifr0aQl4STziTMERs41MrV3UKnU
	3H1quxXgjJ3dFXlBO4C4
X-Received: by 2002:a17:90b:254a:b0:398:a2e4:c784 with SMTP id 98e67ed59e1d1-39e5940c49cmr20845132a91.1.1790010301926;
        Mon, 21 Sep 2026 10:05:01 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0670b410fsm240975a91.9.2026.09.21.10.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 10:05:01 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the queued transfer
Date: Mon, 21 Sep 2026 22:34:56 +0530
Message-ID: <20260921170456.53354-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921120526.GV106095@black.igk.intel.com>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com> <20260921120526.GV106095@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 21, 2026 at 02:05:26PM +0200, Mika Westerberg wrote:
> I'm slightly worried about the latency increase here and the fact that
> HIDIOCGINPUT is pretty much same as HID_REQ_GET_REPORT so it's not only
> hidraw that is affected but everything else using HID_REQ_GET_REPORT as
> well.

You are right, it is every HID_REQ_GET_REPORT user, not just hidraw.

The main motivation for this patch was cutting the wakeups from the
interrupts, and I should have made that clearer. The /dev/cpu_dma_latency
line was just to measure where the extra latency comes from.

What the wakeups cost, measured with a 21-byte HID GET_REPORT at 142 Hz
pinned to one CPU, display off, 32 reps per arm in randomized order:

                        psys W
    idle             1.87 +/- 0.28
    patched          2.53 +/- 0.17
    stock            4.11 +/- 0.44

Against the idle floor the polling costs 2.24 W without the patch and
0.66 W with it. Paired saving 1.58 W, 95% CI [1.42, 1.75].

So the added exit latency is the package idling deeper than it can when
the controller interrupts once per received byte.
