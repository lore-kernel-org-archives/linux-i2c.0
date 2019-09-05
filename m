From: Saiyam Doshi <saiyamdoshi.in@gmail.com>
Subject: Re: [PATCH] i2c: muxes: pca9541: use BIT() macro
Date: Thu, 5 Sep 2019 21:15:36 +0530
Message-ID: <20190905154448.GA3378@SD>
References: <20190905131318.GA21280@SD.eic.com>
 <1d248333-abe9-cff8-ad29-d3b618643dc6@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1d248333-abe9-cff8-ad29-d3b618643dc6@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: peda@axentia.se, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 05, 2019 at 06:21:06AM -0700, Guenter Roeck wrote:
> linux/bitops.h should be included when using BIT().

It's included from linux/i2c-mux.h and it compiled successfully.
But if it's needed I'll update the patch and resend.

Just a question - What is the best practice in such case? Should the 
header included explicitly?

-Saiyam
