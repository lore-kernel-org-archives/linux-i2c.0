From: Guan Xuetao <gxt@mprc.pku.edu.cn>
Subject: Re: [PATCH v2] i2c: convert drivers/i2c/* to use
 module_platform_driver()
Date: Mon, 28 Nov 2011 09:02:30 +0800
Message-ID: <1322442150.8661.3.camel@epip-laptop>
References: <1322439206.2709.2.camel@phoenix>
Reply-To: gxt@mprc.pku.edu.cn
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322439206.2709.2.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Jochen Friedrich <jochen@scram.de>, Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <w.sang@pengutronix.de>, Manuel Lauss <manuel.lauss@googlemail.com>, Barry Song <21cnbao@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Yong Zhang <yong.zhang0@gmail.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Grant Likely <grant.likely@secretlab.ca>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2011-11-28 at 08:13 +0800, Axel Lin wrote:
> This patch converts the drivers in drivers/i2c/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.
> 
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Jochen Friedrich <jochen@scram.de>
> Cc: Peter Korsgaard <jacmet@sunsite.dk>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Manuel Lauss <manuel.lauss@googlemail.com>
> Cc: Barry Song <21cnbao@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Yong Zhang <yong.zhang0@gmail.com>
> Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> Acked-by: Jochen Friedrich<jochen@scram.de>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
For i2c-puv3.c,
Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>

Thanks Axel,
Guan Xuetao
