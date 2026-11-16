Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853505;
	b=TLnwYimVxD37WcP2bg/NXYJzPQD/L55oVjxUSmhFXg3i0C5AJ2RiyX8BPmNAFPJBgK57
	 rSxw98qLEvA8ENb08kkOxmMdZWmLhtZpWLLW4X4mbWlAG6vLzuCKg48fZAtkYp6tVk36V
	 RG6Uh+Diht2hZL13tcBrp2hJVNzsISay5lfPIdXUHmOPKpDM05dvKkEQyNwvKuJ5yQfNa
	 0K/mu3J29FcaJ362y5wKTyviAxlD/KcLWvgAPSRdvPWXsRGnKQIAMhTpyMkyqLwJ5kQCA
	 Z657vJkF6MlUmDkKExUnK7FQYAyMfMySgidEVrfHPQ8WLS3Bvct8wgYZ2dtFNhObi2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=EjsiR+6jJ8ZmBsAFEuHSjNRWBiCgBYf83KNABOGKFps=;
	b=ce0jUMe6Px4brRcTuToZdEoR7ovHWYm4MQMQyjY5wtqMngXNHTs7A/pWTGklDpmdukT6
	 t9ofI/drL/21Mja8zZfvisF8s6mrUEwsFkykNkJPJ6WSc7o8mI0mmmmuFeBvyDqzo1iST
	 HlONBltqMRfux/4Qn3H8FBVrG3G/E2xTGKosN0t4WjNPgdPVWX0S+UqwyO2NaPR5xyKk6
	 4FByktZODxr3yirRbmkA8MNNruzdr261szD/UquP/bbvUiBeR8ljsMYqh6eCWplVzFZfe
	 TO5IYYh90tQRHmlu6kqnEsmmqNNWOCfdBPmJkrqafFQ5hZtUCZXHGfdJhBtcLIsb8gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYqOEUaK;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40436606A332
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 18:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40436606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYqOEUaK
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so19431735e9.1
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 10:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794853504; x=1795458304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EjsiR+6jJ8ZmBsAFEuHSjNRWBiCgBYf83KNABOGKFps=;
        b=qYqOEUaKJRV7446e0GWlQe5+nEhOjPwdq5MvPNwV1sDStwSf7ZmtKGr60xLfRSIhFZ
         +bzoWZM2qhldUVqEJy0AkE0Ud8uvJOtmcpoqo2N4ncg4+W6JbWrKJjK8PYQAPSQkNJpq
         7Q/8M57MyjIpbxTpt+YoAvFxHPGVHYH0NAAN0LdaVRwAgCqHUT8Awm7mmVvGZrygOetl
         zVN+9EruqLrdhENAA1XrXytjrpCaOAeqUgDgQt6zlWRNTkBu5utOPKt1pNizJsz44JGV
         Ud8Ps1h6R75EDAzc9y2B94EN3SZbGoDwhTYIHdjGk2JQXJ3LXKZ7F7+XVKYpbQqhTJsY
         PgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794853504; x=1795458304;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjsiR+6jJ8ZmBsAFEuHSjNRWBiCgBYf83KNABOGKFps=;
        b=aGsvTv8P2IpCIVhGS+MFkgdgsKNQQPsOtj2PFqGqlQjOvG2RlS5s1NTeTXwL0ZTnAt
         ZXtGLxZ77QIadUJ2/TZjUiGYksLIr1A3/RrQLj3Jp8dbnOWX6oe5sQ21gpJX6CsXojDH
         Gnk6OAVKczFg8EnJIF3/RHklcXsjLaa+DBrhxhdZ8c9f5yaxxhpu1l88Jy5+8IrBH3K7
         8EuebIEV+fFBT3tlvtbzkuIDLu5utok370lsjVBO8HqO9TLZb69IaNgjDxZQyjz1H7Gb
         GJb1TVl3yHnligyibYyUQigERoZCZcuF0BK0zURJN/XCjcbQ6/CyOnvOSVs8850G2qdW
         EYCg==
X-Forwarded-Encrypted: i=1; AL+hErFt1SHckYQndME/4sBtBV8x83Oyx56jbOxJBl2hrbPsm+1t3tJEx5Da4Gowm5Q2CKR/YFlicitkRnM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ifhDUYk757WB7w/X0dJFwEXyYySF9MH2JiaEKlML4aFlrZt5S
	JWncufmvb7aVpnrtPv/GdpAGEecq8jrNSadE6RHnGYyoGN4makIq9WDs
X-Gm-Gg: AYBFou2JNUiiGdZgck/udd3t+103XVyah5rMA4bMUDehlZ7byYKQpK2VIS4DfHLkD6O
	QrryuXvM9jAiPWjxiZbQtpzNMoKABf76Vocbkc1VPYWYcyJP4YxNi+Ub9yZTpQ3ONTRppskVd5H
	cdZFqIXK5VaI7naBAAQMBqtNHkZWBUA4Sw2aEou//UEWQQ2vUlEw9hQKUq66y9ZQJ8/xD8cnxpg
	lb2KEg/Xt8XdDvSkW8kp6H9GqW9EwyvRsaFQIxWpIde6zPs1OflW30ailKSBNdVjPOiD/blxmW8
	Ogx2ua9Zae7eLCMi/6MEFsti3JPR520fxZ+dZt8uEOBN8OTu7XxInh4nrmPz98UmubGTCcOi2Lt
	BB3QSC4yHCb1CWXeDKRy1KUEesJzIsWWE75XS48+CYrCcIUvI06WWQaxtMOGne5rTKUufiMR+Vo
	KFcC64TP4Z4c8la4p3LMTRBhcu6WfOi/SUE19MtUWyo+xs8JZ7+qPdnNThXR0mvExN8yVDw15lX
	VUXAsf/pHqSObz1JnGIsuRKemNiI7ISR7mQkCVfZAC/Te5IAl9OS/mbY8lgIolwoOCKoTfp5PyD
	Xn0cRXM=
X-Received: by 2002:a05:600c:34cf:b0:4bb:6a2d:b440 with SMTP id 5b1f17b1804b1-4bb6a2db5a1mr110927715e9.2.1794853503457;
        Mon, 16 Nov 2026 10:25:03 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72::cb4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78430918sm5161735e9.13.2026.11.16.10.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:25:02 -0800 (PST)
Date: Mon, 16 Nov 2026 19:25:01 +0100
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
	mehmet.fide@screeningeagle.com
Subject: Re: [PATCH] i2c: imx: keep the error of a failed read
Message-ID: <avtKfW6vYmwl6D-s@eichest-laptop>
References: <20261116125940.1368194-1-mehmet.fide@gmail.com>
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
In-Reply-To: <20261116125940.1368194-1-mehmet.fide@gmail.com>

On Mon, Nov 16, 2026 at 01:59:40PM +0100, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> When the count byte of an SMBus block read is larger than
> I2C_SMBUS_BLOCK_MAX, i2c_imx_isr_read_block_data_len() sets -EPROTO and
> fails the read. The read of I2DR that took the count byte has started
> the reception of one more byte, and its interrupt comes in while the
> state is IMX_I2C_STATE_FAILED. i2c_imx_master_isr() has no case for
> that state, so the default case replaces -EPROTO with -EINVAL.
> 
> Ignore interrupts in IMX_I2C_STATE_FAILED so that the first error is
> returned.
> 
> Fixes: 5f5c2d4579ca ("i2c: imx: prevent rescheduling in non dma mode")
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> ---
> 
> Notes:
>     Tested on a Colibri VF50 on the Iris carrier, kernel at this base plus
>     "i2c: imx: acknowledge the count byte of an atomic block read" and
>     "i2c: imx: do not acknowledge the last byte of a block read of one
>     byte", with the M41T0 RTC at 0x68. A test-only hook passed the messages
>     that i2c_smbus_xfer_emulated() builds for a block read to the adapter,
>     alone and followed by a one byte read. Register 0x03 (0xae) as count
>     byte: without the patch -EINVAL 40 of 40, and a print in the default
>     case showed state IMX_I2C_STATE_FAILED with -EPROTO each time; with it
>     -EPROTO 100 of 100, as the atomic read returns. Count bytes of 0, 1 and
>     0x13 read the same bytes as before, and the bus works after each
>     failed read.
> 
>  drivers/i2c/busses/i2c-imx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index ccf08cd63151..c7fef98934d4 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1142,6 +1142,9 @@ static irqreturn_t i2c_imx_master_isr(struct imx_i2c_struct *i2c_imx, unsigned i
>  		wake_up(&i2c_imx->queue);
>  		break;
>  
> +	case IMX_I2C_STATE_FAILED:
> +		break;
> +
>  	default:
>  		i2c_imx->i2csr = status;
>  		i2c_imx->state = IMX_I2C_STATE_FAILED;
> 
> base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
> -- 
> 2.56.0

Looks good as well, thanks.

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
