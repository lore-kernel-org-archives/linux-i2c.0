From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v4 0/4] i2c: designware: improve performance for transfers
Date: Wed, 24 Aug 2016 13:31:11 +0300
Message-ID: <638ba8ea-4817-a255-7937-c48b305ad999@linux.intel.com>
References: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50708 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754059AbcHXKdJ (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 24 Aug 2016 06:33:09 -0400
In-Reply-To: <1471990736-30190-1-git-send-email-lucas.demarchi@intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lucas De Marchi <lucas.demarchi@intel.com>, linux-i2c@vger.kernel.org
Cc: Christian Ruppert <christian.ruppert@alitech.com>, mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On 08/24/2016 01:18 AM, Lucas De Marchi wrote:
> Diff from v3:
>
>     - Fix over 80chars in one place
>
>     - Move check for adapter being able to dynamically update TAR to be done
>       on probe time rather than init as requested by Jarkko
>
> For the previous version, Christian had added:
>
> Tested-by: Christian Ruppert <christian.ruppert@alitech.com>
> on TB101 with Linux-4.7
>
> And Jarkko added his Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> on patches 1 and 3 (now 4).
>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
