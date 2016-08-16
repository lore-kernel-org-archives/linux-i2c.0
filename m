From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 3/3] i2c: designware: do not disable adapter after
 transfer
Date: Tue, 16 Aug 2016 17:00:20 +0300
Message-ID: <fb003fe4-2f85-6c37-6af5-b9ad7e0c06ab@linux.intel.com>
References: <1469743424-2480-1-git-send-email-lucas.demarchi@intel.com>
 <1469743424-2480-4-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469743424-2480-4-git-send-email-lucas.demarchi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas De Marchi <lucas.demarchi@intel.com>, linux-i2c@vger.kernel.org
Cc: christian.ruppert@alitech.com, linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>
List-Id: linux-i2c@vger.kernel.org

Hi, + Wolfram

On 07/29/2016 01:03 AM, Lucas De Marchi wrote:
> Disabling the adapter after each transfer adds additional delays
> for each I2C transfer. Even if we don't wait for it to be disabled
> anymore, on next transfer we will need to if we have several transfers
> in a row.
>
> Now during the transfer init we check if IC_TAR can be changed
> dynamically, the status register for no activity and TX buffer being
> empty. In this case we don't need to disable it
>
> When a transfer fails the adapter will still be disabled - this is a
> conservative approach. When transfers succeed, the adapter is left
> enabled and it's configured so to disable interrupts.
>
> Alternating register reads on 2 slaves:
> perf stat -r4 chrt -f 10 ./i2c-test /dev/i2c-1 25000 0x40 0x6 0x1e 0x00
>
> Before:
> 	8.638705161 seconds time elapsed                  ( +-  5.90% )
> After:
> 	7.516821591 seconds time elapsed                  ( +-  0.11% )
>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 55 +++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 18 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
