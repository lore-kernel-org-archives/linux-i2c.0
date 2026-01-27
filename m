Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22817360722;
	Tue, 27 Jan 2026 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527766; cv=none; b=Y0PU/BqAPsJh7g0gRuScXSDahFBQ8KGBxwg/FGwsKFVGth67g2LxGwu3W+ly7duBdlYPU1ld8EGwVQNIZa7cqDK6nuw8+d8M2QgLOZy/OGopOJ4i2TtBVTKqkbgrJ0xHBlRMjL6kmrt0p+9n/V3f2yvRlAggS4dnm/klJbUywnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527766; c=relaxed/simple;
	bh=AKLJbR/KlAL9SljrU8mc6FOUSv1pvYd4WPqN0dt9YIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVI5asnlZQMCVeg9AZlzYYGFKWVX8Vy2oKZ12fRhocgXGJs4xCWun32egofh/0z0g2rjOrGBXVpNK2XHpmNWEgeRiupstIW4Fh7B+Li2UkGQ95ysiXPlvJ+zMiA0hP0Air+DoNKD3Y/ZNWFjVe7i2tMw7+Kj/73iQnG1BKHvFY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z2qzWTM6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z2qzWTM6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R6uQj7031862;
	Tue, 27 Jan 2026 15:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V6SETC
	5Ts3/9vHXxTwV4Ir5HTCj/o2RBYH2zvpX0w1Y=; b=Z2qzWTM6iAXxXTeOo1+3Cs
	CNq0ivdlaFtUWLIZ/aA3S7T4S037r156fBp1XCDti7+fFgzDK7FwGACOWMFY+ufS
	l9x6hIgAC2jL83QrXso1apPo097/Nl+ZKhBQuIYJ8hSpgNWQJp1RSoXcYg+h61f3
	PdOuc6McJRJK5YWI2h2MzYLlN1mmdRpx2Jj6sTHb+LNBguiSJOQXlfuq77BB9Dd/
	HYbneaGwjNYvZYcsdZkmsrjeIwR3MRvGbqqQTRTI8u9A6xu63KR3iRMiYwSgYRlu
	4NnEAqZEBmDd3XKvlsabJ0JIe+G/d94hyrt2eS9xNyKYbjsw7EWKCFs85gFWNK6g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmmn0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:29:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RD4EOV031030;
	Tue, 27 Jan 2026 15:29:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bw8dsh8rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:29:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFTHDf28771002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:29:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 532F05805D;
	Tue, 27 Jan 2026 15:29:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10AFE58052;
	Tue, 27 Jan 2026 15:29:17 +0000 (GMT)
Received: from [9.61.135.234] (unknown [9.61.135.234])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:29:16 +0000 (GMT)
Message-ID: <cfaf48f2-2da4-4fdd-8a13-3d1e4edfe70c@linux.ibm.com>
Date: Tue, 27 Jan 2026 09:29:16 -0600
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/13] i2c: fsi: Convert to fsi bus probe mechanism
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Ninad Palsule <ninad@linux.ibm.com>, linux-fsi@lists.ozlabs.org,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1765279318.git.u.kleine-koenig@baylibre.com>
 <d8c27aed45bf3119c08c9772768d675ae2ccc0c3.1765279318.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <d8c27aed45bf3119c08c9772768d675ae2ccc0c3.1765279318.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6978d9ce cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=1eIz69aPJHyW-ZXEaOoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: tKWRegKq6mg35WSSxDhsRF-1KfRqCdtF
X-Proofpoint-ORIG-GUID: tKWRegKq6mg35WSSxDhsRF-1KfRqCdtF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfXzakQI5lHQdhC
 FldYAXW+KKsJx447cKaxt1x4+UI6C2A0Fh0a0Jsuf8YATSRen3jsoKSCromuZaJVUOOx0cneid6
 NoVQWUvHkgM0eRnB3FE9BQSSZ1Z3CNDR/dTok0BsJKN7qDuhGbDeGvRt/Ce+z1biyHR1HwBIXTX
 CtMQAre68VALCNx3LDhknpflKietfp/g1INNkNAaBNiwZe/ywcwNnvX2EBp1jbeijkfHWg7xaQq
 ICeMdaBGA1F5stfNHVrL+oAzSgvJUOa0IfjASvBSpN8FxtSayGhN2iYC/irapE56B0gJYnxjdkn
 /RKf834UtZBebrKQkIrYJXjA59kDHS/rWD9mEHVHo27d2PQ9rF8o/Uy5W4+cnJuEdqH0vsbBKN5
 0rnY0oXqthHhFVCi3eTn/nrw4L6movg0CQT7El3zjLKdOtBZqHpUdv1rnyBmX3IEaj0ot4VyqxW
 fxRmchr/BXMfXbBMU6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601270125


On 12/9/25 5:40 AM, Uwe Kleine-König wrote:
> The fsi bus got a dedicated probe function. Make use of that. This fixes
> a runtime warning about the driver needing to be converted to the bus
> probe method.


Acked-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
> ---
>   drivers/i2c/busses/i2c-fsi.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-fsi.c b/drivers/i2c/busses/i2c-fsi.c
> index e98dd5dcac0f..3a7e577e6eac 100644
> --- a/drivers/i2c/busses/i2c-fsi.c
> +++ b/drivers/i2c/busses/i2c-fsi.c
> @@ -674,8 +674,9 @@ static struct device_node *fsi_i2c_find_port_of_node(struct device_node *fsi,
>   	return NULL;
>   }
>   
> -static int fsi_i2c_probe(struct device *dev)
> +static int fsi_i2c_probe(struct fsi_device *fsi_dev)
>   {
> +	struct device *dev = &fsi_dev->dev;
>   	struct fsi_i2c_ctrl *i2c;
>   	struct fsi_i2c_port *port;
>   	struct device_node *np;
> @@ -735,14 +736,14 @@ static int fsi_i2c_probe(struct device *dev)
>   		list_add(&port->list, &i2c->ports);
>   	}
>   
> -	dev_set_drvdata(dev, i2c);
> +	fsi_set_drvdata(fsi_dev, i2c);
>   
>   	return 0;
>   }
>   
> -static int fsi_i2c_remove(struct device *dev)
> +static void fsi_i2c_remove(struct fsi_device *fsi_dev)
>   {
> -	struct fsi_i2c_ctrl *i2c = dev_get_drvdata(dev);
> +	struct fsi_i2c_ctrl *i2c = fsi_get_drvdata(fsi_dev);
>   	struct fsi_i2c_port *port, *tmp;
>   
>   	list_for_each_entry_safe(port, tmp, &i2c->ports, list) {
> @@ -750,8 +751,6 @@ static int fsi_i2c_remove(struct device *dev)
>   		i2c_del_adapter(&port->adapter);
>   		kfree(port);
>   	}
> -
> -	return 0;
>   }
>   
>   static const struct fsi_device_id fsi_i2c_ids[] = {
> @@ -761,10 +760,10 @@ static const struct fsi_device_id fsi_i2c_ids[] = {
>   
>   static struct fsi_driver fsi_i2c_driver = {
>   	.id_table = fsi_i2c_ids,
> +	.probe = fsi_i2c_probe,
> +	.remove = fsi_i2c_remove,
>   	.drv = {
>   		.name = "i2c-fsi",
> -		.probe = fsi_i2c_probe,
> -		.remove = fsi_i2c_remove,
>   	},
>   };
>   
