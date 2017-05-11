From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] i2c-designware: add i2c gpio recovery option
Date: Thu, 11 May 2017 17:02:56 +0300
Message-ID: <1494511376.6967.13.camel@linux.intel.com>
References: <2259005.m0altzP21Z@dabox> <1966782.aCEMFj2YWU@virgo>
         <4a84d6b1-2bba-6f01-8286-49661ef45576@electromag.com.au>
         <32490844.DoY2McpBxU@dabox> <1494421981.16411.7.camel@linux.intel.com>
         <0aafcff1-6970-e99e-5b93-b0877ebf8579@electromag.com.au>
         <1494510791.6967.9.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1494510791.6967.9.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, Tim Sander <tim@krieglstein.org>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2017-05-11 at 16:53 +0300, Andy Shevchenko wrote:
> On Thu, 2017-05-11 at 09:24 +0800, Phil Reid wrote:

> I have briefly looked at the current code. 
> So, my suggestion is to switch to gpio descriptors in current code and
> then rebase your stuff on top.

For better transition it might be worth to create gpiod_ support in
parallel with existing and convert existing clients case-by-case if
needed, while discourage people to use gpio_ API.

> I wouldn't encourage people to continue using legacy GPIO API.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
