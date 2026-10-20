Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.163.59.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505846;
	b=k6heyOAX1e+jj9KgjRqf+x/L4dSPbqj2tN49sB5Qnc8mDwgnjXrmsT9ctx+ZYRLI4oSU
	 j6wYJWvCVFz3aakTKq3qo7yHVqyoF+ZVLzUCxV2Acngha2yWgQfh8aALO36Z2nyb/gX9q
	 5ll3BgAIsyFT6Ok0v/Odwk6cuYcy2FlvwZ9Ck7Md1AW7bIIsPIjElAHtt9giIetjgLeKI
	 ymcOUTFx9kEHsP+R1C4Xfy3voincgSulY+21ETZWZqPMjAEOo7bIQc0TH+a02edahdJDu
	 yHx6MjxLNnLQwBVWTrN7i8ntsP2qF/KeDk5NVks+L88KC9dSStQtRlWKHm8w3T8nW/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505846;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Mailru-Src:X-7564579A:
	 X-77F55803:X-7FA49CB5:X-C1DE0DAB:X-C8649E89:X-D57D3AED:
	 X-Mailru-Sender:X-Mras;
	bh=HShU1ajCTatn3U0+wXokY8SYUYSusu42a9leXTZGoqo=;
	b=3EFH8+JjeOJhdtv9rn4VYynjNBJsoNmUAMHPxe7RYDAcl18GWiD/kht/sBzTGRooOl5v
	 KsFa7uW9sX29xQrU/Gvl/vjJvixchLCT+KWbiI6fZiq1ce0gZpXmzVbNY5x+zPARtDnGm
	 1eWGnczLM0sBussYnQAE1NI7jpVK5V0d7vaz7baw/Ag3CB/9oYu9crwvbqkRnlD1ODfRi
	 IcrqmbkWYRFdDTnGl1KOBTJeZdq9tRzYxNeA45PdLtKYwBPmqkVnCsB/dfDw6sqiqHhm3
	 ICVUfr/Swr5fsYd6SMi8mXJ+PVxI/QQSjcUOkwwNbTE5QEP3sR4GFFDSaTVGm8n3FDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ru;
	spf=pass smtp.mailfrom=mail.ru;
	dkim=pass header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=UL24wGfH;
	arc=none smtp.remote-ip=95.163.59.57
Received: from send218.i.mail.ru (send218.i.mail.ru [95.163.59.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BF60A3817;
	Tue, 20 Oct 2026 14:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 259BF60A3817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.ru header.i=@mail.ru header.a=rsa-sha256 header.s=mail4 header.b=UL24wGfH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=HShU1ajCTatn3U0+wXokY8SYUYSusu42a9leXTZGoqo=; t=1792505843; x=1792595843; 
	b=UL24wGfHRszedxaBtsmS3U3TgdlRwCuBcUUF2COL7z4/r+oR31ZTgCLsdRnsnYuIQkb/zXVGLeV
	Ag2kjvs6EWPK6oast/lU2r8WMstVO13pAM3Tj7QP/w6i0WdGxrafUH8Hj4MIOylhuhO59ayuuokmE
	oG8PYDPhLeCt1woWn79Wnn8Ehbx/RGB9wEgYHXHzEYyzTeVVPHJos43S5guIt4vtmExsiKCMIzgwp
	0S1n8Hi7D2pijzLpS2EtgxKkDxYG4wX/g6SE2jwj8LwdN9yarvj6tC1k2BetZ5vM+BOfH0JKrIxS1
	tN8Hqkl/4ApuyAR/fxj83P5gZscLRzBSBpmw==;
Received: by exim-smtp-558c7cf579-v8gmr with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xJAeQ-000000006fd-3HL2; Tue, 20 Oct 2026 17:17:15 +0300
Date: Tue, 20 Oct 2026 21:17:11 +0700
From: Michael Zavertkin <misha.zavertkin@mail.ru>
To: linux-i2c@vger.kernel.org
Cc: Rustam Adilov <adilov@disroot.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: rtl9300: add realtek,rtl9607c-i2c compatible
Message-ID: <atd35wScRu958p-p@gamepc>
References: <cover.1791611999.git.misha.zavertkin@mail.ru>
 <e7186b18caf58f2fefa61093921805d5dc045e07.1791611999.git.misha.zavertkin@mail.ru>
 <sashiko-outbox-166284@kernel.org>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-166284@kernel.org>
Authentication-Results: exim-smtp-558c7cf579-v8gmr; auth=pass smtp.auth=misha.zavertkin@mail.ru smtp.mailfrom=misha.zavertkin@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9DFFC04176464C09E79E6E67BE48C2A2B1FB020C0B09AAE0C00894C459B0CD1B9D79830490D50202D2EB5D77EF37489D143B5C1FC6A22A2C0091016640989F49F35340226AAA953E0
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72F22E6DC541F75D9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F28F4AF03526AA8F8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2D7555A0FFE29A0962E070BE324C7D3C40801EA40693EA213BB0A4F435E46E6718B35066C979671628AA50765F7900637F924B32C592EA89F389733CBF5DBD5E9D5E8D9A59859A8B611E5B64A728E1589CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8090A508E0FED6299176DF2183F8FC7C073D3C14A638F3BE6CD04E86FAF290E2DB606B96278B59C421DD303D21008E29813377AFFFEAFD269A417C69337E82CC2E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6CF00A2452BA722CE089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5789F0309656BF0AE5002B1117B3ED69644C71410E482EB43E99897350C7C491E823CB91A9FED034534781492E4B8EEADEEA082C9A12FE455BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6590726D5EA13D43033CE201AFD005EF7468569706EDE2BA2D2312A344C19DC87FF680EFF2B3942D708B8341EE9D5BE9A0AF0BF99C353B921C24ED02CC49C473A4ECD1AA28F94FCD317546A885F7A58241B4C41F94D744909CE2D653CA06E969CEAC4926F5095E487D6D64CFEF34022E96A964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWPLPuVEUe1uNm5/lFOSIJYM=
X-Mailru-Sender: 53225E476262CDFB4708A4528C9D2A7BB776C0B8A08BD75C3DE06ABAFEAF6705D72900F5CD64CF08F544F87C5664B7A31DBC9D26A80DBF048AFC883BAD50DDC9AB8642342C2B65EBADBD92A00C77E0473057BA2287F227EE22B820C1B2086D890DA7A0AF5A3A8387
X-Mras: Ok

On Sat, Oct 10, 2026 at 06:45:14AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] i2c: rtl9300: device_is_compatible check breaks DT fallback patterns
> --
> 
> commit 96f11e2144ef16398bba64fc512f5b346ab89571
> Author: Michael Zavertkin <misha.zavertkin@mail.ru>
> 
> i2c: rtl9300: add realtek,rtl9607c-i2c compatible
> 
> This commit adds support for the realtek,rtl9607c-i2c compatible string to 
> distinguish it from other RTL9607 variants. It avoids using the IO_MODE_EN 
> register on the new compatible by restricting the select_scl call and emits 
> a deprecation warning for the old compatible string.
> 
> > diff --git a/drivers/i2c/busses/i2c-rtl9300.c b/drivers/i2c/busses/i2c-rtl9300.c
> > index 3a8225b0666c0..22aa3b38458c0 100644
> > --- a/drivers/i2c/busses/i2c-rtl9300.c
> > +++ b/drivers/i2c/busses/i2c-rtl9300.c
> > @@ -200,10 +200,12 @@ static int rtl9607_i2c_config_chan(struct rtl9300_i2c *i2c, struct rtl9300_i2c_c
> >  	if (ret)
> >  		return ret;
> >  
> > -	drv_data = device_get_match_data(i2c->dev);
> > -	ret = drv_data->select_scl(i2c, i2c->scl_num);
> > -	if (ret)
> > -		return ret;
> > +	if (device_is_compatible(i2c->dev, "realtek,rtl9607-i2c")) {
> > +		drv_data = device_get_match_data(i2c->dev);
> > +		ret = drv_data->select_scl(i2c, i2c->scl_num);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> [Severity: Medium]
> Will this check break device tree fallback patterns?
> 
> If a new device tree provides a fallback compatible list like 
> compatible = "realtek,rtl9607c-i2c", "realtek,rtl9607-i2c"; 
> device_is_compatible() will return true because the legacy string is still 
> present in the node.
> 
> If this happens, the driver will incorrectly execute the legacy select_scl 
> hardware configuration (modifying the IO_MODE_EN register) on RTL9607C 
> hardware, instead of delegating it to the pinctrl driver as intended.
> 
> Would it be safer to differentiate hardware capabilities based on the matched 
> driver data (for instance, pointing the new compatible to a struct without 
> a select_scl function) instead of dynamically searching the OF node for 
> deprecated strings?
> 
> >  	i2c->sda_num = chan->sda_num;
> >  	return 0;
> > @@ -494,6 +496,10 @@ static int rtl9300_i2c_probe(struct platform_device *pdev)
> >  		scl_num = 0;
> >  	i2c->scl_num = (u8)scl_num;
> >  
> > +	if (device_is_compatible(i2c->dev, "realtek,rtl9607-i2c"))
> > +		dev_warn(dev, "Compatible 'realtek,rtl9607-i2c' is deprecated. "
> > +			      "Use 'realtek,rtl9607c-i2c' instead\n");
> > +
> 
> [Severity: Medium]
> Does this also trigger an incorrect deprecation warning when fallback 
> compatibles are used?
> 
> Because device_is_compatible() matches any string in the list, providing a 
> valid fallback to support older kernels will falsely trigger this warning 
> even if "realtek,rtl9607c-i2c" is properly specified as the primary compatible 
> string.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1791611999.git.misha.zavertkin@mail.ru?part=1

There is no device-embedded device tree files with this compatibles,
only embedded in kernel during build (OpenWRT approach), so fallback
compatibles isn't expected, and proper fallback support would look like
overkill right now.
