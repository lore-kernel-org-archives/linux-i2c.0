From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 08/27] i2c: busses: remove memset after
 dmam_alloc_coherent
Date: Fri, 28 Jun 2019 09:22:31 +0300
Message-ID: <f97d130f-0906-05cb-6f08-bb84bf32ff02@linux.intel.com>
References: <20190628024711.15203-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190628024711.15203-1-huangfq.daxian@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi

On 6/28/19 5:47 AM, Fuqian Huang wrote:
> In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
> dmam_alloc_coherent has already zeroed the memory.
> So memset is not needed.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>   drivers/i2c/busses/i2c-ismt.c | 2 --
>   1 file changed, 2 deletions(-)
> 
It would be better to refer actual commit or commits that implement that 
zeroing rather than merge point in commit log if possible.

At quick look commit 518a2f1925c3 ("dma-mapping: zero memory returned 
from dma_alloc_*") is the one but I'm not really an expert here to say 
is that alone enough.

-- 
Jarkko
