From: Ben Dooks <ben-i2c@fluff.org>
Subject: Re: [PATCH] I2C:SAMSUNG:Select I2C_S3C2410 if HAVE_S3C2410_I2C
Date: Thu, 24 Mar 2011 10:47:51 +0000
Message-ID: <20110324104751.GS15795@trinity.fluff.org>
References: <1300957573-2622-1-git-send-email-tushar.behera@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1300957573-2622-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Mar 24, 2011 at 02:36:13PM +0530, Tushar Behera wrote:
> On Samsung Kconfig files, HAVE_S3C2410_I2C is selected if we want
> to enable support for I2C. But the I2C controller is selected only
> if I2C_S3C2410 is defined.
> 
> This patch selects I2C_S3C2410 when I2C and HAVE_S3C2410 are selected.

No. Do not do this, just having the device on the board does not mean
you want it forced into the kernel. A user may want to build it as a
module or not build it at-all.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
