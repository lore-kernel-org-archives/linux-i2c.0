Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822685;
	b=WeyksHl8B1TeLxEYjRPdNkqtIY0TnpUv0WENBVpabY+Rnss5EzC/YJnfEELSD052geux
	 eEq0lhxnzrRD4N6AABpyaisZtllDLPZbXpADpj9Q0KorKGNe7QUYrS9y7C0+JtLuiBzCZ
	 Gi1D+APbr6zP8SZjmazDIDWxsGbGyQz30eLh8yMVPXto4sJnVIaQcOb4gjsOazVdeyYDr
	 8CqaeSUxzRADVSZXgtKpP4P7VcNzB2n3VaO8QUzYb4VUNNaCyCMyXHnAr6onAl/txYOW4
	 1/Prhv2KN94V1Lt3KrQk1QOX0lVwVWMdwGm98IK1gkMDzEyVxWjsuZFwzJ8LEHEsYlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=N+fImhJ1pc1ohPywlDOVCLfSXbIN+d12UyWza3WFBhk=;
	b=D35tJ3Udz3lvODbR7D3jL7+CCD/ivMSIacb6jvs+WV7lxqW+oK5BMRFYOY39wxYqoJ/Y
	 c3dv7Xxp3MPUhrIXkIM769+SoWPUsxxra6QEpqsPys2cfsgNojiOyn2aDA3OaMkeu7Fk0
	 k/E9YO1izg+csDCS49qPspqZ5sseHhg0bOytm2eFDHBobI0GhilVv3k34l0xVju0NvqnQ
	 Voj9iMPbNBJaatvLZ23y9rMOH50zUyYDAbuDGI9/ATzPhiWyzs9s1O9al8qUYV7rMHcyN
	 FiH2baf7IHN4sDoVAD85Cpea8z7DFhdYx3IGNhQct8G+hknYujyIA0duMsTmJ3+umlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EeFkAcdf;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60977606A32A
	for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 09:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60977606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EeFkAcdf
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-49318428d98so1275765f8f.1
        for <linux-i2c@vger.kernel.org>; Mon, 16 Nov 2026 01:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794822684; x=1795427484; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N+fImhJ1pc1ohPywlDOVCLfSXbIN+d12UyWza3WFBhk=;
        b=EeFkAcdfmpM/alg861PlAN3DrjF1bRj9ji0oDldUfaZv3j2CudELa/V0lrOC2gOkAG
         JGNkG9Blg/e5dnyx2OH4OuiMCYhFr9l99Ysf8YzZ/ks2aAc2KVLu4vH1KnHaNiDJd2E6
         uQ/myF+6CEQL7AlIAfTFXYZ/tDTPmqRORayOJm+JLmOFKYXRlMt7O52H2VceZUp/QiKA
         Xn3+0Z/DALpAQexSUr1ikDhJBCi0+kUKJIUwJ4e1WU/rwlPDlz4YYqJ0htdnv7ic21x0
         H+QfTC6+EUtcg7wTqdg6ULdakSYDXtVnUpK61Z30ZOur/uD9OitvzhOo06AZYJYQeLCL
         EVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794822684; x=1795427484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N+fImhJ1pc1ohPywlDOVCLfSXbIN+d12UyWza3WFBhk=;
        b=COZexVjpOkM3EnicybGVzAwHbtuec9NOsP6JmD6e5MBAZblyWH2MV7p2BvgjOzb09/
         ptBgqgizB2RDu/Irpioxyte1LacJTi4Kcerigt7xblRFivtJ8RYvfpng+9u+wnSA4xDY
         rn16USGF+cAyZa4G8eGF7hzSVV6htPyjSAY12CPVgnEDMd2GI8Ber3w5p5ACZ8+wqkRx
         Ud4GNhERcatPv40DDTSIsLaotZS6E90kPN6F3DWevP2XCk3L3qpuccIiES2frkzumeq4
         d1nAjqL/lkkb9mkNuoj3ckecoVZbnxblM7DZahKNLVXmFrk+cnkjeE/YaNiNoUQVOS2A
         DTRA==
X-Forwarded-Encrypted: i=1; AL+hErGGyivTi2ApTfwsaJVR8wihcyN9ju6BunKTRAmw8lugbrh7EHnw2oNmCirESsjYOQfBUggT//qIG3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9dyR++NlPHV7am6O54Q5+owOSgIMkls50lDPvSaBIe587pJH5K
	kNvYl7uYf2IE+9TvXjPBhh3Vg419K9LCTk4qcrIBOWWFJ5/hUkdXZOIb
X-Gm-Gg: AZFdTZealGkpmylx31aon3LF3/oPd7AL22e0gtJ6PyBO/1asM2T5V+yj8rmJmiljpsK
	Wtoz7kVquLwYdHB/CdV0luZJskmR26JSnbgaTK5kl0mq61e1xMf7I1yJbw7r1xx23CUVIRqfrMZ
	7PFQjGeoCnrl5qo5yw+nlJcQCYsCt9KGOiGv+YCvfxqvjoY7K0M+Wj92U0825xxh+jg+NmKmMTJ
	m0Vd689xSEUuG2kEsP66PPDaZrdPXWywBziCN54/R+M5KW9rqAib/+HXHgg7LUnKDKqT7HKTvrE
	3EGjDUh4dMkw6NzscPAeKEmuVZMyxILc16QAxlmd/VLRw4644jIFaJI9UCqsIPCrePLlv8HD5x+
	A05ARkdncdScyz2i3jA/oKufb2S7lmmPF8r39mn/opAut9xXospaEYAMIXKiPeoOeEk5dI/Fg3k
	6Iy3uyBxrG/89sdfX6eT9TNw2dLzZM5qbpX/7XJ7CcpNZSxTFZhGdtHo5iYnvq8kW/ytl9vGmbd
	oyys6f+RZHCpRlukm4oxlv9gPbu50PAPi6esVgW07EoKdZPGe17azQEEE+5kWX0ahg9QePkxV38
	kze+SD8=
X-Received: by 2002:a05:6000:2584:b0:49d:a36c:2d66 with SMTP id ffacd0b85a97d-49da38ab522mr16399232f8f.27.1794822683448;
        Mon, 16 Nov 2026 01:51:23 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72::cb4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f1c1968sm21517792f8f.10.2026.11.16.01.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 01:51:22 -0800 (PST)
Date: Mon, 16 Nov 2026 10:51:21 +0100
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
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: imx: test the block read flag of the message that
 is read
Message-ID: <avrSGehp4JX4aQ5L@eichest-laptop>
References: <20261113110501.1142036-1-mehmet.fide@gmail.com>
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
In-Reply-To: <20261113110501.1142036-1-mehmet.fide@gmail.com>

Hi Mehmet,

On Fri, Nov 13, 2026 at 12:05:01PM +0100, Mehmet Fide wrote:
> From: Mehmet Fide <mehmet.fide@screeningeagle.com>
> 
> i2c_imx_xfer_common() decides between the DMA and the interrupt driven
> read with I2C_M_RECV_LEN of the first message of the transfer instead of
> the message at hand. A block read of DMA_THRESHOLD bytes or more that
> follows another message is therefore done with DMA, which reads the
> initial length and does not look at the count byte.
> 
> Fixes: b460b15b3cc2 ("i2c: imx: separate atomic, dma and non-dma use case")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
> ---
> Reported by the Sashiko review of another i2c-imx patch:
> https://sashiko.dev/#/bug/linux-f62df5ed-ad96-43f2-872a-ae2c0100b73f
> 
> Tested on a Colibri VF50 (i2c0 with DMA) with a v6.12.117 kernel that
> carries the i2c-imx changes of v6.13 and later as backports; on this
> base compile tested only. An I2C_RDWR transfer of a one byte write
> followed by a read with I2C_M_RECV_LEN and an initial length of 16:
> without the patch 16 bytes are read and the count byte is taken as data,
> with it the count byte is evaluated (here -EPROTO, the device answers
> with 0x25).
> 
> The line is from v6.13, the patch applies to 6.18.y and 7.3.y.
> 
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index ccf08cd63151..9abe0a26c877 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1713,7 +1713,7 @@ static int i2c_imx_xfer_common(struct i2c_adapter *adapter,
>  			msgs[i].flags & I2C_M_DMA_SAFE &&
>  			!(msgs[i].flags & I2C_M_NOSTART);
>  		if (msgs[i].flags & I2C_M_RD) {
> -			int block_data = msgs->flags & I2C_M_RECV_LEN;
> +			int block_data = msgs[i].flags & I2C_M_RECV_LEN;
>  
>  			if (atomic)
>  				result = i2c_imx_atomic_read(i2c_imx, &msgs[i], is_lastmsg);
> 
> base-commit: 25e7ab89f4774b0f842cee0e8a20c11f755924d5
> -- 
> 2.56.0

Thanks a lot for the fix, it makes sense to me.

Reviewed-by: Stefan Eichenberger <eichest@gmail.com>
