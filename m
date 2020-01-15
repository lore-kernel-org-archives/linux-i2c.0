From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 3/4] i2c: highlander: Use proper printk format for
 iomem pointer
Date: Wed, 15 Jan 2020 20:57:04 +0100
Message-ID: <20200115195704.GB8661@kozik-lap>
References: <1578992765-1418-1-git-send-email-krzk@kernel.org>
 <1578992765-1418-3-git-send-email-krzk@kernel.org>
 <20200115174337.GH1239@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200115174337.GH1239@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Delvare <jdelvare@suse.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 15, 2020 at 06:43:37PM +0100, Wolfram Sang wrote:
> On Tue, Jan 14, 2020 at 10:06:04AM +0100, Krzysztof Kozlowski wrote:
> > iomem pointers should be printed with pointer format to hide the
> > actual value and fix warnings when compiling on 64-bit platform (e.g. with
> > COMPILE_TEST):
> > 
> >     drivers/i2c/busses/i2c-highlander.c: In function ‘highlander_i2c_smbus_xfer’:
> >     drivers/i2c/busses/i2c-highlander.c:325:22: warning:
> >         format ‘%d’ expects argument of type ‘int’,
> >         but argument 3 has type ‘size_t {aka long unsigned int}’ [-Wformat=]
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Wrong commit message. buf_len is size_t and not an iomem pointer.

I'll fix it up.

Best regards,
Krzysztof
