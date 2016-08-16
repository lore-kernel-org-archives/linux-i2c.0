From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 1/3] i2c: designware: wait for disable/enable only if
 necessary
Date: Tue, 16 Aug 2016 16:59:55 +0300
Message-ID: <bb134298-26de-c565-bf7a-78302914991f@linux.intel.com>
References: <1469743424-2480-1-git-send-email-lucas.demarchi@intel.com>
 <1469743424-2480-2-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:55753 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbcHPN77 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 16 Aug 2016 09:59:59 -0400
In-Reply-To: <1469743424-2480-2-git-send-email-lucas.demarchi@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas De Marchi <lucas.demarchi@intel.com>, linux-i2c@vger.kernel.org
Cc: christian.ruppert@alitech.com, linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, =?UTF-8?Q?Jos=c3=a9_Roberto_de_Souza?= <jose.souza@intel.com>, Wolfram Sang <wsa@the-dreams.de>

Hi, + Wolfram

On 07/29/2016 01:03 AM, Lucas De Marchi wrote:
> From: José Roberto de Souza <jose.souza@intel.com>
>
> If we aren't going to continue using the controller we can just disable
> it instead of waiting for it to complete. The biggest improvement here
> is when a I2C transaction is completed and it doesn't block until
> the adapter is disabled. When a new transfer is needed we will disable
> and wait for its completion.
>
> This way the adapter will continue changing its state in parallel to the
> execution of the thread that requested the I2C transaction saving most
> of the time 25~250 usec per I2C transaction.
>
> A simple program doing a register read (1 byte write, 1 byte read)
> alternating on 2 different slaves repeated 25k times for each and
> measurements taken 4 times we get:
>
> perf stat -r4 chrt -f 10 ./i2c-test /dev/i2c-1 25000 0x40 0x6 0x1e 0x00
>
> Before:
> 	30.879317977 seconds time elapsed                 ( +- 14.83% )
> After:
> 	8.638705161 seconds time elapsed                  ( +-  5.90% )
>
> Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
