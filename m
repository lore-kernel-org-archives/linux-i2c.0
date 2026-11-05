Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905980;
	b=ZjOVjKUTUCB32KwPDD0zp8M9xU7Uwhi0pOQoQp1TrA6b2NGamb5Kepq+s4oGFrBaYERe
	 61d1cLHuTIzxwFlYUhiZCl6mWmqvcCCZdnZJP/77NulBfaoVql41rDOnpCWH5hkidpNNE
	 ziYMMvRKs6rWrkZ49O/A74zt7mMcd6yt4EgigGtcJjhIY32n5ocjU9bSyB4geRc/ut1EC
	 BVJrySs2SUf/UrFE5u2i9vmShlnowG+Bh6r4Gd300Fpb3zJ2KbuBQ66gk6rWfxMfeeBCB
	 NhRhBg3lkWg1m95v9r2jdXnQ1Xzp3zY4MvKO5D/kGQrF9rzZ+JrNx4ulCNc6MWZpeEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905980;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=m0mMRhns++zcKGrTP9aBFlkK9JTY4c9NYzIr6VNARtg=;
	b=J/etDbMug52LDa0HGyPcmGwkVnJP6ApyJNyldL5sn/83Fd98EodJUouLsQh6Nl4xOUyJ
	 /GM0+E8bEnh2a69abvR+76zv9o9xrh9PFpZ2/bIRiaUT2G2Rp0kIWjX8P9tRsaLUKYOqE
	 tqK/PAPjNANfHbJYsD7E3t+mKJ8jVdqBimE+CN+uSJmurug3Xp8AMAITWaB/PLvhEkNR+
	 StrF+Pw+fhBwoVj2zn5jvYTRVAjqi60bsiiIpFPwHkhLyYvsmVA9/de8FZU4wHiTOm4YN
	 UGbCJp2iqobG1ouCRfDRsraeKFPSzZWi1AdVFG92yu09XAiyNgA0nJgCH4QIQpnF87g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LTFS6EhJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eAviCzlx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9A0606A328
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 19:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E9A0606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LTFS6EhJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eAviCzlx
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5HeMwp1485106
	for <linux-i2c@vger.kernel.org>; Thu, 5 Nov 2026 19:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m0mMRhns++zcKGrTP9aBFlkK9JTY4c9NYzIr6VNARtg=; b=LTFS6EhJ9WZlv/J/
	1Er/jeH2zi7+21FYJcFpQXbEM5AYbGgVJsacUbV2u5dBmhZ2HZFmG6Xwk2raLyRC
	AonFVdNlLfY9ctnRw/YTKAJt3BdRll3iAde6TC71BPwwtBd041LiSzGxx+jcfANK
	GeQU5L2S098AfuaCKAsEst7Mnadp5WtGu+YZppJzCr3nShQdsIrfZDtId2G/pA1j
	+gAvA1QLM2LbUAXXbf1oolOrBQmwVNs0D0riGKfr4BsJFbsv1+KkPWIXiN0J5De5
	UkJ8FUE6Lvc5IZFgBu9gPaKCfB6QrBqdlL2jP1LKVE40Fgyk3or7sC7n916pNckS
	n/mK9Q==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaaju20-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 19:12:53 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1af203073e0so3396572c88.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 11:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793905973; x=1794510773; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=m0mMRhns++zcKGrTP9aBFlkK9JTY4c9NYzIr6VNARtg=;
        b=eAviCzlxBAEt/RtGxGISp20QkZvjKbupA+aOd7rWcPcaaaRaHjPyujG3mn2/rNfHf0
         XlHCdwwS63exgoAsRxdJyD+c2kvKxCIe3558FcqqJdXdS8shGzW60YX5JizE7k41Aedg
         MPKOcI9kmW+QflFjc7rH1XSfCu23vhY1t8pBtx1n+i/lU8/iZkBVMQHBjgXS4fLxC7nZ
         00SH1Lb7KvEEkpyE1PWU0c38nAefqbTuRLtXkXw3QJP0AvqlyJz/sU2XKEvKgVajtQWc
         VC6UfmUV8fkXAkHBvt+mXU9uGI5D/fcKLjOOdz1LzBhYf1LLPq8jrCCr0cwZjZ5cnsel
         n0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793905973; x=1794510773;
        h=content-transfer-encoding:content-type:mime-version:organization
         :references:in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0mMRhns++zcKGrTP9aBFlkK9JTY4c9NYzIr6VNARtg=;
        b=GtfAgs0OfF97lAFO6f3twL2c7dnW75HOgC/p3+McOwJniYjmbYnUKn/cuhIrSCpbix
         u+pU5pe/qE5Kjmx0o7kldJtj1pGE2MBI0FP+ZU+HwQoDeWN6H9IaedloUJ146vzvMcw1
         P6RI8EhyPACmBCpLYTbJQhAsPGo3js59L4BY+ezB1QgfEfzIDuLkev0K4iwKWJsldmxS
         cRN2crL6OVoCA84bzO4Sxz+6XBPoxrpm6NLhHQZfvq4xziaoKD+qecf46SCHt0fCsJgj
         kgDSCcTCMX3lrZ5k0L95vFg6LfQ91Ukx6o9xngwaafU9vNQApYO8pwMzTTLat3OIPn3J
         gEHw==
X-Forwarded-Encrypted: i=1; AKwUvBw5e/Nt/X83VXXPQH20QyGtZrShLyZVijeKoqy20TFnMDNqLlsB22mPMMr2gZqRuvIb5z4IXHzbPIM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Cc7VTaSmN6w11l8QWmexOg3KMa5UJ8KLeTTsPpaWR5KiHNcJA
	CwAkON2rN0vovJVICkE3DQYCL22PS9ibGrZfJfMOlT6i4APUWRaWyBZh3wdY/NYwwDSEga2o4jy
	8HUsJpP92D7Yy8ed4sU+fSCXCuJITyokicrZxF5eTDdbh5b4gUxo3SS7JdQuXbEo=
X-Gm-Gg: AYBFou0bTiw2nqhWs4AEt6/1raAWGW0cDYywLFzx4zlo/gzVRDnC/NCcN3TeIfWQrR3
	JL4gKuzwB/JFnol4NLoIPoFCr4QgoiPrC4lC6bmktjbM74otgkvxqZGUuuWp0qy8eZZ7nUqwR7h
	cjr6kOyi8xWcdWpUtLiXy4059o4V+7TAWss2o7d+tu4ENMss+SGdi3FjV1fPXf8rjYqjZMyX7Y+
	kOP24r+P5bg6zIxB614PlIHWS5d4JCRw75CrGborNEdXMQFagz2b7h/gT3jUO9KcezVYdEQxYlc
	TchcyUtULYVlTAMqpvzwB2vI4IO1QL63zwjQb4hxPqL9LeBYEzNwkj8PwLTdboy+NqYPM9NTWzw
	Zh2TI6i3Qq2AgD82b34QkC7LdmrcuvrSR3pVrFh5EYRYISaewMJExlWySiMcgC8wj2tvzO8Hzwb
	v97P0LkRIVDCgLBnhGHF3CNVtzZQ==
X-Received: by 2002:a05:701b:455a:10b0:1b2:42e3:e5f0 with SMTP id a92af1059eb24-1b242e3e78bmr11296106c88.12.1793905972667;
        Thu, 05 Nov 2026 11:12:52 -0800 (PST)
X-Received: by 2002:a05:701b:455a:10b0:1b2:42e3:e5f0 with SMTP id a92af1059eb24-1b242e3e78bmr11296056c88.12.1793905971882;
        Thu, 05 Nov 2026 11:12:51 -0800 (PST)
Received: from localhost (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c748eesm17728365c88.23.2026.11.05.11.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:12:51 -0800 (PST)
Date: Thu, 5 Nov 2026 11:12:47 -0800
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Walleij
 <linusw@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v3 00/14] I2C - detailed transfer reporting in case
 of a fault
Message-ID: <20261105111247.000074c4@oss.qualcomm.com>
In-Reply-To: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
References: <20261105-i2c-fault-reporting-v3-0-515ad74ac4c9@mobileye.com>
Organization: Qualcomm
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3NiBTYWx0ZWRfX8hrXTqaUJRDW
 h8/WPSk6GPul8WCcpEuhjEbkIazZ1Pu/OKmTJ1j4pSXtmhcI+EZwGdq0O6urRU2Xwmu1s4oUyJA
 fNlPR4MuracGWQwq8/wWIeZ4pRaRDBGKFHT+7iM6Glzw1weCKmA+si3xb86CaNDxT/0F7DfbCLG
 Q0mFFCauNDaHVaEFfTvbjejGZ5ZF/Ye0bkn6GJ8mX5G7V/7KoCzNva2JGLTRohJTmKSXXhdDHko
 u2G79AB7o+ghaMx8XOEjWxlg4Wl0tfVyMNAnnUvQfr5Ozsribkg3stjc3OskmVqVr6VuisxdCgY
 iuOuPazJ9FsF4BT8KhH6mN70L7AXH339pbWpakIbsLmFJUGDysfj8iZz/A24NAcvWBxZ5tjjpFy
 McwaZ2kxwNprtzCR/kWkWTd24lib8tLCwUwLaYDwRIY1WF9wJeR+63PIp96Xk/PwkEkTMZ6IGkt
 vEgS9WyJ3MCST+Hq0ZQ==
X-Proofpoint-GUID: fuNlavI9-0L-Cs7GPBY-hcuYuCaHYVh-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3NiBTYWx0ZWRfX0fhfDDfyo2zI
 MSBGLNQ7twfLaeLsJIAKG6zCt3SpUoTyL3clEpnmnp8/Rx3MEchGfubfM5WIeD55wbxojlAkS4v
 zVWgt+dTtPyfBuzil1DcJZjbalXscHI=
X-Proofpoint-ORIG-GUID: fuNlavI9-0L-Cs7GPBY-hcuYuCaHYVh-
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aecd535 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=JvO64EORAAAA:8 a=8BD2oR26EWfAhSrP7b4A:9 a=CjuIK1q_8ugA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=Qz6KxWHdQ2_aS5WpiCfK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050076

On Thu, 05 Nov 2026 19:15:21 +0200
Dmitry Guzman <Dmitry.Guzman@mobileye.com> wrote:

> The existing API has function i2c_transfer() that transfers one or more
> messages, and it only returns a single error code if the transfer was
> failed. It doesn't allow to know how many of the messages were
> transferred successfully, neither how many bytes were transferred in the
> message that caused the fault, and also it drops all data received from
> target device before the fault. There is a comment about this in
> drivers/i2c/i2c-core-base.c: "REVISIT the fault reporting model here is
> weak".
> 
> This patch series introduces new API function i2c_transfer_v2() that does
> the same as i2c_transfer() but also returns detailed transfer report,
> including number of messages and bytes transferred before the fault. This
> also allows caller to get the bytes read from the target before the fault
> occurred.

Hi Dmitry,

Just for background, could you provide some more information on why this
information is useful?  For kernel side drivers it is remarkably rare to
find a real use case of partial transfer information and the
current i2c_transfer() return value approach complicates a lot of
drivers for very limited benefit.  Sure it is a small complication
to check for a low message count, but you do get a lot cases of it!

That leads to a mass of AI reports of bugs.  It would have been
much better for kernel side if it just returned an error code
on any short transfer. 

Given this is effectively going in the opposite direction I'd like to
know more.

Jonathan


> 
> For user space clients, new ioctl `I2C_RDWR_V2` is introduced.
> 
> Patch for `i2c-tools` user space utility that introduces support of this
> feature:
> 
> https://lore.kernel.org/linux-i2c/20260623-i2c_detailed_report-v1-1-b67259a31a9d@mobileye.com/
> 
> Below there are several usage examples with modified i2c-tools.
> 
> - Unsupported message (max length supported by I2C controller is 2047):
> 
>     # i2ctransfer -y 0 -r w1@0x19 0 r8000
>     Error: Operation not supported at message 1
>     0 out of 2 messages sent
>     #
> 
> - First two messages transferred successfully, the third one is sent to
>   non-existent target address and thus is not ACKed. The data read in the
> second message is available for the caller:
> 
>     # i2ctransfer -y 0 -r w1@0x19 0 r1 w1@0x1a 0
>     Error: No such device or address at message 2
>     2 out of 3 messages sent
>     0x32
>     #
> 
> - Target ACKs first two bytes but sends NACK on the third byte:
> 
>     # i2ctransfer -r -y 0 w4@0x09 0x80 0x80 0x55 0x55
>     Error: Input/output error at message 0
>     0 out of 1 messages sent
>     Message 0: 2 out of 4 bytes sent
>     #
> 
> - Message reading is not finished due to timeout. The data read before
>   timeout is available:
> 
>     # i2ctransfer -y 0 -r r100@0x19
>     Error: Connection timed out at message 0
>     0 out of 1 messages sent
>     Message 0: 16 out of 100 bytes sent
>     0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>     #
> 
> - Driver does not support detailed fault reporting:
> 
>     # i2ctransfer -y 0 -r r1@0x19
>     Error: Sending messages failed: Operation not supported
>     #
