Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113882;
	b=rZHnt3e6dIavdBzrsGimMSiuIRticNYhwoiEZMLEsMzPHZ83qP9QclNOggaapXNc4gMF
	 RvO4lr9e9TZU+ygmXBoYzRW7k+NP/Q1OTcgq0s/2wE72itulLSfeyZbtoVytl0rxAViTP
	 JFngiFfjfF7EySg3otGfdbgX1Ndz/t1sOt9KwouT3cXIjLZl2LQ8bvwODmUNgkfjfoFAS
	 0PGSq2T4sj8PRSPgBBsZakQQccAcdsRQLcaKfKukK4LsKgAhvseMBVVWDDI8rfbS7IFZ5
	 zx/kpQBCia8jmVYTB/OI7at01MZ/ZZiTtXALyxi/oP3dSn9q7Xh7Xi9KTPYblPgOFLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113882;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2H2ujk4pMkofjrrxTD/0OLd5M9zgZ4osSGOPOf/44rw=;
	b=ZwBtRlivfjMAw/VjvcUSVTn6jv5T8un/hZpi5Gyo0VoO6PTKiT/CQAgUnDOjQEfAiNzM
	 unEkypSJkTjloD22dSg02uKp7gHeTnDaOJ284Jv0Zhdk4MqqCS4stoW5HmZbiMG92FEjX
	 EOi81tMDAVomQQzqeHrvYOR8LAdb4gfbIhx3kj/fmmCDwTVolb4LtB51DbPqL1E/E7ygn
	 F/Wnr+j/6ZohGA4kU0Q7tAZHoTkcdaEFUIygYLODSH3fV/G8f90rPeg0k806bggrjJDAG
	 AsV/8ytkpXKCbBu/EKsv217nGtw/kT8/qr0ge7uw9/ReQIz5FORn3+c53+fQNs9fMwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=APIUpFI6;
	arc=none smtp.remote-ip=91.218.175.105
Received: from mta0.migadu.com (out-105.mta0.migadu.com [91.218.175.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688E606A32C
	for <linux-i2c@vger.kernel.org>; Thu, 19 Nov 2026 18:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9688E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=APIUpFI6
X-Envelope-To: linux-i2c@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/kMkRCy9H1vl6y0EZSX58RectQkIJBsV5pNvyHexP54=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795113879; v=1; x=1795718679;
 b=APIUpFI6O+EsWur3vIqBq6FHT4j6Lftc/879eFNEb9HY31mw15a5es92FyE2I29zBBOzF229
 8I/dgnFyfFcIDrpEmXe0OaxQWGYeFy8MBX5yDgXIVRbc7Z7idJIbsv2RDSwelgllEod8gk48hvk
 vphidaFCoeu/tA7zO61X5YjA=
X-Envelope-To: linux-i2c@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2db01476e0a08c7e;
	Thu, 19 Nov 2026 18:44:39 +0000
X-Mizu-Trace-ID: 2db01476e0a08c7e
X-Migadu-Flow: FLOW_OUT
Message-ID: <890ef941-0c52-4e3c-9fce-70b11fd1b198@linux.dev>
Date: Thu, 19 Nov 2026 18:44:38 +0000
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] ptp: ocp: support the WiWi revision 02
 Time Card
To: Ahmad Byagowi <ahmadexp@gmail.com>, netdev@vger.kernel.org,
 andi.shyti@kernel.org
Cc: andrew+netdev@lunn.ch, corbet@lwn.net, davem@davemloft.net,
 edumazet@kernel.org, horms@kernel.org, jiri@resnulli.us, kuba@kernel.org,
 linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, rdunlap@infradead.org,
 richardcochran@gmail.com, skhan@linuxfoundation.org
References: <20261116-wiwi-v3-87afa10a8-0-ahmadexp@gmail.com>
 <20261116-wiwi-v3-87afa10a8-3-ahmadexp@gmail.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20261116-wiwi-v3-87afa10a8-3-ahmadexp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/11/2026 18:20, Ahmad Byagowi wrote:
> Match WiWi 2163:1008, subsystem 10ee:0007, without a class filter.
> Resolve WiWi devices against the static PCI table so a dynamic ID
> cannot substitute an unrelated resource layout. NetTimeLogic uses the PCI
> Revision ID for incompatible interface changes. Revision 02 identifies
> the LitePCIe/MSI-X interface; the Xilinx subsystem ID and FPGA build
> number do not identify the register interface. Reject unknown revisions
> and check BAR0 and the MSI-X layout before accessing FPGA registers.
> Do not probe a CoreList or require exact versions of individual cores.
> 
> Report the full 32-bit image ID as the running firmware build. Derive
> signal and frequency capabilities from the supported revision, not the
> legacy FB build-number thresholds. This ID does not identify the boot
> slot. Retain legacy version reporting on other cards.
> 
> WiWi shares the peripheral resource table used by the existing Celestica
> entry (18d4:1008), not its PCI addressing and interrupt scheme.
> For WiWi only, translate peripheral offsets by 0x02000000 and interrupt
> inputs by 32.

Let's not do this magic. If addressing and interrupt schema differ then
it means another resource table. If there is a way to make it flexible,
let's do it compile-time only.

Use aligned 32-bit UART I/O and typed XIIC platform
> data, sharing the EEPROM list but not casting another controller's data.
> Do not expose an unvalidated second GNSS UART or PPS output source.

Why it's not a problem for ADVA and ART boards?

> Keep the external SMA PPS2 input. The PCI revision identifies the host
> interface, not optional board wiring. Use hardware selector values for
> WiWi DPLL routing; preserve the existing behavior on other boards.
> 
> Enable the three UART and XIIC inputs during probe. Reject attempts to
> arm a timestamper or generator with -EAGAIN until the timing gate write
> has been flushed. This avoids relying on FPGA replay of a pulse caused
> by a userspace request made while the gate was closed.

Why is it a problem for new revision but not for the older ones?

> 
> Do not register the WiWi SPI flash controller or enable its interrupt.
> This prevents the driver from exposing raw MTD access to the golden
> image. Reject devlink flash as well. The update format and controller
> support are not validated; read access via MTD is intentionally lost.

Is there a process to actually enable flash upgrades?
