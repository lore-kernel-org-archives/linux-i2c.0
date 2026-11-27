Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795775407;
	b=v4fY3w4rIVk/sA8PdceeSKxzSjcteq00RlADuKv8LOcleImPiwOrn3wOM4hD7EzmW7hQ
	 C7JQlIEPkF2XsZcvynaDim0euxtFfziQMv3FfQTTmoCOwbq9gQDyTAjOuq9/Xq983qWLO
	 nNVufV3nIGQRDzuviK6dGCBdw2UCd5IHwyO3/O/Z8FPSqu2kZYV14d21MLOrjj5IsgDtz
	 OGn/6E9bVtmgtWsmAphmGiuLF34TGBknlFbv2wz72tpAHcrZRLgfESpc0biyQaG5gvsYy
	 8xUmbIHUDzaecQDp9zUwMIZzcyH4Dy8JcqUcda/cOCb6ytef2I5FXBAqZ+IqZGn2bPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795775407;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LHoWDmO83nUIJwGp2ijnmT3r8R9SA8Kocc8GMOeWdpY=;
	b=0M8zKE0nqrEj9VMOavviIIgE7dJVha90nv3ASfb2j7zoPcK5HHQJRNNcfCGfjMmNEJr7
	 NQc3Z+s7HnKTiVyYB9xmjArTQTwlyZaW86Ud2D4N06gwrkQ7tlantRG6VcnIRxsMOgESZ
	 l7v0jjWbKF9MQxWXttVY4HBqkrfVnzMCpFxm+EDabvQE9bu2VyQVgy4F9RkGEqT7hiIhL
	 rWvHGZEYsZkBPTNyrLhd8zMGCFnU+ORmbwplicq/8U0MUZRZ94WxMTA7bdqzR58XsbgcM
	 cpa4UBuVgVrAUCPjEIonv3HhygYEBQ22WhwhUceMDY+T0Mt92ySxQG2TFKK3TJ4ASmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beGRJjhX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8F606A326;
	Fri, 27 Nov 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beGRJjhX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7821F000C1;
	Fri, 27 Nov 2026 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795775406;
	bh=LHoWDmO83nUIJwGp2ijnmT3r8R9SA8Kocc8GMOeWdpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=beGRJjhXZLxSuhuI8uCkyWxzjjU3YFgmKxBL6h/JwCB8I/e2wgYvba6l6MnBt7qA6
	 3N8g0frPXK7A3bHU7JnUgrdqPx1FwgWDjIpR56AyjFr6ikq8y2BqSCap6zgcCjlaXG
	 pJRMIL6Rxkec7bt3L9Ir//Nah/2Uw9Y6W+i/WWkz38enDzox/gvcq/JMhkv7YNXGYF
	 IEYi99IziBO2g84dn9agCXiPMqGtW3yLI8cGCLT3KuHJPxVIRoFJ1aAIEY+hJHBr37
	 Pu2Cw27Vyxj5uZllf1hB3c5uwIdnos6y526RtIsGjK376SP1zhPp11VRVrBIOf7WSG
	 hc+M2ajKAeqKg==
Date: Fri, 27 Nov 2026 11:30:02 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 0/2] i2c: Add Cortina Systems CS75xx I2C controller
 driver
Message-ID: <awlbkHttSAYifRiR@zenone.zhora.eu>
References: <20261124-cs75xx-i2c-v8-0-d0800b967886@gmail.com>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-cs75xx-i2c-v8-0-d0800b967886@gmail.com>

Hi Fil,

...

> Fil Dunsky (2):
>       dt-bindings: i2c: Add Cortina Systems CS7542 I2C controller
>       i2c: Add Cortina Systems CS75xx I2C controller driver

pushed to i2c/i2c.

Thanks,
Andi
