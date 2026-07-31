Received: from send55.i.mail.ru (send55.i.mail.ru [89.221.237.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689732E6BC;
	Fri, 31 Jul 2026 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481734; cv=none; b=SasGGHCNS2q71Sxy8Ruen0QcVGDMn4/O6F7yla72qYWmroikH5V1/SDvqId/aIIJFgNXr1jJqM60krAXfRYcVohxuvL5YdvHRUJuIlA+CculrWp3iUyxFnbA1T7DT4XsfnrSDex0G9/0epbEK3RldEnJPQpF3pNYap7XyDjsSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481734; c=relaxed/simple;
	bh=EHK1W3mAwYfGSuB0kHZ+VQ4aNixR83yPyKhwUgMX0JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPWNtEDqGTBS7XXhyfgNZlvquo7nIea+8ju6Dh6pBuP8lMKsA6WkCSPLCO7/H9L/TRNqBVm9lwtnSdQroriDhVjTyc/jPbOdCGqkZMLcrnRmICe8KhfC1y8QNngCD33iiPrUdHnda/tmHNsTbfATY99GPEPcVW3wM8FQxrcvyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=IklvgVPt; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=djfcRARb; arc=none smtp.client-ip=89.221.237.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="IklvgVPt";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="djfcRARb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=wUeHohxIWf62LqrDVMJbO0KdUye7yhYQb2/vZBhEqk4=; t=1785481730; x=1785571730; 
	b=IklvgVPt+KeFyCTGBeLW4cNTVbV8WpEkOLOu6Lj/SZjAJ8+tL3TxQzEy/XfWe9R/Cyp2kA690bG
	KV3E9N01PoQCu7zIQW5LauhLT+INYuVUZDAai8OWQSrAOUpI8bt1Vj2hz/DBzeJbf16EOFWgZunZc
	29cX2/7YWQacIUSGC+TIVfYB2x5Ow2lFXfbWU74gQzLVjV5pLpJn6L6y2i8iWZd/Ff6enQCbPYo2i
	t0dtijtIhmbXMbb9PPejhKg8po46A7xUIqprAbehTp29VV3smbg8Tp5UtgxoSTEcrNSVm25LsIAFf
	D+pKdPxZxhZ4SFuJEeRD6UpuIPOjMqig44vg==;
Received: from [10.113.103.198] (port=60122 helo=send279.i.mail.ru)
	by exim-fallback-67c48d97fc-mzpqn with esmtp (envelope-from <misha.zavertkin@mail.ru>)
	id 1wphMI-00000000SLR-1KGg; Fri, 31 Jul 2026 10:08:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=wUeHohxIWf62LqrDVMJbO0KdUye7yhYQb2/vZBhEqk4=; t=1785481722; x=1785571722; 
	b=djfcRARbFAtnA/nRspALee+XJfdhaIfm+KG/g9S935TzEEPMV0sUqo8JMiLoPuX66o9wNInLxXq
	eygsaFACKITnJS2dLfSVsFDzU6iKWuRkvNVUuhDGaDtR1Mdvy1PIDhGJd6Gh4+IfVRy18Bf5fQmDe
	8SQAf4uAndl2J7ACtnhOpZel4DzWstki86pFHKMgnthuzp4X1Kuzyk1te/hReOpw/aVvCLo51li0e
	OCD7R7qQiJsm/MtxQhFBnyiVd18NfPAYXJ9laU+irPjzGW7Ji2y3I8HmMfddNVcxhNYVr9IrC10rW
	VXo54jMwR3+/m6lK6t6tjXwvzyFqaJmU6CAg==;
Received: by exim-smtp-7f4897b4d8-bgxnq with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1wphM6-000000008tY-0vcD; Fri, 31 Jul 2026 10:08:30 +0300
Date: Fri, 31 Jul 2026 14:08:27 +0700
From: Michael Zavertkin <misha.zavertkin@mail.ru>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: chris.packham@alliedtelesis.co.nz, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: rtl9300: remove IO_MODE configuration
Message-ID: <amxJ6wVF4CQGCm15@gen-job>
References: <amRyBYZrBKY6uxd0@gamepc>
 <ampwUI8kb3QiE1vN@zenone.zhora.eu>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ampwUI8kb3QiE1vN@zenone.zhora.eu>
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9DFD0580A18F8559001818C4FA7B4F995AD13C7F539BF0B23182A05F53808504008B53D8AAFBBB0053DE06ABAFEAF67058C41A193E71F3186081B95D03A6BABA7ACCB5262BB501CA2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72E4E5201E1C2E308EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637FE9EFE935CD7C6AE8638F802B75D45FF914D58D5BE9E6BC1A93B80C6DEB9DEE97C6FB206A91F05B2A42092AEFF2070092E070BE324C7D3C470AFFBF55A63FA0FBB0A4F435E46E6718B35066C979671628AA50765F79006378022902977F5E319389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C0ECC8AC47CD0EDEFF8941B15DA834481FCF19DD082D7633A0EF3E4896CB9E6436389733CBF5DBD5E9D5E8D9A59859A8B6E5E764EB5D94DBD4CC7F00164DA146DA6F5DAA56C3B73B237318B6A418E8EAB8D32BA5DBAC0009BE9E8FC8737B5C22499F5E362153655AB1D81D268191BDAD3DBD4B6F7A4D31EC0BE2F48590F00D11D6D81D268191BDAD3D78DA827A17800CE786A01F665E7D37C5B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B85F16315563D62F5EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A52CB61F2AD10C76A15002B1117B3ED6961E19771C39822B893E67C18142C611B7823CB91A9FED034534781492E4B8EEAD3CCD70CEBBF18A22BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6596979A490411A3A14D4B086545FB76B179561621401905D41BBEFE0389C681F94DAC195BCF4975582B8341EE9D5BE9A0A7352751B5833A89254BEFE7229E04B1ED9B7F3437791D1DDC7CEAA0681F5848F4C41F94D744909CE2D653CA06E969CEAC4926F5095E487D6D64CFEF34022E96A964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXMZebaIdHP2ghjoIc/363UZI6Kf1ptIMVczkDsfooUjfszgrh0Ruvfk=
X-Mailru-Sender: D343CA3F660FD3B95B114434F024695162887A49F2D808C6B951B70A5BD4BD8E5B2E73EFD105A6F4134B2017C7F24A7E4B2A3C715BC1DED96EFAE8183A2EAE0D96DD28E056F58A23E3C55DE776B662A1DD77B849F69637CB3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4744A1B435A106E18CA368C651CDD160542311088A890ACA2049FFFDB7839CE9EADF18B409CF19A3A83FA7310DD598A5F3E846C544EB712C51CBBE593FAE62CE2337242EFA806A289
X-7FA49CB5: 0D63561A33F958A5A712484FBD25B75F5002B1117B3ED696FD3CF3E431729991831E8CFF54ADC65302ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpEZ9wIMwqVP4jLQVQ+dVm7x9BpDHadBV9RMjI809PraZHJcTKHfd/c/glJpyBuU9Lw==
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

On Wed, Jul 29, 2026 at 11:28:15PM +0200, Andi Shyti wrote:
> Hi Michael,
> 
> On Sat, Jul 25, 2026 at 03:21:25PM +0700, Michael Zavertkin wrote:
> > IO_MODE is used to route peripheral controller to SoC pins. This is a
> > job for pinctrl driver.
> 
> where exactly is the pinctrl driver doing it?
Not sure what you meant, but I'll try to give as full answer as possible

pinctrl driver should does it in set_mux() callback, while i2c DT node
initialization (correct group with correct function must be
specified in pinctrl-0 property)

The driver itself now going through code review in OpenWRT (I've been said
that the patches should go upstream, and I agree)
https://github.com/openwrt/openwrt/pull/23961

Since i2c driver for RTL9607C now requires proper connection with
pinctrl, should it be reflected in driver documentation (realtek,rtl9301-i2c.yaml)?
I.e. should pinctrl-0 be required? Or should it be pinctrl-names with
minItems: 1 like in some qcom i2c drivers (qcom,i2c-geni-qcom, qcom,i2c-qup)?

