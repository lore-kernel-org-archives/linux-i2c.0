From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/4] i2c: pmcmsp: Use proper printk format for
 resource_size_t
Date: Wed, 15 Jan 2020 20:51:57 +0100
Message-ID: <20200115195157.GA8661@kozik-lap>
References: <1578992765-1418-1-git-send-email-krzk@kernel.org>
 <20200115174553.GI1239@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200115174553.GI1239@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 15, 2020 at 06:45:53PM +0100, Wolfram Sang wrote:
> 
> > +			"Unable to get memory/io address region %pap\n",
> > +			&(res->start));
> 
> My first thought was "parens not needed"; not because I like being picky
> but because it doesn't look more readable to me.
> 
> checkpatch agrees:
> 
> CHECK: Unnecessary parentheses around res->start
> #30: FILE: drivers/i2c/busses/i2c-pmcmsp.c:278:
> +			&(res->start));

Indeed... let me send v3.

Best regards,
Krzysztof
