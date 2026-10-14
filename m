Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [37.187.220.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106F4EE845
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.187.220.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982447; cv=none; b=fKauJxzq4WxNgX84mMYL04Y8wgNhK9dUEKLBibcG9L4yUcvtjbGUaCZ/40SPObUoKKjPBYJfADTwzjnV5ogax7VMXrxZc37LmcGBGYkpBcaVLfMJfScTWLn/pVonb8FvaX3v9NSMXH12SMqm4ON2Qvr3pB47bfcddJZRck2na3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982447; c=relaxed/simple;
	bh=6bjXC95zDcAs3LYu2AL42LqZZH94acS9uj9YG/YRG9Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qAR1cgnSZMzKN5yjElYiDBYvEc+iWZFupxjbHgLXVLDD9YREsOYDR3S/O6aCp6h6iGP1txAXlKoJdrpav3Dm63gvkkfxPD5Iq9JdraI2Dfpe8wADB6wd2gxxZm8PE+Xrc6j5EkGhpSjxtQfHbqLFGmVGIZqPcR3JgnHu115SO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nxsw.ie; spf=pass smtp.mailfrom=nxsw.ie; dkim=pass (2048-bit key) header.d=nxsw.ie header.i=@nxsw.ie header.b=NFohqh44; arc=none smtp.client-ip=37.187.220.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nxsw.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxsw.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxsw.ie header.i=@nxsw.ie header.b="NFohqh44"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxsw.ie;
	s=protonmail2; t=1791982408; x=1792241608;
	bh=T3htCyi61LnIYLCIgruh3jeMbm8QKAj8fL+DVvyQtMg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NFohqh44zxqEHk1LgEE0JQWFlhmiLpn01Ky0P//eNG0qcurg44zxGQRbx630c3aKe
	 GnobjpNySkGWVVkC+1aeAeLew4bldHLhzMxzBCNzCYtUGSblznZ4a5LzwRWAylGbn8
	 eM/Qya8r3moc0EYkPxvu+stDw1At4J/+vOAqqjWpA+97d5PS/T3gnCMTqJbhQX3mTu
	 YiAfsDdnQIyY57GI1jY/xbhU9wuoPON8UqGPbcZUivxcy6FIGRMmCUrUYydZQvUdcQ
	 BJMvSWw/H/EeeAzEBmJHv88ve5C6iCq+w2FF8lrZs8BBXROWZCGYZ6U7VoVOY4oE6T
	 XkacwwKwoYa9Q==
Date: Wed, 14 Oct 2026 12:53:24 +0000
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
From: Bryan O'Donoghue <bod.linux@nxsw.ie>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] i2c: qcom-cci: Factor out write command queue programming
Message-ID: <d39189f9-e9fe-4019-9b64-c4d7c0694c4c@nxsw.ie>
In-Reply-To: <20261013-cci-imp-v2-1-6873326b44a3@oss.qualcomm.com>
References: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com> <20261013-cci-imp-v2-1-6873326b44a3@oss.qualcomm.com>
Feedback-ID: 136405006:user:proton
X-Pm-Message-ID: 6d1d7a76d576577b25342e895170efd33b175fb7
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13/10/2026 11:30, Loic Poulain wrote:
> Factor out write-command queueing into a dedicated helper and replace
> the manual byte-to-word packing code with iowrite32_rep().
>  =20
> The resulting code is easier to follow and will be reused by
> upcoming burst-write support.
>=20
> Also add a sanity check on the write buffer length, which should
> already be validated by the caller/I2C-core.
>=20
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>   drivers/i2c/busses/i2c-qcom-cci.c | 41 +++++++++++++++++++++-----------=
-------
>   1 file changed, 22 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-q=
com-cci.c
> index d509dc1c14700d9c199d67df19082bae4f1ae470..3304760411082b72e10e529a2=
bd66361e100fa06 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -77,6 +77,9 @@
>   #define CCI_I2C_WRITE=09=099
>   #define CCI_I2C_READ=09=0910
>=20
> +#define CCI_I2C_WRITE_WC=093
> +#define CCI_I2C_WRITE_NWORDS(len) DIV_ROUND_UP((len) + 1, sizeof(u32))
> +
>   #define CCI_I2C_REPORT_IRQ_EN=09BIT(8)
>=20
>   enum {
> @@ -485,42 +488,42 @@ static int cci_i2c_read(struct cci *cci, u16 master=
,
>   =09return 0;
>   }
>=20
> +static void cci_i2c_load_write(u8 *buf, u16 len, void __iomem *loadq)
> +{
> +=09u32 cmd[CCI_I2C_WRITE_WC] =3D { };
> +
> +=09if (WARN_ON(len >=3D CCI_I2C_WRITE_WC * sizeof(u32)))
> +=09=09return;

Why not trap this and return the error - cci_i2c_write() has a result code.

> +
> +=09cmd[0] =3D CCI_I2C_WRITE | len << 4;
> +=09memcpy((u8 *)cmd + 1, buf, len);
> +=09iowrite32_rep(loadq, cmd, CCI_I2C_WRITE_NWORDS(len));
> +}
> +
>   static int cci_i2c_write(struct cci *cci, u16 master,
>   =09=09=09 u16 addr, u8 *buf, u16 len)
>   {
> -=09u8 queue =3D QUEUE_0;
> -=09u8 load[12] =3D { 0 };
> -=09int i =3D 0, j, ret;
> +=09void __iomem *loadq =3D cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, Q=
UEUE_0);
> +=09int ret;
>   =09u32 val;
>=20
>   =09/*
>   =09 * Call validate queue to make sure queue is empty before starting.
>   =09 * This is to avoid overflow / underflow of queue.
>   =09 */
> -=09ret =3D cci_validate_queue(cci, master, queue);
> +=09ret =3D cci_validate_queue(cci, master, QUEUE_0);
>   =09if (ret < 0)
>   =09=09return ret;
>=20
>   =09val =3D CCI_I2C_SET_PARAM | (addr & 0x7f) << 4;
> -=09writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
> +=09writel(val, loadq);
>=20
> -=09load[i++] =3D CCI_I2C_WRITE | len << 4;
> -
> -=09for (j =3D 0; j < len; j++)
> -=09=09load[i++] =3D buf[j];
> -
> -=09for (j =3D 0; j < i; j +=3D 4) {
> -=09=09val =3D load[j];
> -=09=09val |=3D load[j + 1] << 8;
> -=09=09val |=3D load[j + 2] << 16;
> -=09=09val |=3D load[j + 3] << 24;
> -=09=09writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
> -=09}
> +=09cci_i2c_load_write(buf, len, loadq);
>=20
>   =09val =3D CCI_I2C_REPORT | CCI_I2C_REPORT_IRQ_EN;
> -=09writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
> +=09writel(val, loadq);
>=20
> -=09return cci_run_queue(cci, master, queue);
> +=09return cci_run_queue(cci, master, QUEUE_0);
>   }
>=20
>   static int cci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], in=
t num)
>=20
> --
> 2.34.1


