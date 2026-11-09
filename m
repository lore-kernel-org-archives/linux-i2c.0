Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794209277;
	b=UkUVvX0ew++I2M3bIHZTCdO8XnaLRQD6mBiky0WUhPtjmQ+HYdnAEB3XV4yIenv8NbUi
	 2yroHyqzNy9fU1Q9yv7TZ29aWKLf+uaXDpEoz1H9X++ajXkRR50Sj2nm3Rwz8Trw4/U5k
	 qCKmhFcDnmoNLPPBoqhiaWDqIexlFxgo3VLvoxkQ8+ANG7EdNgi+4O459RtgfrqbctDtG
	 lkwm0uUuOmVfryS66UdB5YJwIVwY6hkw2Kwe1RuLRxle0yQvmuSY0veRe+5HaVG1SUmsk
	 vQ/5bp7yfx0D5oSSSW1cgTxrL/GPmVdJhMXKNHYrkCrKtNRT3OhV9heazwmmRlE9WwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794209277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=E3GSLX6Y3E8KleKfgQiE/C3m6qssnf8TIwA8ymgzC0E=;
	b=hR263pNJ1bXgz11pL0it4P71Lq5AtzQFyOFJhHZjPVaR2YM9iF/r8aDj59tnQbu6m0il
	 mAxXJVzsjKmFzsuWTMmruQLCHQ4C5iq9WkhOYOJb5NrBXH+cJhZMSC8t4HBekQOriHI+s
	 qvxuzHDfzyTdEMxvstmReVq39zgROyLCr3HWhI+7B4gq/Tmd/xspDc9AX6On23myMcVHh
	 OSJJrccHRlrnhPIc2m16hBiV6JQ4piDJqufJ+VF3Sntf5dNPzXfZoFIvC/vbTVikbvfLJ
	 G5jZ/DJCGSnXX4nsWho4NPGDM0xkO8o9W9CWdlQpz5wv75hpQ4NbMDknIgPmNvxcjhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69726606A325
	for <linux-i2c@vger.kernel.org>; Mon,  9 Nov 2026 07:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69726606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-491971ac844so485036f8f.2
        for <linux-i2c@vger.kernel.org>; Sun, 08 Nov 2026 23:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1794209274; x=1794814074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E3GSLX6Y3E8KleKfgQiE/C3m6qssnf8TIwA8ymgzC0E=;
        b=YsJJzZWoS0kA6/sx8xVmsiX3lY7D97+g6vmXE2cme19Nw3wx1YjQMQmFrHMzY2lCsM
         XcR7m9yMzZZuswXowtmaazeEYerimzOcQm72n3THFcnV/ZYKFFf6o5aRdPpKzQ84woP1
         gArrQlhv7cd+czWvjDX7vYWw+Iv+PdDhH/iL+9VJJyFGW3b0yz3xrIDgC4vpeLAVcI16
         Nd8eDoPS9WHdAjw//uYc65it8yepxLbt+KEGnULUWt8eOKO3lMN+IEEcxxH521D1/plX
         v8inpkSfVYu6aOmd0+AK7zC7l8ZPue95LJE+R1FOMYQdj9TxgT3YDsVxvTTCMMvK3qRH
         RSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794209274; x=1794814074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E3GSLX6Y3E8KleKfgQiE/C3m6qssnf8TIwA8ymgzC0E=;
        b=yAmCAmqUay7ECtFbai/GgGotydRQnFOf7zj1CbBIrmsfHeVmZDt8uCsZAvzdEDng9Y
         gqkjEwO++BsVaIzVqmV13dbBDmi/T7i6RYuZhTAmVwWXxu9oeNDKKF8atBJA4eGBwlYb
         cM2gs32JX963u/UZioOv1JwBXRimJafym4D889F9YmCx07B28oSiMmf9ZYhi4TLPofeg
         H1Ax7Iwn9/UHpmdCwwfbrpHXvOccL1INtijOddvr1XZKCT/RKXdwDdSa2Fa6uNG+eLkH
         wwuQMm6JhiCdsmAbG8jyRnARCoK+wCEDDQ32TQXhENSYwJ7fesdG77CHNYe/Yyskm0TO
         +nBw==
X-Forwarded-Encrypted: i=1; AL+hErHe6XbciQYsnaz0NmgJjehBegyAbfHx9Hk0+hhgxDn2JdnVP3nBRgGvX4HFrVTmbfvXFcTQ5qhllIg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/MKgZgDrnf9GjeC5r3Loxk8ii8NLq8DzXo6yMvkOibcPWKO4uy
	Lgl1J6khX0943DKlb6IwyeJOEYcq24ZtmMDR3KuU8FaCJ0wQL6pFrahBsE1fwlDK2uo=
X-Gm-Gg: AYBFou1stgsIl0c15/+TU2uFhCthntWVWTRNIoBBrQwTk60rp6zH0QwX9CmFe351HPh
	XZU1z6RFLazekjV5EOw9/o0HzOdD9l2IceUDNqDiXW+pw1hFG9OPg+nFVgMYbOR/GhauG3k/QWA
	SPhDBh+3IEDmf1SwzDxoJEKi4WD3etMpGd2+sBqf4GprfE4Ahl1WHG9CCVW5+Z6uHdxl3ZXvx32
	1TiELrFnZ4V1SZOOc7ZbZ83+SNwR0GHqx40jBxQh1PR1jPnyHAitVxgxgQf58k8FlIkfz1cQKYb
	YKhUxY0QPUAVvzX/IeGbEm8nVtED9KvL95YRXJ+STPujK4qtRpTWAS1tjgo5hw/IhU8DFUDuw3A
	MpVyNXwRoDug4YBUpcZDq1B7zjJ+ecMn3KG+k+UmiU89JcpJAWzfnOttU/Lajx3w09v98wRJxK9
	9jyP4cGf4Ncwe5JeXtCtfRr7ATPg3YFPZkpY+rHkwcUiWKDeFmfWvRT4rET7f1kzZMYxWvC5aSh
	Xs5/MxrDjlwSQeWRQAY8gEkvU0ZczuZnSaJPqBdjdJ58FJuE8iJArxWE3pqjexjkiP+TWx38kxP
	h1rqlJssQKGUujIaiXFK6rzKWsmXp5TsSSgMtDgsLnT35DGxhWWmDJftlBvk+cJiuchUEHeTjIX
	mIKEXDrjtCkozK2o=
X-Received: by 2002:adf:e18f:0:b0:48b:1296:52ec with SMTP id ffacd0b85a97d-49583ee2222mr5349721f8f.18.1794209273617;
        Sun, 08 Nov 2026 23:27:53 -0800 (PST)
Received: from localhost (p200300f65f19a904b11874a4d8ff21ec.dip0.t-ipconnect.de. [2003:f6:5f19:a904:b118:74a4:d8ff:21ec])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-49592f38e55sm8523279f8f.4.2026.11.08.23.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:27:52 -0800 (PST)
Date: Mon, 9 Nov 2026 08:27:51 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Marc Dietrich <marvin24@gmx.de>
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-i2c@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 2/2] i2c: tegra20: Add driver for Tegra20 I2C target
 controller instances
Message-ID: <avF1aKFpDAnJi4A1@monoceros>
References: <20261108212458.275980-1-marvin24@gmx.de>
 <20261108212458.275980-3-marvin24@gmx.de>
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Post: <mailto:linux-i2c@vger.kernel.org>
List-Help: <mailto:linux-i2c+help@vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-i2c+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fkuwnclrflkupg2u"
Content-Disposition: inline
In-Reply-To: <20261108212458.275980-3-marvin24@gmx.de>


--fkuwnclrflkupg2u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] i2c: tegra20: Add driver for Tegra20 I2C target
 controller instances
MIME-Version: 1.0

Hello Marc,

On Sun, Nov 08, 2026 at 10:24:58PM +0100, Marc Dietrich wrote:
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>

Please don't include <linux/mod_devicetable.h>.
<linux/platform_device.h> is good enough to provide struct of_device_id.
So please just drop <linux/mod_devicetable.h>. (If you insist on full
IWYU, use <linux/device-id/of.h> instead.)

> [...]
> +static const struct of_device_id tegra_i2c_target_of_match[] = {
> +	{ .compatible = "nvidia,tegra20-i2c-target", },

No trailing , before the closing } please.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tegra_i2c_target_of_match);

Best regards
Uwe

--fkuwnclrflkupg2u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrxdfQACgkQj4D7WH0S
/k4pyAf+PbxEvdqRidzu2MVCrCyWxeamOnr6Hnxx7hAjskfnXnOBNqZ10n3JDJ+U
r8iXDCToc1hMFO1yCzKSbqVSYpwzA2BvUAJQ8wngzhF5IMv4bqBBCvl0Ce1NfPSK
xHHV+dFRjZ53sshblFCv1TBnDdovJZ5FLA+q57pP3pDyMnDPJFRcTQj4praFdVQN
GScZLPkhaJye+EdS/X9gFIaxZK2i9E+FONR8OD9pt09l+y+0B/CGwm3M3BsWw02C
bS8D6rJ1FxFFawAvo/38LXSGhShN1Z/xNjeC4015E1Xb2NWTuQgBM44jdQLzixDQ
0j1UHQnBBm1bVAdXXZkIosER7AEa1Q==
=o0wN
-----END PGP SIGNATURE-----

--fkuwnclrflkupg2u--
