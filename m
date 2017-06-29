From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH][i2c-next] i2c: designware: fix spelling mistakes
Date: Thu, 29 Jun 2017 13:07:02 +0300
Message-ID: <1dacc13a-f857-d017-df1c-d7ac27022990@linux.intel.com>
References: <20170629082215.9044-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:33693 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751595AbdF2KHG (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 29 Jun 2017 06:07:06 -0400
In-Reply-To: <20170629082215.9044-1-colin.king@canonical.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On 06/29/2017 11:22 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Trivial fixes to spelling mistakes in dev_dbg message
>
> "STAUTS" -> "STATUS"
> "SLAVE_ACTTVITY" -> "SLAVE_ACTIVITY"
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/i2c/busses/i2c-designware-slave.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
