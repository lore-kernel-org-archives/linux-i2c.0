Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851976;
	b=J5Vm3OdT8PEB+/xD9KduRfUyV8cvMhHwm7QUwJmRxnBenAGJLp9VLoBiUe3PnioAEnav
	 1vIYCZKf38ZYZhCmEZve1Jn7rFZYTid7MPaMZME7+V+LPG+BAItdHdkDcP4+/+ZWwP+FY
	 +rvlx7dTfFw6FT6bVdAGqlkLc5Ygznu5/nHNZov8ARDx0hy8vmH3cf1njBen+PnzFfHgU
	 CkWZmb/0lWgO5YOykEo3zJAtAKewZ9a4vbcQPJB3y7GALZnVc6hc5M27C+zkj1abxy5bB
	 1NqRY5+hpKOwFG4MMoxwP8m2GrF0++kTB/dxMctEUmKy+Nni6uLTkR+VSf0tbBQKr4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851976;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+nvE593UQ9d0U2IPo3a1ExhnUFrCrkM14breEsOZj/U=;
	b=bauQLTyIn4Jlb7W6j0nWERRvx1+eI5HzXwKsaxAruoO7mhXbyUx7sU+eFj49+EKCwatj
	 deD2azRjC2yS3Ni7ePOAz45Xon5YB1ZEpQ3j6OM3CIeEptCprF/BIV6/bxblTULpzmUvW
	 QJwSUZqVMweS7rpeiA6rG7y27Io/ZYtgLCMB3xvI83ZhJiyfpACob3wtWDPmd+J/q31+2
	 b1kjhhhIKfziFCUaMruOI2zBgpwxxmD+r+3TOuzBB8GX+N8Rjo1X8ofPGK9kiygQAN80H
	 AzQ6cDT4kpVh9uFQfyaO9hbBBLFHgPK5JDsLbjLRs68idoJYM+3WrbZYKpQT6f+60lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tUGhZBRQ;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837E606A33D
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 17:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C837E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tUGhZBRQ
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so1237375e9.1
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 09:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794851973; x=1795456773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+nvE593UQ9d0U2IPo3a1ExhnUFrCrkM14breEsOZj/U=;
        b=tUGhZBRQZ0lPiurakct8TUDeJCPJwiKNmIgg2g/8DtVBDzVQERlreUcHlb2e73VL1+
         BpVMRbdh6Zwu/OaPuoEyYeuaJWsRqfAztKK6tmEwC51Qa+g0WzfNa+L4zs8s7xc58Yqa
         g6vb/aU20b86L4c88uA+mzwEeKNAjmQx5xlqNJAQeD6Q0eB+ntYHiYWMTUS+fUDXWlNP
         PGaVITVZgITbxk9Tu4dZaf2e1eBJIVK5mMvVx/QmerATJ5dqXyWtvjqwPjaa2p4J5X9K
         kHusHaMDMztT9Dj05Xck3P5pAK+aFlRvhVmnveaMZQHGmhNdO7UqRVojyfKHALpJ1VkA
         pcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794851973; x=1795456773;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+nvE593UQ9d0U2IPo3a1ExhnUFrCrkM14breEsOZj/U=;
        b=NNQ/bJmsZPcSr5d+fpU1CH44xr14bR2zKoeXZBqfSvs5bnmcqsn52s+e81BiZhucrS
         WtqKj2NlEzyQTp52UKm26/EfVOVhA4TZ6CMcJOgBhs0tqnywNfIemHY8jDb+gx0ng5r5
         rfLEhUweP9eEtyJv+ataI0Q6sPSeaKyDKnyJPIIfnTaa8UL6VpzzH5TCMgJa1B34FV/I
         PRuP9XrlL9sxG4c8QmkpI9c/1mUjYraz7ZGY1mTbRGYWsArBw7VohEvGjykg7aKuaX2y
         VVKO7npKVZnRzSjTBCmkAscNwOSxWYPEaYbHSzau5UrxopvAgZ0xLIvVg88LKuBUx1dy
         Fwww==
X-Forwarded-Encrypted: i=1; AL+hErFVKFd8mk24czHZe5590uJcfBBFpwegq1rdj5jHjP9OWY4AUVVbDJi0Y7Nj1484tXJmQRPqc0FrOMA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iYTUckdUgS7lGdLo6U9nyuPps9diuDrK+Z4UxhuTmAyplAH0A
	tBBMKEn5ZH1PPgWkhJ3cD06DK4p9B8RD1eLp7ursw8i2kRuXY0kzDo/8
X-Gm-Gg: AYBFou3yhDmPEkyrIkahysO+bIyDYQ5rgiDBUSeD7Pu+wXPX9Mp6yjEseyAOIUN5uGl
	Wb5qLd7CWXwwHJBcDMVN3ii44aEBfUxq6/qMdgOsdtzasepYKztXezZ7EYHeCPslQQ8VZvGa38F
	Dn4tY4noQAzTGYXbTMSMrtsF54pfVMpsVEKMiNI7tGd0Sz3Lhp9y6uX5xKGMLcZcHrTgp+xbMU3
	Cix9Gc1AojYdVeZ2BlvmwP0FTJzsAEyFGnQkJf3YJpF/OOGtiWR8IsV6QVFQXXZVNul4gPo7Qy+
	TtIjNn9G5QEMb4Hp/E9XINTuOs2P+dJLVRP+H5qV7dlWCTS2mOQuQ5d4FMdu5cXx7aJGsMSNopZ
	IsCUPTX8T8LWdI1RZO6bzXU1n4eZA6m8qMsjxDsBZyjb9ZujGRsED17gc7teplhsUFO4CQVQLnY
	qegScmqnD56t4aqeYvg0uFRSSX5MZ/XC7qrB6liOhYx8URa0LxdtDxyaoHJ8Kzc1CxvUfuCpklq
	Px68FA8eI0iYM34qwNrSNOIxEZvUPM6J2EVZUeQCtRDOsBUTwzX9xpg24oTyiHc7iQu
X-Received: by 2002:a05:600c:678a:b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4bb78372a20mr8533235e9.2.1794851972940;
        Mon, 16 Nov 2026 09:59:32 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72::cb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f5972a7sm22431108f8f.21.2026.11.16.09.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 09:59:32 -0800 (PST)
Date: Mon, 16 Nov 2026 18:59:30 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Mehmet Fide <mehmet.fide@gmail.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	linux-i2c@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, mehmet.fide@screeningeagle.com
Subject: Re: [PATCH] i2c: imx: acknowledge the count byte of an atomic block
 read
Message-ID: <avtEgpw9YpIzCj5p@eichest-laptop>
References: <20261116122707.1349139-1-mehmet.fide@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116122707.1349139-1-mehmet.fide@gmail.com>

On Mon, Nov 16, 2026 at 01:27:06PM +0100, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> i2c_smbus_xfer_emulated() sends the read message of an SMBus block read
> with a length of 1 and I2C_M_RECV_LEN. i2c_imx_prepare_read() clears
> I2CR_TXAK only for a message longer than one byte, so the atomic read
> does not acknowledge the count byte. The target stops sending, the rest
> of the block is read as 0xff and the transfer reports success.
> 
> The test for I2C_M_RECV_LEN was dropped when the read was split into
> i2c_imx_prepare_read() and its callers. Commit a5d0b9e32745 ("i2c: imx:
> fix emulated smbus block read") added it back to the interrupt driven
> read only. The DMA read never gets an I2C_M_RECV_LEN message.
> 
> Fixes: b460b15b3cc2 ("i2c: imx: separate atomic, dma and non-dma use case")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> ---
> 
> Notes:
>     Reported by the Sashiko review of "i2c: imx: test the block read flag of
>     the message that is read":
>     https://sashiko.dev/#/bug/linux-09e3015b-fc03-4410-809b-82964cdfac9c
>     
>     Tested on a Colibri VF50 on the Iris carrier, kernel at this base, with
>     the M41T0 RTC at 0x68. The core takes the atomic path only after
>     SYSTEM_RUNNING, so a test-only hook called xfer_atomic() with interrupts
>     disabled, with the two messages that i2c_smbus_xfer_emulated() builds
>     for a block read. Register 0x04 (0x13) as count byte: without the patch
>     0x13 and then 0xff (50 of 50, return 2); with it the next registers,
>     the same bytes as the interrupt driven read (50 of 50). With a count
>     byte of 1 (register 0x05): 01 ff before, 01 01 after (50 of 50 each).
> 
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index ccf08cd63151..1a3fc245d6ba 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1283,7 +1283,7 @@ static int i2c_imx_prepare_read(struct imx_i2c_struct *i2c_imx,
>  	 * Reset the I2CR_TXAK flag initially for SMBus block read since the
>  	 * length is unknown
>  	 */
> -	if (msgs->len - 1)
> +	if ((msgs->len - 1) || (msgs->flags & I2C_M_RECV_LEN))
>  		temp &= ~I2CR_TXAK;
>  	if (use_dma)
>  		temp |= I2CR_DMAEN;
> 
> base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
> -- 
> 2.56.0

Thanks for the fix.

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
