Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055A377566
	for <linux-i2c@vger.kernel.org>; Mon,  1 Jun 2026 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316978; cv=none; b=TJL9vHjaTrcqJYjf0PNeHZ7BYk+hogzN7rTxtDz4D61OmUyq0qXyL3QEfk5amX1Ua1O4+1+iKYl6Oi2cCncEw34K1kvdimDsPZGh5BglnV4eNYrYZ7EwkjdPKU4WYnlwQ9vJ658SrHMof5LlXpH6Bv6y5zqGNCLw3vH2RoQeJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316978; c=relaxed/simple;
	bh=ny+wAHdqEOaKrFj8CvBy4UtmaRQCKuIbS4xOVKA/7kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uA+jIP/CvDB6h2UUc5+xiprRLKmu1dkPxa6LXtPbsh3RY3V2xK6hMrJ0WgsGSxuDOeloEpVm8lvkQBbNO/0+sflH0IKyoZVTUJmanIjUTo0i+YyzCLK1v6biCm6i+W5f9XHE1NKepdI0JKKXOpRHSiZj8dalcwLdW0YL46aRyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bi4B/jNx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rl1oPq3L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bi4B/jNx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rl1oPq3L"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651726qR2868365
	for <linux-i2c@vger.kernel.org>; Mon, 1 Jun 2026 12:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pLiCd2ui5WJUBbl5aYIyNT
	wd8tg16vlttS4+PppSHSA=; b=Bi4B/jNxzJ54Z1XRvMgqAyLF+o3ioBLI3RSwIp
	ARfSt+47f55GPPnJEqIIVNmMikYYgH5MZ4f0JdYdyyy20wbv1kSMVVJ0YVhQiTle
	gAs2hBspyu7uRxoYkQqLIlZNp3qU0p1x3QIDwxH1nXa/BBQm8h/9dDGK4QHdJ5Rr
	UWTfzwrmq077hXl0vByK7i1PjtNiqZkqpST7eWGQI7D3ETSeJ2BO2HLnKinVW7Pf
	pVOJlJvYL4I4hM9WtAqYPZUnOID4u9limQ8hvpWWHk6zBybSyuHDY6fST7AUp0Ws
	LdK5oHFv5xZK4NhxxzscQ8B7vwFOqgAN11vLkrYH839LT7IQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7ffmjj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 12:29:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516d6cf547bso26787051cf.3
        for <linux-i2c@vger.kernel.org>; Mon, 01 Jun 2026 05:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780316975; x=1780921775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pLiCd2ui5WJUBbl5aYIyNTwd8tg16vlttS4+PppSHSA=;
        b=Rl1oPq3Lq8tcPXwNDX5wYn3YgaMCJ9paKK0ngdQCRDoHgPymcvTR0//6eGu5oqLo19
         HwzGTnsNjBfHtNOq5S3ihhny51IjjmUk7UdFRHWIvqRGsBW5hWq6otGpAcfNLt5KV+ZQ
         15CrRjp+X1fH0hM4uhReydCvECB0mVOKoRhbd6pWDCUq9b3W4LjCi4nP1cfMrfG+4VUg
         uC207/1tVWkB30uMkWQBqzNelLkQnBivIW8hwfiy2wkiBYloxiacUsgykC9HsnppkAwt
         qlMgotDUFlG5Z/k2W1zs2SAWEk72vLuxGmNPD0R7IfxattIahjLxEJ5Ybb/Ny+u7fynN
         r/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780316975; x=1780921775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLiCd2ui5WJUBbl5aYIyNTwd8tg16vlttS4+PppSHSA=;
        b=XKUMwob9dcgbAV2gpIWXtjBjL4H9s/w0aNVwYRTYJRGAgZZdR3kSHqYi/y0TCpbmXf
         VTj/35Dzo4n16soIOAKyVbnLnmPImL0i+HhlUFElGHT81MkGa5hnvlVSaqzM8VOOjLcV
         PJjeTQEBn7K76T502SWBdd6iefQXYSb8CyqaXe0lPmc3VZJTo3I1SEq2JhBzPbTaNd3n
         cOWSYoVKsCWQ601fOE2aXM5it7Ps4BHidWBKCz2WSudWKPLd1r/oDvpKKn+bztiGoITj
         dLR5EkwrQUzAYxxAwhewzJYmvbsRygKA0atIQmQlkZgQC6fkpiK4n2NQFNyi/07XeVrj
         /23Q==
X-Gm-Message-State: AOJu0Yxvv0UHtaA3QH18fLucFXC9uTK1wKyCTGv0v29ILZEX+Vk+NuuD
	PcAuaUyX/bt5+bq9D49dVYFxAf+UJE80IZf1Mqpl7iPBn2M2iWpIa37RZ4nPad53HI+q0mCkArv
	ir5U0zb+esug0SiRtPyHFtznYItBR33/rb9pL1BGiMcaG8QmR1YR+bC4xPIPGaybEwgW3w7k=
X-Gm-Gg: Acq92OEqxAq4KYZva8crj7cG7BrgMHiN/y/UqhsoJbGC+5Hzi7gYJGlxaboltIofBPB
	BzRY18YBqPWTVKg/zI+Yw5QMAGZkzU7N6zfpLr4C3iCLibGmcNH7bYit3Z3r7DYFfeAuLuAXeaN
	Xx7xK8t0ZVYT5y6t1YHG5xA+q3NwvUPLTiYSEXYOu7aP8POTKalu0QbQd5GkeVXFLJAR1i63WJa
	O2nw4VZO50YYxcij/VRI0PDyoNSkeSPH0dBvCt18QYmAC342dlZcA35NHj+KG0abdsEnr5s2U34
	r8SuCesGtg5C6smrMXlS6wNoO7CEuH4I/cHMgAB8knXbOpn5/xEb9tSbj6pLRibtALG7uthMJEQ
	RS+D4XOqrf8RQAVFrDj8bdACsVRIx6DhUy8/+e9Ng9aM7m9YjS4GkIcx2z9unW8Utwe2BQA8Rbr
	Dw45zfzYiAECaUWQ==
X-Received: by 2002:a05:622a:59c6:b0:516:daa6:fd22 with SMTP id d75a77b69052e-5173a834863mr160933841cf.51.1780316975067;
        Mon, 01 Jun 2026 05:29:35 -0700 (PDT)
X-Received: by 2002:a05:622a:59c6:b0:516:daa6:fd22 with SMTP id d75a77b69052e-5173a834863mr160933341cf.51.1780316974596;
        Mon, 01 Jun 2026 05:29:34 -0700 (PDT)
Received: from brgl-qcom.local (2-228-54-83.ip190.fastwebnet.it. [2.228.54.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3595ef4sm23925375f8f.37.2026.06.01.05.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:29:33 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, brgl@kernel.org
Cc: linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] at24 updates for v7.2-rc1
Date: Mon,  1 Jun 2026 14:29:22 +0200
Message-ID: <20260601122923.3714-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2wq6sYWiecSZ_zAGfZNleN8fTCbIvclx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyNSBTYWx0ZWRfX8tibacdx06j0
 sUAN7QCYZWM0/YRdh3GCC8uTfo7dvM8PQN32dQOi3PvqMn4ZyHZo2pjBkS4JR92weDsVHoj0OIV
 flEA2QFHjm+o18uno6ed/r4EMX/ynhh47EGNntMZThUwX7nvLlxW6vGOjFqzIzkQMIgFH120uoH
 Plj6JMiOvK35R3jYz0E9paZPzsltDn3XOPmA5R0bQMg2j7Y09LAkdHL18XVyT9A9V0O9vgL0lNi
 A068+srJiIVQXCikhjizOseJ8jTY7N8ylXQFOE+CkOMM/o60kGYub/5l16ASrFjjkbTU6FPHXPy
 7DWWA3x/eoQ9uD72S16zwVmFTDfsS/sQ1XjRIvA9V2x9E9/MttpATy0PFikMN7zDZK4/CY9KC08
 64FJlQiHeXxb/VDrWcGSDASLgPDq7fuuqHOIwG8gnvLM/87iluNOygLsY7pAKELWjbluem8SFGV
 E/gNZLcZdb0P56K2cfA==
X-Proofpoint-GUID: 2wq6sYWiecSZ_zAGfZNleN8fTCbIvclx
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1d7b2f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=F4J0OHcPalsv3C1teIDEwQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=M-WlpKoQUZIhws24ORwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010125

Wolfram,

Please pull the following at24 changes for v7.2-rc1.

Thanks,
Bartosz

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/at24-updates-for-v7.2-rc1

for you to fetch changes up to b4c01497688528fc04c717842f8f310569f52629:

  eeprom: at24: Use named initializers for arrays of i2c_device_data (2026-05-20 17:10:55 +0200)

----------------------------------------------------------------
at24 updates for v7.2-rc1

- use named initializers for arrays of i2c_device_data

----------------------------------------------------------------
Uwe Kleine-König (The Capable Hub) (1):
      eeprom: at24: Use named initializers for arrays of i2c_device_data

 drivers/misc/eeprom/at24.c | 62 +++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)
