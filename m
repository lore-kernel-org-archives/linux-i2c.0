Received: from mail-24430.protonmail.ch (mail-24430.protonmail.ch [109.224.244.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2380257435
	for <linux-i2c@vger.kernel.org>; Thu,  9 Jul 2026 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599250; cv=none; b=H18zAXPemGGOvRlY2vq2RJu3O7IN6b59QIxutsRLbNvcgRsvGbZYMCWO7CkPUxyF80/t9nMSeehSGyiIO2GnVEhBu3vSukbtp3qw8GBjoA/BHYHN642ofdTdUtKF5wQKDR+qn2+iMQqjJlAuhym9f6ZX/nOJ66npoPMYqJthUWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599250; c=relaxed/simple;
	bh=4yOipLOM76yQ4J1l/AoGPxGOwmes2/QBhbkzUXSfv48=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+rlGyFCuw2VRhwfisLgjbG1rdprUYCH7yqeGS+M00WSmnfCrneCOVdTZ+bwuxsKNexChSPdmNPZJf1c/HIUfwMGvsvVbc4cX0aX76GxTPomo/05NKPYG/FtaW+prg/sbtF6eefW+eRUkJzDwqSegr8WnDnUGzWBXpfta7Tk+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=oaCgmtiJ; arc=none smtp.client-ip=109.224.244.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="oaCgmtiJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1783599240; x=1783858440;
	bh=4yOipLOM76yQ4J1l/AoGPxGOwmes2/QBhbkzUXSfv48=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=oaCgmtiJpF5ov1O6PcsF8Zf62ipzpbQ7Vm29b3b1i/u5dBmBJ6lHSwDHrGwmTIDa/
	 E2iG2FFJ0zDl6HKwKoyMoIjK9Utt6IBaLP91AE/SA3dxbssEz0e0Hf3kmY7nDB2H8M
	 tprFTDpyy/+Zf8wwthgArRQykZPbvRG3UglthMv5WhSo3h29Wkm9bSg5h7oR6S09F5
	 4vc6Q6g3I+QqdSBz7W1d2XpZfq4wtSkIiu6m+Zzw3EcKzGiVQ78xTLfpGHi5pw2srA
	 rIHtQWbFiwIN/1I51YXx6aefwBjFZVpIQKzUkZwrVCE1tGZa1Ce4fM/jILtV3sqFMB
	 l4S0DWe8OpXcw==
Date: Thu, 09 Jul 2026 12:12:55 +0000
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Qii Wang <qii.wang@mediatek.com>, Andi Shyti <andi.shyti@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] i2c: mediatek: fix WRRD for SoCs without auto_restart option
Message-ID: <GOZtJ6Ys4Syt4VaGQyJvmYEIe6dx97flmTygat-nc_gMwsKVrDaDOQjP2ZbX1Qqwx5PYjWo6rJwo-8H32NQQAQi4Z7x6y9wpBNyYea9liZA=@protonmail.com>
In-Reply-To: <0eb85793-5995-4177-9b04-338246d6979e@collabora.com>
References: <20260624-6572-6595-i2c-v1-1-9155cebaae20@protonmail.com> <0eb85793-5995-4177-9b04-338246d6979e@collabora.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: fbbc57c64a4c608f23b74d2008055f4ccc372fd6
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi AngeloGioacchino,

On Thursday, July 9th, 2026 at 2:46 PM, AngeloGioacchino Del Regno <angelog=
ioacchino.delregno@collabora.com> wrote:

> On 6/23/26 23:40, Roman Vivchar via B4 Relay wrote:
> > From: Roman Vivchar <rva333@protonmail.com>
> >
> > MediaTek mt65xx family SoCs have no auto restart, however, they still
> > support the WRRD mode in the hardware. Because auto_restart is set to 0=
,
> > the WRRD mode will be never enabled, leading to read errors.
> >
> > Fix this by removing auto_restart check from the WRRD enable path.
> >
>=20
> Are you sure that MT6577 and MT6589 do support WRRD?

Yes, I have checked their downstream kernels[1][2] and they both mention
WRRD.

We also tested mt6589 (privately) and the i2c was working. To be fair,
it had some other fixes, but at worst this patch is no-op.

mt6577 is a tough one... I don't think there's any recent kernel with
it. I plan to make it work with upstream, but that's a TODO. Either way,
vendor code has WRRD support.

> If you're not 100% sure, or you want to be careful (which I would, in thi=
s case),
> please add a `unsigned char wrrd_supported:1` to struct mtk_i2c_compatibl=
e, set
> it to `1` on *all* of the SoCs that support auto_restart (as that's effec=
tively
> a different feature - it just happens that all the ones supporting this a=
lso do
> support that, up until today), and add a new one for your MT6572, declari=
ng no
> auto_restart but wrrd_supported.
>=20
> That would make me sure that you're not breaking anything, and would guar=
antee
> you a R-b.
>

As far as I know, there's no SoC without both auto restart and WRRD.
Adding wrrd_supported that always equals to true sounds redundant to
me.

Let me know if you still prefer having separate flag for the WRRD.

> Cheers,
> Angelo
>=20

[1]: https://github.com/GoldRenard/lenovo_A390_mt6577_uboot_kernel/blob/38e=
a59263984e26c0dd8e5891b22a35f61e60ed5/mediatek/platform/mt6577/kernel/drive=
rs/i2c/i2c.c#L963-L975
[2]: https://github.com/bq/aquaris-5/blob/bc1d0d0e35c969670e2d869001be944ad=
0c9c5e5/mediatek/platform/mt6589/kernel/drivers/i2c/i2c.c#L728

Best regards,
Roman
