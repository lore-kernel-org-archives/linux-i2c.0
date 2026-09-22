Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF253ED08
	for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079167; cv=none; b=jH5FdxKetmG24GbHtBkvHpWciBvqF2AO33Z8fKLozfGIb7SCVQU03eRLi/JN3BtgmAuOuHPnhliqpEfm7C41yzDET56FhrDlQvR3rvmYvgC9hPio+N3cAvSikIRR3956EI+9mXxzVV7uLtsGmy2iJbLOzr2xJDyRlG0DEh2m/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079167; c=relaxed/simple;
	bh=QCx53jzyHh0wEL7VJuUKs+fphH56IILmzUrQEC9ChHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBd8bgCUImVdGWpU3T39lcyqhVL/HdCE6C7x5kcKSSPOXQpv6NcFWiP6aQHZfKsh7HZPIXA2SOpO256LMcH20IRMauCsTi6xLNO/7ZnczGieOm8iqIO0kLKg/6hToIqATM4J7px/h4z3dPX2SikhzdyTkjkM20ZsSDYv10+SrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLASV+/M; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLASV+/M"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1ab16a9ceso60819a12.2
        for <linux-i2c@vger.kernel.org>; Tue, 22 Sep 2026 05:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790079165; x=1790683965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QCx53jzyHh0wEL7VJuUKs+fphH56IILmzUrQEC9ChHI=;
        b=KLASV+/M5CYE2vKFvL8CXoW9ga+9eu0KawPkeM6Vr9UiKyD0kBai4cgKQR5Dm78u/U
         JHJJPy1NvUJFXlfwpAwI7SnXQSB6shLOg8tRsUoqxTplzNsf6YJ+wNx4fVQ4cLFNXGc9
         s7mpeuQiVpC4K/etXAPV7riqssQKrDS2wHldEGj2+IGYaOiaiYG+9nTiO8pBq1PhjE2G
         xgQ2AnA+YiGxVxUIUcCRo4qha+RMvwi7tg3mTDWDGoNJXVEwhfph/T0h8xY0ecloMt3q
         8iJ7Hn4qb5UHp5e6TUUV78ebZQVtFCwSsmEK5VEhEu2pmskVE1Wxwe+LxqGh5Pf2vrs/
         0Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079165; x=1790683965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QCx53jzyHh0wEL7VJuUKs+fphH56IILmzUrQEC9ChHI=;
        b=BbCG4238JeUkNC7uIdifNC+4TAyVDZaOgxXnpURy1AH4lakf4LMK8YiOJ+GzhyjdtH
         ZTgxS46mdhv02AnBGfRfIuXnuPWdFKUtHDkhi4XZdmEwwweppYQ0fhNgzXJl3SQ16jId
         cgUSRUtixBspV35xhOmsnQdUhCrFhJF2f6DbLoLW0Useb8s1UwyIc5moQSjKOLseYpqy
         oUMSbkFU3ojXnC8eYvO4vFxQ5aswiUY6O7JUhnKJFy2wmyIgQ0qWKPNRq8ISjK2SUmPR
         wBgzYwaonPdDO97wIlQZhwEBZKEG9RB1yz+bodtE+i3fIY2C0SgTXwLORbGvIQT9mx2i
         RYpQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7JXo/W4o4ceCVLUoup0y0YreJyIrhdq/Mn9waG3WmR2qIaaByCSMKnUV4Y6a+iQkbRIHKdHWKprY=@vger.kernel.org
X-Gm-Message-State: AFuF++ln7xCKwOwdslx7H11C9FZbKYNf+rLXobt8d4KHXC8h/nAzr+uk
	7Co3Plid9qnqytKsPpzvjdHH43McQ367nBRDGhwDgKfS27CJbXB+VZGC2vVuOg==
X-Gm-Gg: AYBFou2493460qhfvNd5f4k5WwEMbiiUaUP2qN57PqWNJb+GxR2zPKxQ7fHXwESnuLv
	xQY3nfapBueWpSon+9oy9wpkpgUgiNjeIN5/D0ot5lF5BSzWt8wF5rJ9E4OcKqOXP1yzWXAXx9n
	ARqDoRZi0lhe97ax6cbT67PA3OYgxeGLHPFrWYrmUgPUZhTmivg7NOEFdlhJkdC94XQ8vPQ845t
	hLWA3HppzZiFmq1KuyNPUlshRxrYFilJyxssOgaYVdSJ10Bk8Q4w0tMP5Iui4OkyhvR5tMXuy9g
	L2qiq6g2X7Go6Mxr/PZjxx/dS3GBHEHCvtPBmW+vA8y2iVRu7xiVwSMhsV5I6ojIy5WFbx0y2KY
	h/8LS2uu3UYMdMXAoHWpNBBosM0cemhWjeBqxfaJMINMIpxUnATsnqJS3cUGyuYpOHtzksEOK2r
	9NER0FzeWZNslIUJpRGGHpBJyd6LmqEkvUAaLbHWLmlPSfBuC5C/YRWdGQcrmwRTefAd1SBSoHS
	MTwYFPNoo/nSwZvuQMfim0E9CqPUZZs8zzGWNxQ6HHU3UbHV11V4b+EKf16BVEJMIv4Tafrzwt8
	RdXpysyGmgNHN65WCTrgFwIKS8kd/g==
X-Received: by 2002:a17:90a:da84:b0:3a0:238b:db4d with SMTP id 98e67ed59e1d1-3a0732dd66dmr1810985a91.5.1790079165337;
        Tue, 22 Sep 2026 05:12:45 -0700 (PDT)
Received: from cachyos-aura ([45.112.148.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f29d8762sm5091159c88.5.2026.09.22.05.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:12:44 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: designware: size the RX FIFO threshold to the queued transfer
Date: Tue, 22 Sep 2026 17:42:38 +0530
Message-ID: <20260922121238.46016-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922065041.GC106095@black.igk.intel.com>
References: <20260919232647.448748-1-navonjohnlukose@gmail.com> <20260921120526.GV106095@black.igk.intel.com> <20260921170456.53354-1-navonjohnlukose@gmail.com> <20260922065041.GC106095@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Sep 22, 2026 at 08:50:41AM +0200, Mika Westerberg wrote:
> Yes power savings are always good but in this case it also affects the
> latency visible to the user so we don't want devices like touchpads become
> "sluggish" either. Do you see any such issues with the devices when you
> have this enabled and not using /dev/cpu_dma_latency or any other interface
> to limit the CPU low power states?

No. I have been running it as my only kernel for a week with nothing set on
cpu_dma_latency, and I cannot tell the difference on the touchpad.

This patch increases latency by 0.7 ms on the mean, which I don't think
is easily noticeable by humans. Against that, the i2c traffic alone cost
2.24 W on the machine I measured, more than its entire 1.87 W idle draw.

However, if anyone tests and can feel the difference, please let me know.

Also, i2c_dw_configure_mode() sets TX_TL to half the FIFO and RX_TL to 0
on adjacent lines, so a transmit interrupt moves up to half a FIFO of
data and a receive interrupt moves one byte, which is what this patch
changes.
