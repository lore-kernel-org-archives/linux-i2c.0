From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 5/6] i2c: designware: Discard i2c_dw_read_comp_param()
 function
Date: Thu, 12 Mar 2020 16:50:14 +0200
Message-ID: <59545398-5320-5414-7e66-64cca94bf54d@linux.intel.com>
References: <20200306131955.12806-1-Sergey.Semin@baikalelectronics.ru>
 <20200306132326.74A92803078F@mail.baikalelectronics.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200306132326.74A92803078F@mail.baikalelectronics.ru>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey.Semin@baikalelectronics.ru, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 3/6/20 3:19 PM, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> There is no code left in the kernel which would be using the function.
> So just remove it.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   drivers/i2c/busses/i2c-designware-common.c | 6 ------
>   drivers/i2c/busses/i2c-designware-core.h   | 1 -
>   2 files changed, 7 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
