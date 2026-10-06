Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775A2F6562
	for <linux-i2c@vger.kernel.org>; Tue,  6 Oct 2026 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323358; cv=none; b=OU4eDhv2i5HUhXUmlCzvTlEBJ++zW7iAACHb0oK9e+dsR+c1Kbjct2wFuN2p467lwMBsbWza5mwt1bobjNm82r1QCfQi5NnB1L3BLIYQs43f25N4yOs6HOYzBK4jypdMba/GKexL7VzTBD4vNLt8NkLuVzA/FXHCzcZKBHX/AKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323358; c=relaxed/simple;
	bh=poluRrFSmDIlB+/zIiUoVzpJ86A8vkad5nYfGvBnzmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTCDoZuYbfX6E+FQeLoXc+DfpYapICctJSjWlcciaXQJecmKOiWjPIk7lAndJWqUonnnMajUJOjGUL+yCD71zB2Em1x0PpOrBBFVZrj6x9wgkFm6wuhbgmRal6Rk8sWNzUNVEZ/onbTDRBHWGDLiXUkVdav8EYeuiz+RhZrp9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=e/gWFdwp; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="e/gWFdwp"
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B088B3F788
	for <linux-i2c@vger.kernel.org>; Tue,  6 Oct 2026 21:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1791323352;
	bh=poluRrFSmDIlB+/zIiUoVzpJ86A8vkad5nYfGvBnzmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=e/gWFdwp2u3bkjtUfUJu30eth+tyUKW78DbJ6X17S4/giEoVaBAhAZVKX45kxTeo2
	 +d36kJ4AybcRy2wnd4zVlT/5a5vvse/7+DGtNnWwoDGduqjgQoavrAzeLQWN1oTP4M
	 IOxwSWRFI2pIjXLdoVS6YAVp8izIYKktMUB4NgwB5bOcXLuA/bwxCbXxpLJ9Exfyqb
	 vwt3Txr3uwj8gDx4uos4UMlHhh0gOa18iKssQavSDdUxoQDFkwU/NXSfPuiz/iZ3+U
	 Bw2eRxrbmdXjb03e5U3gFCr4C9bVOq9/Cxnu+aXZyh49XbX1tcp2nX5k8jfPzHD6Qu
	 2lui6CXNoTdEMLP2h4rvfWDkETa7Xk4FOgrP3ELJO2CJ0dzObLl7mNmEQY7FgWEU+j
	 buAVuTYiswjs8WI+Ni/eqpW5drJ1Pdrusx01GNdI5gDPACgDFGYqjshC9zlR8kOb2R
	 BZDM8UnkjWEd58vzclI39+sJEbmyXlv1WrVNG5oCiYTjMFF+O4xzfr2+15WoR/o5cH
	 R2YUXx0la18ZUrJ06GMlovVBjUuMqWYb8BZMHNXBQYnc2kwiSIKHDmR7AMAZp6VdtW
	 QU0WkWXwkVooiknFypSKQBgQequCQi0dVOiKrVAej6gBLDWDv0pzzJfpo6qCvPtofj
	 5Yoo88kaofsYyeEhyySzRYJU=
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so7403358eec.1
        for <linux-i2c@vger.kernel.org>; Tue, 06 Oct 2026 14:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791323351; x=1791928151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=poluRrFSmDIlB+/zIiUoVzpJ86A8vkad5nYfGvBnzmA=;
        b=kP3JZsSV/gp0b9PeU86VudCnXTPSWif0cvo/efIICIEG+DsBmU7nzkc7J7cmEKK+t6
         GcCVmMId81VzwZe+AYx2qhcpaDRV3CHjx363Iqor60L6iyofbcS8xT8H54/AsSwRHB5v
         bnDfC7lqxykLaWoSAAWeyQdOGF4QjYptxq085T1PemE6SR0jiZN3zGbb/kWhSqaJyb1/
         kQZnfgyhCZl548pAcyo3xbhn7gO2lMiq2ne0amoYLZhtC753KHCXbclpHX0YJsrp9zPF
         GuqmIgbAbM8Ll1sWKCVRqFS4eZPdvXXyHpW7NqFem7KeHzkVxRAl04BIJyNzYZIGkSlg
         uePg==
X-Forwarded-Encrypted: i=1; AKwUvByM+NtvEoPV9n5gIRgHdmDWB/wHgYQYBz3/BIeEwtsd6KFiWqzbaDBjNicuczS+epx2T/uJ9TbLTK4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDVgtv/jRJxZeOXPgNEYp7ef+lrsFNXb6wlvu2LV9Q3ljvLjur
	pEwIieFyb5vqu+bbLINuKXmjYric95ogc8exMwijfZpE0bky7jIdk99FeMR5T3LrnHmFsZeJ8Kc
	O4tYJemGd24mPVmByGa3AbYjhg20ZwJZ4jDP04s7RLvYBWJ+6/Iyt09Rqc0znarRAUzx4zNOic2
	IkWg==
X-Gm-Gg: AYBFou1tLcebZoADbN8vcsEsdWBHDoNne52owax3otIMUEQ3VLZQBkaaIgRnwwajfzb
	o85qjppsYyaHwdO8x0S5SiolynKJFIYOyVnjnRcV5fhmXsQygfzYpSB7QzG9Ft2txkT76uIjGwg
	eL0MHybi1gnLAvRAVsmHfLMeuuI+ERnviUyFpcoKGLb6rvl3VN7TGSueYMAiOvqzSArrM4OSlot
	9kGpuCwhmC134AE3xh340CFTSE5hu1HHie8AkWoXNKNBgGQ84g6kO5v8ZPwv0eQaZ/H5IvuDC2l
	rYwwB70iXNGuy6yFL46s8OnQ9ZanKcZv+tKR0WJDnI5lSR1IwTg0IPFA03edLermOCmzbI6SFKs
	qQ1oERq5p1cntX81WlQ==
X-Received: by 2002:a05:7301:db0f:b0:33c:e74:4625 with SMTP id 5a478bee46e88-3515de89918mr138828eec.28.1791323351072;
        Tue, 06 Oct 2026 14:49:11 -0700 (PDT)
X-Received: by 2002:a05:7301:db0f:b0:33c:e74:4625 with SMTP id 5a478bee46e88-3515de89918mr138771eec.28.1791323349201;
        Tue, 06 Oct 2026 14:49:09 -0700 (PDT)
Received: from localhost ([2600:6c40:657f:4180:3a1e:4952:21ef:b8ec])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515afd00e0sm1271255eec.23.2026.10.06.14.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 14:49:08 -0700 (PDT)
From: mitchell.augustin@canonical.com
To: abel.vesa@oss.qualcomm.com
Cc: andi.shyti@kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mukesh.savaliya@oss.qualcomm.com,
	viken.dadhaniya@oss.qualcomm.com,
	mitchell.augustin@canonical.com
Subject: Re: [PATCH] i2c: qcom-geni: Restore the source-clock selection policy
Date: Tue,  6 Oct 2026 16:48:41 -0500
Message-ID: <20261006214841.202946-1-mitchell.augustin@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928-b4-i2c-qcom-geni-preserve-source-clock-v1-1-9aded7552a76@oss.qualcomm.com>
References: <20260928-b4-i2c-qcom-geni-preserve-source-clock-v1-1-9aded7552a76@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mitchell Augustin <mitchell.augustin@canonical.com>

Same issue on my machine. This patch fixes it for me as well. Thanks!

Tested-by: Mitchell Augustin <mitchell.augustin@canonical.com>
Reviewed-by: Mitchell Augustin <mitchell.augustin@canonical.com>
