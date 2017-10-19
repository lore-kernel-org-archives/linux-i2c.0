From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] i2c: davinci: use correct format identifier for size_t
Date: Thu, 19 Oct 2017 11:27:39 +0530
Message-ID: <402f5d01-a9bc-16f7-ec4b-2795b0e8bdea@ti.com>
References: <20171017221709.24992-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:52177 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbdJSF5o (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 19 Oct 2017 01:57:44 -0400
In-Reply-To: <20171017221709.24992-1-wsa@the-dreams.de>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>

On Wednesday 18 October 2017 03:47 AM, Wolfram Sang wrote:
> Fixes this warning (found by build testing with 64bit):
> 
> format ‘%i’ expects argument of type ‘int’, but argument 3 has type
> ‘size_t {aka long unsigned int}’ [-Wformat=]
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
