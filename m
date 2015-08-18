From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [patch] i2c: xgene-slimpro: dma_mapping_error() doesn't return an
 error code
Date: Wed, 19 Aug 2015 07:59:01 +0800
Message-ID: <CAFRkauCLM+g5sipBbzYVYLDp819hajHXGhWRU11Te-0RmcPiEQ@mail.gmail.com>
References: <20150818091219.GB3965@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20150818091219.GB3965@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Feng Kan <fkan@apm.com>, Hieu Le <hnle@apm.com>, linux-i2c@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

2015-08-18 17:12 GMT+08:00 Dan Carpenter <dan.carpenter@oracle.com>:
> The dma_mapping_error() function returns true if there is an error, it
> doesn't return an error code.  We should return -ENOMEM.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Axel Lin <axel.lin@ingics.com>
