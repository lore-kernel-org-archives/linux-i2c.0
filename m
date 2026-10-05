Received: from send81.i.mail.ru (send81.i.mail.ru [89.221.237.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7C47F3B0;
	Mon,  5 Oct 2026 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208395; cv=none; b=OT9ha5Bk6ahjOFYH0eCKysx4BhhnJY+PiOajxXkHv/jLd2588N9W7/TmKE4rvUXS7/MUBXIas+9Xpgc1Lnf0EusuBecfHpKH2rPhpbIip+oCs0m9U5Sej9rmN1XccpFJ4nYDKiQB0LKuvpy+CpsZJ6YD+4MdsbQZJdzZplbbof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208395; c=relaxed/simple;
	bh=qFqpZmLgXQdD36JqzuxIBU26jHAI+zPnBqx40ODgbcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLZra/FIUXjoaxpnySJG+64B603ezEPeYywCg7F72QmWxPG32Sxu1NMeniNXUeWT6mdNE5KTyHZEXIu3tmToM0vJDkRonzY4SY0l6LpYKax7anwgMA2Y01si+xRugVrs3ii834ZAQlcw/h5qRgtsR2aaLGNPgu0V5rvL9Z3CYkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=AF3LBcm5; arc=none smtp.client-ip=89.221.237.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="AF3LBcm5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=jRMZkEQ1w8xAoRWT7fIuKzGi8bAdOsKoWDkqoL7Hhjw=; t=1791208392; x=1791298392; 
	b=AF3LBcm5DGHIAvlcVwd1hVfGWfOcJB0rnBCHjXViKuGPRBLUMYQUM9PDlLm4lsSssGhZutSElNa
	mzrdlOAXcWtsctoi09EtCCg97k14TDeopVfh6x+Gi4xgadI6ZIvxcAgPpWXG7It7ZfkVp5jAtO3eU
	FiABKlbgR0YYABMeApWH7wnyxdWPIO6I7dusMcQGWo4voOlW3pWRPgKW8KU2vGEQ288q4zPTCfQIA
	LHJ4BiI+RDmCAUnaUXTEE7tNWKRnrlU44MwPuuuA4dymmiFOQ+e7qo3MyOf5XroC+olr+6gSlgTgq
	i+C1izJfeJuxJPFBgpjotzPQXMQvOtkLOQtg==;
Received: by exim-smtp-5bd9c49696-zpn2x with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xDj7r-00000000HQZ-43vA; Mon, 05 Oct 2026 16:53:08 +0300
Date: Mon, 5 Oct 2026 20:53:05 +0700
From: Michael Zavertkin <misha.zavertkin@mail.ru>
To: Conor Dooley <conor@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rustam Adilov <adilov@disroot.org>
Subject: Re: [PATCH 2/2] dt-bindings: i2c: rtl9300: add pinctrl
Message-ID: <asOrwd7eAddenA-_@gamepc>
References: <cover.1791127538.git.misha.zavertkin@mail.ru>
 <0cd1f9b98511c55a375ab82b121fe256916b87e2.1791127538.git.misha.zavertkin@mail.ru>
 <asN-O5ntmiXvZBvs@squawk>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <asN-O5ntmiXvZBvs@squawk>
Authentication-Results: exim-smtp-5bd9c49696-zpn2x; auth=pass smtp.auth=misha.zavertkin@mail.ru smtp.mailfrom=misha.zavertkin@mail.ru
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD916CE66F793C04802681FD38DEF83E1DA77A7EB953293C78F00894C459B0CD1B91AC0D19862E7631589CEA9C911D09995A1F4E213D52D61C909E6AD5482958E394C6784DEA8096F07
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE712EB008F780777E9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637560334CFC131571A8638F802B75D45FF799C897B879640A07197CC67C87A96611B59CA4C82EFA658A7BF724E0505E4F3BB22F9947019DC91BD80732E7DD4A9D86F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE767883B903EA3BAEA9FA2833FD35BB23D27C277FBC8AE2E8B5C00A253C229F406A471835C12D1D977C4224003CC836476EB9C41850244470149FD398EE364050F4B6963042765DA4BC8623B8F170C382FB3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE902A1BE408319B293FC91FA280E0CE3D3A03B725D353964BAD74539164518AE535872C767BF85DA227C277FBC8AE2E8B7E5613B76AD15BA275ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F9677DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D6590C9F04931F3800364610A94AE8244E392067DC5E4DA32EB8563D06C2FC53B1166B9698CB35BE2FB0B8341EE9D5BE9A0A6F8A87A1133EC55E47E5CC68B884274153B1FF19FEEE2A4C546A885F7A58241B4C41F94D744909CE2D653CA06E969CEAC4926F5095E487D6D64CFEF34022E96A964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWIVyuglZZ1THAP+qXqN/L60=
X-Mailru-Sender: FD65D7C492470CAEE010D97EE9FDA1EF6C8C27904EEC8E8D20C74B26AAFF93457272C4DCA726D4EB1045281C71E08B15F767ED260C4F5E398B67290C0B8F2C0D0ACA136676B1AD1C82BADC8C81B40964835B6B713A4867D9C77752E0C033A69E3453F38A29522196
X-Mras: Ok

On Mon, Oct 05, 2026 at 11:38:51AM +0100, Conor Dooley wrote:
> On Sun, Oct 04, 2026 at 10:32:35PM +0700, Michael Zavertkin wrote:
> > For RTL9607C driver used to configure IO_MODE register. This register is
> > global and is a scope of pinctrl driver (either pinctrl-single or WIP
> > driver for SoC).
> > 
> > Drop realtek,scl requirement for that SoC and require pinctrl instead.
> 
> This patch itself is probably fine, but the driver changes will cause
> regressions because all existing devicetrees are going to have
> realtek,scl and not the pinctrl properties. You need to retain the
> driver code and make the register setting optional depending on if the
> scl is there (or similar).
> pw-bot: changes-requested
> 
> Thanks,
> Conor.

I understand backward compatibilyti requirement. However all known users
of this driver are here (me and Rustam Adilov). Does compatibility
strictly required for such case?

If so, what would be better - print warning about realtek,scl (only for
RTL9607C) and work as earlier, potentially interfering with pinctrl
driver - or abort probe with error if there is no pinctrl property?
Explicit error or message is better then silent regression, if I
understand you correctly.

