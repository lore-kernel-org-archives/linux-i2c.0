From: "Kamal Dasu" <kamal.dasu@broadcom.com>
Subject: RE: [PATCH] i2c: brcmstb: allocate correct amount of memory for regmap
Date: Thu, 25 Feb 2016 15:08:03 -0500
Message-ID: <270d201d17008$3cae24f0$b60a6ed0$@broadcom.com>
References: <1456064238-6294-1-git-send-email-wsa@the-dreams.de> <56CB3A8A.9040401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33443 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933286AbcBYUIG (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 25 Feb 2016 15:08:06 -0500
Received: by mail-pf0-f180.google.com with SMTP id q63so38239781pfb.0
        for <linux-i2c@vger.kernel.org>; Thu, 25 Feb 2016 12:08:05 -0800 (PST)
In-Reply-To: <56CB3A8A.9040401@gmail.com>
Content-Language: en-us
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: 'Wolfram Sang' <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

> We want the size of the struct, not of a pointer to it. To be future 
> proof, just dereference the pointer to get the desired type.

Thanks for catching and fixing this.

>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>

Kamal
