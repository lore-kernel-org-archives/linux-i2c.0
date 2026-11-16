Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853267;
	b=bHnB+xCgvKCzQLgPjHysB4N4rcwn5xHRGCEwEQSgM8PFdwUBbzTt7FFm1/5SyeEXNoLg
	 14a6xfkYT+HypCiT9N5mBXDepw9vuX2O95IaxGGZ8UqucQFNF6FCsRwwqg3foZUnvAQyy
	 gP3nNXa2X7FyGURlUEyNxfBFpb1OBUZtnhTqvROnl78D8UDeGY7m024YcPIn1Dw8kBDlo
	 ORAHDl6P1kR40zFWxPCpR9eXIrkBPuBt5qRMkvhSaabh+0hCH3CR0LRJaHtRAyweGJDaG
	 Zi9A56H2YeNuKWKh9akbsTDJMAy3UIKVYM1tmRlkmiqqs9vP+3zvTfGhfLzcNFMXs7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s78Uwu3z/zaPq9zjWKMnVssEWBtB7CSjhkYzBSt1kL0=;
	b=nOahdfSzlLt/YDQChyOGWlwy+ihz/E/wiz+TqrXwtJtNIjRGIb+D9ORLArqFHS5Uvyvi
	 nWe2X919pyg6Xx1q4UYtliT1LKMo5uG4xaL6kkBr7+bNMi7EAq9AFuTrCLP5jmDCJ3W5h
	 1+LDGDcxDfNSNBvgIiPRDVRf6OeEZcY8QVXSZ70HG1B4iAt0wiZLJ0lzOIIfgg3kBocY2
	 Vp7sNx6OimNVGYqilPVp3WkNZ/wnnkHsyzNexHAmwG2rvJ1HQ8lppB6ep8HVZTOo+wJAe
	 YB1Np/7tN0U5Mn7qKBtxPZDvLFdUqnQTBMDT/hcimPAHDwI3iaanFMUjWmfAYYFr9RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FpYS8cRh;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E012606A322
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 18:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E012606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FpYS8cRh
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso78393a91.0
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 10:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794853266; x=1795458066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s78Uwu3z/zaPq9zjWKMnVssEWBtB7CSjhkYzBSt1kL0=;
        b=FpYS8cRhj7TWzlPh8uvoPmp/VYcqp3L3+7gXWqu4nK8ecUw+jAbbkUcIxCoxvnhtOR
         nFycSVy+PoLeKYwcTOs8YcFAQx4n0Q+DMG1Qz3Sy44k9Q++UB/w7TDPG0K5qa+rL0rpH
         5J+13Shh7XikpW6RqRba6h1WOkx3/h9vimFVQEZ6UESXiqcWVdUuPYQLcDOWkMhcv8K9
         9bB0ij7ugic/imlAVr2WmJrz7XZCBrxGST2E57stn2hqP6sQFmvl6PpkmqmANhlZElEJ
         bvpXQuNDLxISRc1tHd7ekko+8JpzgeiLdzW5w19L9myCGGRNZFC51Ta59aLFIpOLDV8E
         1kBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853266; x=1795458066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s78Uwu3z/zaPq9zjWKMnVssEWBtB7CSjhkYzBSt1kL0=;
        b=vxC91tabvuXLVt915AXFbggifP+FzbDnCQ/X/7dQIDK2VSmDihNvYLj8Jt7UymjcOv
         Dbvq0Lw3PKHqSenC0UI0XkbB73GcmYso9NesHKPHbUL3l+9ZvipuK/yne8D2Lw2wnr6K
         KOGJFIOz4wMlBnVrUMI5ctJaoOD6x2c93TMCAF5Y9u4ILi4cAkeMH8OTsMNb8mMdjOSm
         oKzfLTd45EvcSHJb1mUy/2ZpG+Hz3OGqnuCC1+hrrwceRBpH3f30U1PpiJsXDcLcN0M2
         xalfOtFNs96oi6mhOv2p6uyOrzVhFQgYAWa+ZhNfINUwUaU2Pnc+ZscZCuc+a5ZvyxGy
         4kpA==
X-Forwarded-Encrypted: i=1; AL+hErFq+0e4mQd30tttzNaV74jGOijogVLDcWAMIQ3a7kamsr/w8/TwVGq2/J0YPVhoeqGZrUpnvOYHG88=@vger.kernel.org
X-Gm-Message-State: APuU4Z9b5K5mZF5kRtMfLQAautspVnw5gWBJOCMZgHWl65I0UTTwYVjc
	ZK3pkf0iE494VJdy8Dhe1SGwfJKaBK6kn5bnCsaWCINnY2JZ9ei6o7bd
X-Gm-Gg: AZFdTZdHM7kTmMD6kow6RsnleCoRHgNhdaylQsSDRHAznMQ1MQV95dI7+CvA1dN25MR
	EfDrU6EbfJiu/9geAB/KRa/7+ICHPeFXpyAEnZcnhIQtVdtwksjoR3elwmQhfTnoA5luWhhWNH9
	rqbxgfTYS9NQXK2KfaqE7F4PSJSCeMLtxNEHdsMHIGXHzq7d3XYi9XdILG0/R4FyDiqQ0zWLp/u
	7DCawYODEo/cR8iulIvjtYTTKnTxdLu2mG5kFtg7I83BDe2rC8+7vCJlrGfSKqQvXm4od4ettCO
	gPkjZYEPAhCs9Bj5pY6rTgNbDK7AxPUxXwtL8fr3/bpsSdm478Uo5h2WfC9VGxhnzD5KniujUx5
	pjItiaPrb+hARe+BYAIZ2VnIZKFgz8Q1gP3eyV9I1OsoMSV0MGdYvoTaVy4WPLkV+ClHP/yPzkk
	jruHcRhNboCFGUy0kuLf3jtVvnkP2V/2Uqpmj1Him9G0rkaXdt+SixAXjH34SAfPuacaOoxOC+Q
	XX7qw8IMfWLATgEuzoSjNEsAAQ8fWU7fj0QUi60M8Bm9ehaRB1QVnraclh2WnvU+sltr0/Qc2pS
	4ztTdZhMwcv0c34aHJ7QVsXH+pJG9NDcwb5Kpgd3xSFc78gruGOc2efe6puSZYK6F28T8evquSu
	//jf8gt+UOMAhuwrpd9WDqYzXBairYX2+LbIT
X-Received: by 2002:a17:90b:17cc:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3b3abd01770mr154654a91.28.1794853266130;
        Mon, 16 Nov 2026 10:21:06 -0800 (PST)
Received: from localhost.localdomain ([12.162.234.74])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3abe8b263sm376117a91.13.2026.11.16.10.21.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 10:21:04 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: andi.shyti@kernel.org,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michal.simek@amd.com,
	netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next v2 3/3] ptp: ocp: support the WiWi revision 02 Time Card
Date: Mon, 16 Nov 2026 10:21:01 -0800
Message-ID: <20261116-wiwi-v3-87afa10a8-r2-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179484681859.3136.5472457983791141613@kernel.org>
References: <20261112163333.12523-4-ahmadexp@gmail.com> <179484681859.3136.5472457983791141613@kernel.org>
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

Thanks for catching the second path to the flash. Blocking devlink alone
was not enough. In the proposed v3, ptp_ocp does not register the WiWi SPI
controller or enable its interrupt. That means no spi-nor or raw MTD for
this card through ptp_ocp, including no MTD reads. Devlink continues to
reject the operation. The existing boards retain their flash devices.

The static board match is 2163:1008, subsystem 10ee:0007. The class and
programming interface are not part of that match. Probe resolves WiWi
against the static table, so a dynamic ID cannot select a different
resource layout. PCI revision 02 identifies the register interface; we
still validate BAR and MSI-X geometry before touching the FPGA. The WiWi
XIIC child now has typed platform data and its own matching size. No cast
of another controller's data or stack copy is involved.

I cannot infer GNSS2 wiring from the PCI revision. The proposed driver
therefore exposes neither a second UART nor a GNSS2 SMA output on this
board. It no longer prints GNSS2 as a fallback MAC PPS2 source. The
independent external SMA PPS2 input is still selectable. This is a
supported-feature policy, not a statement about untested builds.

I also clarified that devlink reports the build ID as fw and does not
distinguish an active image from a fallback boot. Unknown revisions are
logged with two hex digits. The revised objects compile and the
board/flash policy checks pass; this revision has not been run on the
card.

v3:
https://lore.kernel.org/r/20261116-wiwi-v3-87afa10a8-0-ahmadexp@gmail.com
