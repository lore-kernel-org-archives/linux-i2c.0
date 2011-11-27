From: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] i2c: convert drivers/i2c/* to use module_platform_driver()
Date: Sun, 27 Nov 2011 14:45:23 +0100
Message-ID: <4ED23EF3.8030708@scram.de>
References: <1322374332.2226.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322374332.2226.1.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, Ben Dooks <ben-linux@fluff.org>, Peter Korsgaard <jacmet@sunsite.dk>, Wolfram Sang <w.sang@pengutronix.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Manuel Lauss <manuel.lauss@googlemail.com>, Barry Song <21cnbao@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Yong Zhang <yong.zhang0@gmail.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Grant Likely <grant.likely@secretlab.ca>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Am 27.11.2011 07:12, schrieb Axel Lin:

> This patch converts the drivers in drivers/i2c/* to use the
> module_platform_driver() macro which makes the code smaller and a bit
> simpler.

Acked-by: Jochen Friedrich<jochen@scram.de>
