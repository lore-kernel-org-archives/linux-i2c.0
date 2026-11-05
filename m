Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868135;
	b=R7XpdXebOBSp8sGWxdBIiDaXIcCKpIESQg34O6gzcCDtKhjbn2iA3wSabC6WZ6/X3pwS
	 XjjZnJigYk+5hLpcqMJl0WBOreVI/PTx/osQDM63p9U71fvoICIWyWoriEDUi+daWfiTZ
	 H2XBqVPVqMaC0qaQGaz405N7gi4YbAW/F25rwxKejct6LVH9UZMnf+lkl4CY+DIvvNF58
	 xck/HQzSDMqiPBcUieSeP8sQvgMgi5/IsePuaJZpjNBTVjOdFsZPE0cZPp7LI78Bh9NHy
	 zwxRq/1fwpFgOEMLwurnFlTOtUJ/MqK3m4hBSPtE3oAyscUbnD5j8iMrZ48B0tVFFcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868135;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1NnQLqR2uCMnd3itzlh8VaOt0O3sai2BlY8pcFdTdmQ=;
	b=xdDmGNSGAuo+ot1DYqMkOxO27jiweBSCQy4PHh60+MEavFekpGFDEtlR0GXLBiM50cjm
	 bhYt4hK27YcNEgeL9+oW5D2T7VKJBnqNJHKKPOxgFB+0zUEIxcK6piKkIFUTTIid3Nv56
	 XW9xWNyI4CyG5VvIm9Biy7cixhRgX0T35skP9POkr5lZyCKhn8IPyUxbx82yqu45ymUNE
	 y6DZFIXoSNRE9DQod0K8TXKOoiyCBGyT4B4+6xZNd2/GUpx7Em3kZxGvoB11xqEzGQ6uQ
	 613zCsspfAZg72VH6jJaK6DNwEzbv5u5LokE/jn3wO2Ql3Y19GZCOfc82QVjyOyDujg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U4ctk/e9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D600606A328
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U4ctk/e9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170E61F00919
	for <linux-i2c@vger.kernel.org>; Thu,  5 Nov 2026 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793868135;
	bh=1NnQLqR2uCMnd3itzlh8VaOt0O3sai2BlY8pcFdTdmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U4ctk/e9mR76UFfWfNOi4UBakuAFAgvSnuMzSCONjbimL9Cmh/iCW9hfY92HjHYRc
	 1ikUEYqDBRbs9oe7VQrQrcaNFIHjZDOYt6OxxNKF0ft4p9bKIFxeRqXywmIlf5GtNS
	 8VeWq3fXHnKoVnxOu5ULi8PyGi21xD8I3IZ6tZ2h4YGFtKCUeT3ZzC8qVuE8DI1BYL
	 LmYmwCClAxbBL7tBgZwctIRXLpeW9UgowwkihVU72hG0qOFx6Qp29B5zKFXb+jleuj
	 5SjeUMaoodTCFvb3M7YgCwpFiaXUyEBOYt4OpFb+nrAO2h8uzR/kkyT/Uh1PW8zZKu
	 iGcE7XV5M3MAg==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5ba3fba0080so1216172e87.1
        for <linux-i2c@vger.kernel.org>; Thu, 05 Nov 2026 00:42:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBy9KM5VMRM23JvN1xf/ne6h5vIMjIQ9u1BjIkSrj5DmgMbjj4n2/z65wnnZSR0cw9YuOF7/7MwSux8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yECcLOwEzmS2putorSn4gLsKNLrWeEGk0s1MbIFqI8qMune+C
	N0kVyEWzgHKCZL/gxgrVArHtvlNmZyW18EGo2kJ1LgC+8Xb3lOW+l3t97qNAoNDmuR7L7fXJ9yp
	bFhrjDSEixCSFNnpMQTtsxhEX3oXSgm0=
X-Received: by 2002:a05:6512:3d1e:b0:5bf:d653:ff30 with SMTP id
 2adb3069b0e04-5bfd954bb16mr6226650e87.7.1793868133918; Thu, 05 Nov 2026
 00:42:13 -0800 (PST)
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-i2c-nomadik-fixes-v1-0-655c6af2cb70@mobileye.com> <20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com>
In-Reply-To: <20261103-i2c-nomadik-fixes-v1-6-655c6af2cb70@mobileye.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 09:42:02 +0100
X-Gmail-Original-Message-ID: <CAD++jLm+m+YNhTaUnTm=dwO4p8xYe8OjZ7qhQ9_u15dnxURiVQ@mail.gmail.com>
X-Gm-Features: AclHuK8NQyqVDfhK78w809jJIaVTKTrl2fy9xxD5EKcQscvjepyMgbErwdGzdGo
Message-ID: <CAD++jLm+m+YNhTaUnTm=dwO4p8xYe8OjZ7qhQ9_u15dnxURiVQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] i2c: nomadik: handle pm_runtime errors
To: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, 
	srinidhi kasagar <srinidhi.kasagar@stericsson.com>, Ben Dooks <ben-linux@fluff.org>, 
	Andrea Gallo <andrea.gallo@stericsson.com>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 9:30=E2=80=AFAM Dmitry Guzman <Dmitry.Guzman@mobiley=
e.com> wrote:

> In nmk_i2c_xfer(), pm_runtime_get_sync() is called on start and then
> the controller registers are accessed without checking the return value.
> If pm_runtime_get_sync() fails, access to the register of the device that
> was not correctly powered on may cause a bus fault or other unpredictable
> system behavior.
>
> Check the return value of pm_runtime_get_sync() and it if is not 0,
> return the error immediately.
>
> Signed-off-by: Dmitry Guzman <Dmitry.Guzman@mobileye.com>
(...)
> -       pm_runtime_get_sync(&priv->adev->dev);
> +       i =3D pm_runtime_get_sync(&priv->adev->dev);
> +       if (i)
> +               return i;

It's a bit odd to reuse the i (=3D iterator...) variable for this.
I would just add an int ret or int err for this.

Either way semantics are right so:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
