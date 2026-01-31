Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B1C3570BE
	for <linux-i2c@vger.kernel.org>; Sat, 31 Jan 2026 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769870165; cv=none; b=adZrHsl6fCBbJ2LmXkNDF/DC0YcWLI6ggv1jL4NYzA2vlUclmgFIXvHdVOLZgkZHfG0mIKz9fBkOQVcTlezEE+c+v/pjNhDBJrHDhFWmM8gnNh7buQXDjp59cErMAAj/bfwFSQ+2UAytGo4X82u3+eUv2TDpC+i7ZT6QcScNSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769870165; c=relaxed/simple;
	bh=zvie+874fTn75a3eXFaIOd8Atel+XaljTeurFJOSLEw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=E/dOjRpQWVAxTbRb9wyWUURX2ehKtdqc2lhQQcGrUKMxmbQl2Deb2mMXk0Uu1RBcfGVQU0+shfr30Q79CU0GiDQ2fEIh+Ont8SljNesb7/kWb8LcsKmg53PFF8evHZLg24l3HDCyvXvpB9loyRw6UfOeaBeQaTup4K73JI9ZJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UvJNrHet; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvJNrHet"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so2002277f8f.1
        for <linux-i2c@vger.kernel.org>; Sat, 31 Jan 2026 06:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769870161; x=1770474961; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sVSIbao0S7N2+ApNZzv364LLiL6KFRy4sHA0aE5O/xE=;
        b=UvJNrHetDiXQJ7grvTO09YccQrMas+qpNuHYjrT1A35wI8nCty32ItdvH8s7F6Tmxg
         WyHdePxPRxY+nJ4P7TVriQ+9s+pVU3eZl06629Xz/TbJ3f5Yh/LH0LqDZ+7/uss1uM9e
         +L1PNRWQ3KAj4Yrgj5NdJZXqj168XJRFEJ2SyLEEtJ1dree9wjpg+3zoZxlNe8wjSe8S
         C2MQ3sGIS64hVHZcpeaJtT1tXxyJw7TroNfV8a9MaFdGNmHj6Yi3oCtEZXGUtNmlhjsj
         aU/n5TUuXkW99bj+dHnLECGoWKDS41KUYFCcGWwzMh2/G9ijoiog/9brjljdDXrN9aZE
         4ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769870161; x=1770474961;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVSIbao0S7N2+ApNZzv364LLiL6KFRy4sHA0aE5O/xE=;
        b=SkzfiSgGujz5li2GmPWuIuxZwzRlogCucSezWOiZ7XUdx83LQyxHToOM7S1VXEljbY
         D6+cqgqqsOCt1PdyoZxxu6Fc4228eV1Dd9k/G7iMFu67FImzieL1VrxxbEyGUanyTyJJ
         L5zQJLCgRCEV0rU1ClXq3DrJVx64t/oU8S3c6roP756HpE8ZUvWgsB6+tQbwQgM+cmE/
         bSs2FEYssCNOh6i1IdsK9IOqQudoVTBjnDtCPN01hpfdl5iJClMxjiwQdrLP7bl/EXfm
         8JW3ezLwDKZHxlmuI0Kw1F3KWI2GI9gzu/jwmXU7aHkep+SIaovlsuoPIkJmL5VmCjzv
         wkFg==
X-Forwarded-Encrypted: i=1; AJvYcCWqZTBYZZttE7TU1qiORl4vj8GZqXlrRFVeewkJQtT/Rn1wgJarKWBcAHLS77kDKbGG1ngsdl0dRuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTfasf6OWS1s3LbljU02f700SRMofeQUYeCUlaCE6+6LRrfDRc
	7WsfVZ2J2cM9gfRuQu3FIvOWsa+WmIkkG/Be33mh6oIRQBwkLPWLIZZLYaJFztCJk8k=
X-Gm-Gg: AZuq6aK43hjdJ2tIDQ51JO96KqbFAR7UW9+WJW01nfdp4Spodgi3/Q4cDNex/QeciFc
	dcNP5qNsAgolpEALesXqgUxZkIy8cEE+QwZtfzAZnLls+F77kZFtq0TqlX+2MLvCFZEkKA5h58h
	wQhmXrPj9MRj6DS1P3INxqrFJHhDI2RaeoM0xGKNE/M+DACXr17v8zu3SS+buzsUBQPSyuejxDo
	K6nOe5bCKVfe3ZRFdg1L4fUzFNtzBRiQE68Xwjl7H8TLNvCgaRS6NqIqGIPETu/uOL4ujl7fmjS
	DDRo82S6TkFcx90AW2vd8c8trDydlNbVaMLGJ68wdkJWME7db2mEjhCgtaJ6STY/imeQsECsxmk
	Qn8d73zeVc3g5qd0qMzHnhGPCa1vqbfD5Imn/a8kyWSvpp9Qgr7ChnnLYQxyu/HTfarSqU0kB+N
	IA9vFjK6YdRRV2J/kA
X-Received: by 2002:a05:6000:4382:b0:435:99d5:9d8f with SMTP id ffacd0b85a97d-435f3a742f4mr9016413f8f.19.1769870160665;
        Sat, 31 Jan 2026 06:36:00 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10ee040sm29840712f8f.11.2026.01.31.06.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 06:36:00 -0800 (PST)
Date: Sat, 31 Jan 2026 17:35:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>
Subject: Re: [PATCH v7 5/6] i2c: xiic: cosmetic cleanup
Message-ID: <202601311615.10yziOui-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-i2c@vger.kernel.org
List-Id: <linux-i2c.vger.kernel.org>
List-Subscribe: <mailto:linux-i2c+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-i2c+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129-i2c-xiic-v7-5-727e434897ef@nexthop.ai>

Hi Abdurrahman,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Abdurrahman-Hussain-via-B4-Relay/i2c-xiic-skip-input-clock-setup-on-non-OF-systems/20260130-054653
base:   63804fed149a6750ffd28610c5c1c98cce6bd377
patch link:    https://lore.kernel.org/r/20260129-i2c-xiic-v7-5-727e434897ef%40nexthop.ai
patch subject: [PATCH v7 5/6] i2c: xiic: cosmetic cleanup
config: i386-randconfig-141-20260130 (https://download.01.org/0day-ci/archive/20260131/202601311615.10yziOui-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch version: v0.5.0-8994-gd50c5a4c

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202601311615.10yziOui-lkp@intel.com/

smatch warnings:
drivers/i2c/busses/i2c-xiic.c:1539 xiic_i2c_remove() warn: pm_runtime_get_sync() also returns 1 on success

vim +1539 drivers/i2c/busses/i2c-xiic.c

e190a0c389e601 Uwe Kleine-König    2023-05-08  1529  static void xiic_i2c_remove(struct platform_device *pdev)
e1d5b6598cdc33 Richard Röjfors     2010-02-11  1530  {
2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1531  	struct device *dev = &pdev->dev;
e1d5b6598cdc33 Richard Röjfors     2010-02-11  1532  	struct xiic_i2c *i2c = platform_get_drvdata(pdev);
36ecbcab84d023 Shubhrajyoti Datta  2016-03-02  1533  	int ret;
e1d5b6598cdc33 Richard Röjfors     2010-02-11  1534  
e1d5b6598cdc33 Richard Röjfors     2010-02-11  1535  	/* remove adapter & data */
e1d5b6598cdc33 Richard Röjfors     2010-02-11  1536  	i2c_del_adapter(&i2c->adap);
e1d5b6598cdc33 Richard Röjfors     2010-02-11  1537  
2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1538  	ret = pm_runtime_get_sync(dev);
2557b4ba04df79 Abdurrahman Hussain 2026-01-29 @1539  	if (ret)
2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1540  		dev_warn(dev, "Failed to activate device for removal (%pe)\n",
810199f7315604 Uwe Kleine-König    2022-10-19  1541  			 ERR_PTR(ret));


pm_runtime_get_sync() can return 1 on success.  Perhaps use
pm_runtime_resume_and_get()?

810199f7315604 Uwe Kleine-König    2022-10-19  1542  	else
e1d5b6598cdc33 Richard Röjfors     2010-02-11  1543  		xiic_deinit(i2c);
810199f7315604 Uwe Kleine-König    2022-10-19  1544  
2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1545  	pm_runtime_put_sync(dev);
2557b4ba04df79 Abdurrahman Hussain 2026-01-29  1546  	pm_runtime_dont_use_autosuspend(dev);
e1d5b6598cdc33 Richard Röjfors     2010-02-11  1547  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

