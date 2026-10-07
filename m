Received: from send77.i.mail.ru (send77.i.mail.ru [89.221.237.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4623BA241;
	Wed,  7 Oct 2026 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.221.237.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791380969; cv=none; b=st2hmhlATGXms1/uWzP2Mf7k6in/E52/4M+d9ZmTeaI3ysFVhMn7sEm2xcqgMAAarNdtOgopxuAMJ7bwyYQIO8072fxU8zHiKN2dzA5vtJmPxXvGaGr3fZ+coaCQhjOnNaQ703mOREXwz25d3QTxDHZ1PwIT/EbXez6Dvvc5sCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791380969; c=relaxed/simple;
	bh=QsGNEl7VbsfU8ycWlGhIdAuRZBRgXJOBMHVTVjP7i2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzoeCkwztxswmUleNI1iv1K19I+j9X9LCSMn2q96RO16eA5Ezzp9Wccx056BASJfEPSX+M7w9sJ+7ZspCbrVdGvn9xLM9TfQgVct3bEa6kRrEWlcraOJF+e0D+CAV7Q0FBYppUjVyoOtCNujsDRW4vf8Liw60RGkivrv4d/y5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=2E9SBZGq; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=AliK2BL3; arc=none smtp.client-ip=89.221.237.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="2E9SBZGq";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="AliK2BL3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=3jddqBrXtu3+VY/JgC9y6Z26EfktkwbQcTnNjP9zB7M=; t=1791380956; x=1791470956; 
	b=2E9SBZGqNMz7ZWeY2fl7+6QCuWaWxIkNqBIHRmk+rtxf/1uH7B2S+RejegthzeXh8pI7sWiQIh9
	BdFpkDLJ5hgKtAXhnOvXiShSkOxwKdfET/XM4eUWLw5h64PEU1zThMjwErLt8DFAF87Jdfq7MngZU
	Tv9CjuhqYNheh3Pl8D93BMi+UpbYtb6HF/ywD69kRv0Zu8VOSCm08PfE3UPPRe6dKXTWw/t7xitHA
	bXjK6Of2G3+KEVOPQManaxAIWMci1ov39ntJ9lnu6cxSRKeGgvEpy2EKNaw8LuZWEoc4xa4wN1g6S
	45x7KHHgMhA7lTh6M/d2mPidb0iGY1X3EHjQ==;
Received: from [10.113.171.252] (port=53412 helo=send174.i.mail.ru)
	by exim-fallback-79c4746b9d-28npw with esmtp (envelope-from <misha.zavertkin@mail.ru>)
	id 1xERmV-000000008U5-1Q8X; Wed, 07 Oct 2026 16:34:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:To:Cc:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=3jddqBrXtu3+VY/JgC9y6Z26EfktkwbQcTnNjP9zB7M=; t=1791380043; x=1791470043; 
	b=AliK2BL3m1XVlOWm+2viNiAmpkq6lnxQ58f8VeFkncB2LHuC6c3J8z9OcBcpjbS3OHYFllUKClm
	Zcn5g+kkzHDJbCN0W20tpUby2gvTUJ5riqRaUojszjQGYgj//yhsnf8W6Hvk/GkBrXhPSYdC8TMTr
	NbSBoJMgGSvwMxOreB5IbHWJm3pCadZdy7t/I6nmhq3LQgeV5D96/Wn0RmebTmesL1Cqc6S0jMvNq
	E7Zhx7DwD8kgQqaUghvvXdokVKbaHDaoIgkvSHsiYO+8H6Ia/1mdDx+Rc+BrmcAlm93QdpedHBaPe
	YOZIHTiu0yWjiHDqbVA9wnzg9b4gli3/Nuyg==;
Received: by exim-smtp-5cc9c86755-48k86 with esmtpa (envelope-from <misha.zavertkin@mail.ru>)
	id 1xERmJ-00000000CJD-00nD; Wed, 07 Oct 2026 16:33:51 +0300
Date: Wed, 7 Oct 2026 20:33:46 +0700
From: Michael Zavertkin <misha.zavertkin@mail.ru>
To: Conor Dooley <conor@kernel.org>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rustam Adilov <adilov@disroot.org>
Subject: Re: [PATCH 2/2] dt-bindings: i2c: rtl9300: add pinctrl
Message-ID: <asZKOn8HIuIaaqKA@gamepc>
References: <cover.1791127538.git.misha.zavertkin@mail.ru>
 <0cd1f9b98511c55a375ab82b121fe256916b87e2.1791127538.git.misha.zavertkin@mail.ru>
 <asN-O5ntmiXvZBvs@squawk>
 <asOrwd7eAddenA-_@gamepc>
 <20261007-370cbe94c765a69550a85bbd@squawk>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261007-370cbe94c765a69550a85bbd@squawk>
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9AF8DA1406861E5C9DC39872F923BB7459CF9969CB95C62A4182A05F538085040D2B74D280841D6423DE06ABAFEAF6705E9B485290AB1CB8D4079FCDA86AF802E22153E7FBF342507
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE749E89BD568380EECC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE789066434B85BF7C7EA1F7E6F0F101C67CDEEF6D7F21E0D1D9295C2E9FA3191EE1B59CA4C82EFA65891E6E796BB3928BDD7754560BAD7F31EC41A298494761EFC6F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE745AB435BC3F971989FA2833FD35BB23D27C277FBC8AE2E8BECADA55FE5B58BB7A471835C12D1D977C4224003CC836476EB9C41850244470149FD398EE364050F9647ADFADE5905B196C9B5BF839F39F6B3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE9ECD01F8117BC8BEE2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8B3B6387817AF5331475ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A51595DD07358B41A05002B1117B3ED696506D457920C175343E67C18142C611B7823CB91A9FED034534781492E4B8EEAD831CA35E4C50C31B
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE1918E10F71CB4DF9F96AB70F9BE574AE9C625B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D659E86676A6CB1B3696C464A37B223155293C0AE32BBDBFD6F318277330C5461A93FF18AE2E753E5788B8341EE9D5BE9A0A5527FD69D71615DAD1C78B95915F28DC3057B617AA5D7BC6546A885F7A58241B4C41F94D744909CE2D653CA06E969CEAC4926F5095E487D6D64CFEF34022E96A964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWHt4gyqCPture+eya20PhEY=
X-Mailru-Sender: FD65D7C492470CAE2C9604F6908AC19F89466440D41B8490B951B70A5BD4BD8E5484F73AD338C4B3134B2017C7F24A7E4B2A3C715BC1DED96EFAE8183A2EAE0D96DD28E056F58A23E3C55DE776B662A1DD77B849F69637CB3DDE9B364B0DF289AE208404248635DF
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B41D530A2FDADEB20117A6A34C38425EB621E4554C763D1260049FFFDB7839CE9E14E6DB171A86F998971A366504032917392A19BBB4D726BF401A36E4DE8DB996BFE2DE3458B8E40D
X-7FA49CB5: 0D63561A33F958A552CE53E88B458C895002B1117B3ED696772FE71204850A1A477B8DB6B08738FF02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a7fOSZxVRCdDhoPUgfKb4WI=
X-Mailru-MI: 20000080020000000000000800
X-Mras: Ok

On Wed, Oct 07, 2026 at 11:12:36AM +0100, Conor Dooley wrote:
> > If so, what would be better - print warning about realtek,scl (only for
> > RTL9607C) and work as earlier, potentially interfering with pinctrl
> > driver - or abort probe with error if there is no pinctrl property?
> > Explicit error or message is better then silent regression, if I
> > understand you correctly.
> 
> If there's genuinely only two users, then I suppose you can break it.
> But two known users doesn't meant two users. Otherwise, use pintrl if
> available and use the fallback to the existing property if not. Mark the
> property deprecated and probably emit a warning.

Okay, I'll prepare v2. Support for deprecated property should be removed
somewhere in future, right?

