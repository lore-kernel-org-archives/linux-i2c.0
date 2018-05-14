From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 03/21] i2c: algo: pcf: make use of i2c_8bit_addr_from_msg
Date: Mon, 14 May 2018 19:03:41 +0200
Message-ID: <e9de96d5-a119-74ec-72b5-1965d71e5a42@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
 <20180514145330.4857-4-peda@axentia.se>
 <CAHp75Vcz72q1Oi9hCf1vp32h3GrrYSoR0BR7qacnka9eKB8XAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vcz72q1Oi9hCf1vp32h3GrrYSoR0BR7qacnka9eKB8XAQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-i2c@vger.kernel.org

On 2018-05-14 18:59, Andy Shevchenko wrote:
> On Mon, May 14, 2018 at 5:53 PM, Peter Rosin <peda@axentia.se> wrote:
>> Because it looks neater.
> 
>>  drivers/i2c/algos/i2c-algo-pcf.c | 5 +----
> 
> I guess for such trivial no functional change patches you may do them
> one per folder, and not one-per driver.

Right, will do for v2, if I don't hear anything else...

Cheers,
Peter
