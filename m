Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F093587DE
	for <linux-i2c@vger.kernel.org>; Sat,  5 Sep 2026 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788623574; cv=pass; b=PGwv2FiaHkyIYQE0/9zz2+FRlkr8Xm0QUogMHAXu8Zo7dzvHCSs285GVsPliPAKrVcLhF5gvnw8GqT8bHASDBicYrX6z0l03SOZFX9dDvEUFf9/gW+gTpnW27F7SJYwiKdskxSqt0/DfDbuXohX3xuD9TgOjRP1H38wYluhfGwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788623574; c=relaxed/simple;
	bh=Kv0M8qyBz8AiZgOwtl2kafCJPZCOeq5ea1CJHXP95kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jm98xHLXj03DyDfn2t1sIfEULD77LrqWozq8lNxuF6QwaqEnpPfUiGZl3Cx5KDEQHjvKesC4w3X5oqafmTvT7/trjZI5z7r4HnUOdGRnRDTptM5vEyrMR+w9Vs6BsRXIgEihXYgQdHwyHtiRUJ3+WvLnSOLgmY8UctJYnsUxBzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwCWJ/Wk; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwCWJ/Wk"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so2608731e87.1
        for <linux-i2c@vger.kernel.org>; Sat, 05 Sep 2026 08:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788623570; cv=none;
        d=google.com; s=arc-20260327;
        b=WoVy3BWwZv+xVAO3c3rujAgqSv6VfXMyt4IIGUNYU4yiFYqKchdK7AW6SMAzMSXQzh
         LwkVamO6EKnogAOWUOpGhCS880sHAt/fIai2DhqeYrlBEsALlfzWW4t6MHLap/qSoeAz
         cgh3Z5awyxZCL7FYFyKVl2sW4CDlmzGk6q4JKBXtCSZK4MXoQxv/OFw1pb0axfGTB15g
         WZrPmFD+OoMv0o8+cGl1jsuhzCt5u6jPbzpj4FDFvsVzQND9902BMact0wCOldQnQpMn
         5RlsZUM64+EkftLdrKLFDgiv1HY1Klve6TLo86J27U+QjunM7rt3PO6gB4pXmxZIE0bY
         xj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kv0M8qyBz8AiZgOwtl2kafCJPZCOeq5ea1CJHXP95kY=;
        fh=gUugE6bHKnQxeIQhU7Q9lFFQgAuZOAVYFAdSiW5zvdU=;
        b=HfCUiTXcg96UbYhtuR4tpH/7eohv8ZT4hvuzgqP4tlYCC7XlZH8AmhZlFzmF4VDCeB
         RAabOsS46v4VVs+E1jjPfw69uhcJHJ5MHgNEb3rslO48B40XkO72RurekPs6Thz/wt8Y
         b5FgugHqsqfUbt47/zN9bHH++XVkhQW9fKgqrY4WAl4WqtGIrSHN8KjGo8b/Y3UR+sbe
         ycmvEXLgVWh7R9Hzw++aY5SY+uLf1PqCpL/ECVQ3ExjGGsqvaXiqfRKx+yvUxoraCTBQ
         CzO+nNfopIaIJboFLWeXX4uUCUrogQ5+ecHddO0xHokppmud5uAapph3bymnOl/IWayZ
         WxZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788623570; x=1789228370; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kv0M8qyBz8AiZgOwtl2kafCJPZCOeq5ea1CJHXP95kY=;
        b=ZwCWJ/Wkmk54JCJsv+brbbazhG2lzR69i2e645S6SoVdDNQ7EJYfbpc72aTvCqxxQv
         SKoNK+p2qhFs9ZHuBFugLLyiB+4j9ZIyPvkr85DQeqNOQWQqzt2Er1hMLZ1SPxIqYEiQ
         qT7n9PuG93YP0KrJQQaeU8GP7A4UKjkmyuULId+bCqh79K1vx9rKd8o4mGD3IbN7BSpk
         zBJpVWopXSG3+tAkl92gWrkkpeaXENzaZrAMUqefdSdquRO6pWfHDB0GpyMAPCI7ZkWW
         46RgmKesMedhqyD1Y7z2TQEzEOnyqQpGN9zeoxyoodbdWQoOIRYYkbmBthga1Ny5UrZX
         lyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788623570; x=1789228370;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kv0M8qyBz8AiZgOwtl2kafCJPZCOeq5ea1CJHXP95kY=;
        b=Y22LgmOi6VuKUM+tdjtrEHPI8GfDLLtu5kLKisj8if0BehV7r8gPWjjxn7IhAo5d6i
         Opcl6/B1YYhIMPDcQ2eYt/3PLdnUZ4yerxvy3BpP2DaSCZGImAX75QMIPNPhwN/FDsAC
         QxNfpBRzX+B287Dzfyvxe8299nYn8HSPKwz2mCF77cXuAfb2gXdw+eGUUD197Cr9B9HO
         VG9avkE4+HZr8mW2BeDecHJ1Src+aiVRAaxnB0eYzVG6CDmdUO8YC2AS0VI8odMyF1D8
         q1eklLFx7b/yrVXvmrKlwj+KOAHO/6TzuZkBElS0u2/i9QsTm0SfCjMM9txgye7pXkeU
         6R/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxRVxstAIijQ3sDS8KK6Xka1yedhoQ9U2wek1EEhE/jLYZcqo7p0FglTVWu3XNSrqdDPIDodb5+zdA=@vger.kernel.org
X-Gm-Message-State: AFuF++lKC426URSbLzpY8LakQX/DH4Dq6MKF4fPwIASGueHS/CHRMdzh
	z63oCKFW4OgKLIFWrKsqnb9HCkLfhCXMChsdcza2RjyKV1hacLqx/2e0IcOT8gcrSCEq8iu3Ylw
	pHPRi+nPlH0ntnuwK1iOyigdGKz+2/90=
X-Gm-Gg: AYBFou163f9+zUDdVD8+zXbPk3nODWbu1/Q5mbN44avRcWlwZGY4bVm7PTmnq6OAXfZ
	QPljW9ujr+wN0JNrVbBpwhRo/i4sUC8OodFkLzlgRZ2ikDjtB25LQ7vrLeoEMJaAu34r67QxEOc
	MKVUj1oLtvwVXIuZ0l81v7dILZweYvI+o78WRsx89DscaX9fwFgnQeETF79vpazJW7EMkFNgUEa
	S+HOLcRb0RpwijMLQ635SbXVi5JQO19MYJphGMmlg/ZSlOv6+lHpZlltNOgqd1oePvJ8QAHPF7N
	jDD/kcGb2mKGuSLuFZ6xkjqB3+GQFilaRhZTKq+reLGJgELHvp9v7PqBhoYG5KdlWPHD0VwvqGv
	JKMs6AVnImS5dqUO6lKmnxEQv9LM=
X-Received: by 2002:a05:6512:10c6:b0:5b3:12b1:be93 with SMTP id
 2adb3069b0e04-5b6170dee63mr1554897e87.0.1788623570165; Sat, 05 Sep 2026
 08:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788298883.git.ahmadexp@gmail.com> <89780f7db207c7fe7adbd45e1f38f0a041794c8f.1788298883.git.ahmadexp@gmail.com>
 <apnRfWVAiXj1fRXs@ashevche-desk.local> <apusvKc2PnSShaoI@gryt> <apvJaBo4Zzz2GAMx@ashevche-desk.local>
In-Reply-To: <apvJaBo4Zzz2GAMx@ashevche-desk.local>
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Sat, 5 Sep 2026 08:52:38 -0700
X-Gm-Features: AcwNN1Uulc5j99vd1g8KKcjM_9c1_I_u87n5sCZVaRosxcsgyccAcFuaDvKiJZQ
Message-ID: <CAOQiBWPf1qPcVqFGyw_L2zn46+Nkp8WZpkodM3sC1hpFgYnEHw@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] i2c: mux: Factor out channel node lookup
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Peter Rosin <peda@lysator.liu.se>, Andi Shyti <andi.shyti@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Peter, Andy,

Thanks for clarifying. I'll use one declaration per line for dev_node,
mux_node, and child in both patches in the next revision.

Regards,
Ahmad
