Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57F751354F
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791983954; cv=pass; b=WBaiqK4y0wDeg6UajOjxJQKes3YjNsiP+ohltoh6w7ZklyIKlECMsU1Q4L55sEO56iW5Ru0iS6Zd40h0w9rsP1OY3cfHQslOeHzUk4vRWp70uAu7OKd5jvIWiwwRHhVqOOstq+v4EydKdDkBs0qYhPHjy7d3GqAAYQ15TDniTMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791983954; c=relaxed/simple;
	bh=YpT2Qe/T2mt0iT4P8ZgElxgZygQNwPCoUxNvE7UC/eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWTqHS9gjBFdphML45M0vcaGCglHZkl8EBxkxf3/mAYOXYyIH8Es6SCHKuq0O4g0lDSdSXe4JTa+ma6Eze7Hxc3dUIAOlnAePEGqUhBnhMiSKDK2pJrJx1tbz2rzHfiFxXqIv+GhbNci/Z9cVpLDb59uFe+fRkIzXaHJJirhOU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RaokhI9l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OoiN7LAn; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RaokhI9l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OoiN7LAn"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8IbMb3017940
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 13:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AbyY7L02Rxh26+8dxarTEhQrgLb4aPc0R4YmO2fQi8o=; b=RaokhI9lpwfZtctk
	tnFXGMM4pdXprSGnRtJD1ew/HugC+VIzM6H8hM0jzHZRwth5cykuIATE/54nIMdw
	hbzL5Aq0lg/zvV1UoDQWgzkWAu68bbdE/u88OfcGyQJlhaEM7YNDj2hxoUlRo5Jj
	C113myqrV2HSinCyZoOLTFmns3LIZCA3IjOpXKlzcBZfZ64/FaWUmDmONRDoyL5F
	QvgNyBNyrUtRmNQDApW/qZL5c/l78h/Iz0aeIQf/Q2eIYL7dgU/iqihNfjgFemkh
	hRN34Ef/+BbXlgyPaOlivZ7YxNqg3ASdYLPnwla5ottWMvBXETXyWR3G7gE6ADBV
	Unm2oQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9s2b4fnp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 13:19:11 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b37620eb73so8503834b6e.1
        for <linux-i2c@vger.kernel.org>; Wed, 14 Oct 2026 06:19:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791983951; cv=none;
        d=google.com; s=arc-20260327;
        b=cB2jDvd1jtA+T3pfjiA1+TrnENisD35/7oT6wjoX2UsrR3t6KpssbfxhJqoI90kNNk
         u0u/1qg6CPwo8Ys6no2JKSfgRXNDwUozbWvvKA3v8/3BzJ5W/zZTX3rjr8r1wUTRkSzo
         Z85uahfB2F+pFAb+EEOC3U39EGGbTXxQr529v0MDlIWGi/j1G72GjZS0xHCvrML8enHO
         nLhDyCnSkS9L/8wxL5A2W9lAPz/4J+q6CipP/Ho+/iJog7mlKNirAXmNuUho4Cj6rAKt
         Iwom0uGVie2sHJAShZ0bosCb4XXrl1QHksmnL6mrRU7vK8o3HqSUcuKsnr4ZJmXGtbFA
         d7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AbyY7L02Rxh26+8dxarTEhQrgLb4aPc0R4YmO2fQi8o=;
        fh=H8yPC+SeYPiZDwwiHPuG+EI1R2j+acd2Vva6m7COCp4=;
        b=VCsZu5iqY3BFNdOlwBTFlgmTnLQSZHmm/OMss0Ysy+427s4eQoRKE6vDWnUv2LHRgt
         UwU8UyZLBepvwYMpXcBKzR+Fm3ascitIIosDn2oxFmt6QWf6cI3t1FJOdRTb017XYxDV
         UvCi7iTUcNULQY/0VZtrSgEdw2OSNJ8C4Ol0BdnKsWXPWjpIpeE5t8HoSD/lBHmip0cz
         G6ToTXnOi7fJTQ1Lfn07oaTE7Nee14u4FvDw5dMnuJHBu9dqYIrluOM+UNIKbxoskkku
         8bNBDMVoIPQpbGzLvG3a9WtjbGMb2Psm+Uto9nFuv6BzdwRSqI47p5Zoop3zTAmguQ4v
         AFcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791983951; x=1792588751; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AbyY7L02Rxh26+8dxarTEhQrgLb4aPc0R4YmO2fQi8o=;
        b=OoiN7LAnnjXiQdTqj+NsoDCFizO4djPAcbVdP7Nx28gM42XLXpve1MOPKK58kIYXQT
         pNbO2OyT3ImxuFhdY893dkQefTgFEoq6HecEte5AmDApDhvPcOP8bxXb6nwnXk7to2LH
         LNhw/pR8nCQ+c7rR0V0tqxcpSJmtoZ6VyeT+K2RWScCW7plq1VgzVMXI0qpCRS/GH0TQ
         sJSHMBDb/haKHchBS5ah+QBcW2bjxrdpInUsenTCmFEDICIH7Ot6DQBEbMcmivyvAU38
         xEY5+wgVFQLfM2e/c/Yq+5h+T0EJPu4IJWZqGuBB+k09M/6D4HTcCm921SJRCyMGEczt
         MLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791983951; x=1792588751;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AbyY7L02Rxh26+8dxarTEhQrgLb4aPc0R4YmO2fQi8o=;
        b=y0z29rqolt5j9WAV2Q42x4nrNbNwwlj06naMSkrcumatmfzceHyntZ/XV4ZvAcGYUc
         LG4SsMpPHE3IDbH7Xjbu/2qtGnPSPu7CQ74XxB1ovr4m7C/RpE+aXrtkAR8EoVeObjPj
         KVzEwWnlBxsPj+VQ4kaLyK/WtE/bW0Znhiv7nK9hZ2SjafcUogGUtCiGOGCdpS2rjn6o
         YIPjwCrsVDlN8T0oFOoVLmmqXFTsgcCgWCYP0wQGNaChgqYdLym6iAh6t77VfXYvMPZu
         Ju9gFU6B3uKIhFw5hPSpvQSv3Z9wZ+WoyjE15dBb8t6p3nZ/OzpAN6CB8H89AO99DDZ4
         SMKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzN9/DoTw82G+K5Vuw/zgH20GEZF8uK5ClPVDuMe7sPL0luJwU6IWFUwNLmdU08FCiyRqRjncwdkTU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxdD/YG/HMRregOdnpQ9F1TooJ343pK/FdCbF9RChb7DRBHQHb
	udjJPMd5ZpQ8ZPp34501OwXJn0X6OyQQmtYotgNi5fJTy23ecbQ6X4EG6cP4BD/xiPvS7NDzSZ6
	wVVgL5DlRf6CE+K6+7ku+ApQSVU2r5+CRW0HPUAS3zxhbiBMjf9TmklYNW6B6+f6S1bHul9esgX
	s1xagI24OJBMobG0e373P2TzfYd1zZuLxyqrbMvg==
X-Gm-Gg: AYBFou02EkMRLnHW3gRBKiKlB6fBxdAHl/l5n6/r510GtvlZw3r2+6a9YR/JVd4yfgi
	2HCvBlU5dGGjdWWHC2krCUII31dZw+nIlnACVZd63CSMpIsvzJplRBGjNTofuyNpdS9deTOShqM
	n5I6rZVR8EtFYCTzPkDseZkmjj8dO/vJGD3fUTBp512BbEigPtnSYz8hZEOkHjynC3cn96s/hls
	Bst546zWQ0Sqf3+6+zbpsZHGl1thtY4bPxJ/0cIBA3uTUspDb0TgkUrlzorNY1XfWD9J9uIPe+x
X-Received: by 2002:a05:6808:3203:b0:50a:6fcf:d287 with SMTP id 5614622812f47-50c5804970cmr14735559b6e.37.1791983951010;
        Wed, 14 Oct 2026 06:19:11 -0700 (PDT)
X-Received: by 2002:a05:6808:3203:b0:50a:6fcf:d287 with SMTP id
 5614622812f47-50c5804970cmr14735512b6e.37.1791983950378; Wed, 14 Oct 2026
 06:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013-cci-imp-v2-0-6873326b44a3@oss.qualcomm.com>
 <20261013-cci-imp-v2-1-6873326b44a3@oss.qualcomm.com> <d39189f9-e9fe-4019-9b64-c4d7c0694c4c@nxsw.ie>
In-Reply-To: <d39189f9-e9fe-4019-9b64-c4d7c0694c4c@nxsw.ie>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 15:18:58 +0200
X-Gm-Features: AclHuK_Mz1Imq5hkpEYTlM0BjO4RGLxYs653XPdMkpOfKA6siGSGzQJSVK3xg4Q
Message-ID: <CAFEp6-1pYGy-TdQCY0pK8Nir3fg1hun_0pfdmH+j45sHZd8vnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] i2c: qcom-cci: Factor out write command queue programming
To: "Bryan O'Donoghue" <bod.linux@nxsw.ie>
Cc: Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=RPQmjIi+ c=1 sm=1 tr=0 ts=6acf814f cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=PJnx2EBGx5yzlk0kfSEA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: XZov7Z6ICBCDZ2hoDEqDgEEZfcQjgD1D
X-Proofpoint-ORIG-GUID: XZov7Z6ICBCDZ2hoDEqDgEEZfcQjgD1D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfXxI3BdV/mvWHP
 B0oOZVKH4M5yu6mOW7pOPl6a5EB/nJGGlIAP81f4xADpslGjBrryPEvNaKfM/6curwLQUQ7ou+m
 zcNDxYrKIEOHfopmGot5FTb5NsBJCXQ/eRKXWYBRRgeOvHRtzKkFy3iZ5YWYt+Zhsx6YS25QW7y
 GUcTWZC+hkyXFOrq7Zg7JhWBF5jQc4RemrSgPdzsjR7Gtv9b6qGs3LmGYnyi/VC0H95OLFPP8Q0
 fOWnG45oLGYIoWq4vIk1cwVISn2HJJeh7c4OTGMYYQv1jHSpNMxBiDbAsgM3pOZSTYZXqtOK79H
 dhy7j1gh4KeCJqGRl60W3zLaadJJIUEQtJsa/By741wqF3zjS/Fo4PKKzFidEi1L6JS4wmtb/sN
 9v7UU0Tffd8TSRKQZUKUL18AAUS1Cea7U/+amztrsPDFjjbswRXOoYwF0Aaiqe+V/8aktqCpYWZ
 4JBW6wbtUDKTi+/zE8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MiBTYWx0ZWRfX5+28FNDxKKs5
 YDgXWLqGgZTgmXJQJBOftOMXhL+0O22zRMVg3bOOQc0Dgi3l3IZekAfVX91X/rY6joIBUtxXj6E
 kSq2575P4UCQeWVsxZV8LYPK+R9SNdo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140052

On Wed, Oct 14, 2026 at 2:53=E2=80=AFPM Bryan O'Donoghue <bod.linux@nxsw.ie=
> wrote:
>
> On 13/10/2026 11:30, Loic Poulain wrote:
> > Factor out write-command queueing into a dedicated helper and replace
> > the manual byte-to-word packing code with iowrite32_rep().
> >
> > The resulting code is easier to follow and will be reused by
> > upcoming burst-write support.
> >
> > Also add a sanity check on the write buffer length, which should
> > already be validated by the caller/I2C-core.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >   drivers/i2c/busses/i2c-qcom-cci.c | 41 +++++++++++++++++++++---------=
---------
> >   1 file changed, 22 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c=
-qcom-cci.c
> > index d509dc1c14700d9c199d67df19082bae4f1ae470..3304760411082b72e10e529=
a2bd66361e100fa06 100644
> > --- a/drivers/i2c/busses/i2c-qcom-cci.c
> > +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> > @@ -77,6 +77,9 @@
> >   #define CCI_I2C_WRITE               9
> >   #define CCI_I2C_READ                10
> >
> > +#define CCI_I2C_WRITE_WC     3
> > +#define CCI_I2C_WRITE_NWORDS(len) DIV_ROUND_UP((len) + 1, sizeof(u32))
> > +
> >   #define CCI_I2C_REPORT_IRQ_EN       BIT(8)
> >
> >   enum {
> > @@ -485,42 +488,42 @@ static int cci_i2c_read(struct cci *cci, u16 mast=
er,
> >       return 0;
> >   }
> >
> > +static void cci_i2c_load_write(u8 *buf, u16 len, void __iomem *loadq)
> > +{
> > +     u32 cmd[CCI_I2C_WRITE_WC] =3D { };
> > +
> > +     if (WARN_ON(len >=3D CCI_I2C_WRITE_WC * sizeof(u32)))
> > +             return;
>
> Why not trap this and return the error - cci_i2c_write() has a result cod=
e.

Because this condition should never occur, the I2C core is expected to
enforce the transfer length limit through our max_write_len quirk
before the request reaches the driver. This check is purely paranoid
and is not expected to trigger even in normal error-handling paths.
Not returning errors keeps the behavior aligned with the previous
version, though we could have catched this issue earlier in i2c_write
and return from there...

>
> > +
> > +     cmd[0] =3D CCI_I2C_WRITE | len << 4;
> > +     memcpy((u8 *)cmd + 1, buf, len);
> > +     iowrite32_rep(loadq, cmd, CCI_I2C_WRITE_NWORDS(len));
> > +}
> > +
> >   static int cci_i2c_write(struct cci *cci, u16 master,
> >                        u16 addr, u8 *buf, u16 len)
> >   {
> > -     u8 queue =3D QUEUE_0;
> > -     u8 load[12] =3D { 0 };
> > -     int i =3D 0, j, ret;
> > +     void __iomem *loadq =3D cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(maste=
r, QUEUE_0);
> > +     int ret;
> >       u32 val;
> >
> >       /*
> >        * Call validate queue to make sure queue is empty before startin=
g.
> >        * This is to avoid overflow / underflow of queue.
> >        */
> > -     ret =3D cci_validate_queue(cci, master, queue);
> > +     ret =3D cci_validate_queue(cci, master, QUEUE_0);
> >       if (ret < 0)
> >               return ret;
> >
> >       val =3D CCI_I2C_SET_PARAM | (addr & 0x7f) << 4;
> > -     writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
> > +     writel(val, loadq);
> >
> > -     load[i++] =3D CCI_I2C_WRITE | len << 4;
> > -
> > -     for (j =3D 0; j < len; j++)
> > -             load[i++] =3D buf[j];
> > -
> > -     for (j =3D 0; j < i; j +=3D 4) {
> > -             val =3D load[j];
> > -             val |=3D load[j + 1] << 8;
> > -             val |=3D load[j + 2] << 16;
> > -             val |=3D load[j + 3] << 24;
> > -             writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, q=
ueue));
> > -     }
> > +     cci_i2c_load_write(buf, len, loadq);
> >
> >       val =3D CCI_I2C_REPORT | CCI_I2C_REPORT_IRQ_EN;
> > -     writel(val, cci->base + CCI_I2C_Mm_Qn_LOAD_DATA(master, queue));
> > +     writel(val, loadq);
> >
> > -     return cci_run_queue(cci, master, queue);
> > +     return cci_run_queue(cci, master, QUEUE_0);
> >   }
> >
> >   static int cci_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], =
int num)
> >
> > --
> > 2.34.1
>
>
