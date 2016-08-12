From: Christian Ruppert <christian.ruppert@alitech.com>
Subject: Re: [PATCH v3 0/3] i2c: designware: improve performance for transfers
Date: Fri, 12 Aug 2016 16:59:32 +0200
Message-ID: <28c393bf-416b-b406-ff39-a2d85317a102@alitech.com>
References: <1469743424-2480-1-git-send-email-lucas.demarchi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1469743424-2480-1-git-send-email-lucas.demarchi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas De Marchi <lucas.demarchi@intel.com>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com, jarkko.nikula@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

On 29.07.2016 00:03, Lucas De Marchi wrote:
> This can be considered a v3 of "i2c: designware: do not disable adapter after
> transfer". Differences are:
> 
>     - Now there's a first patch that does not depend on IC_TAR being dynamically
>       enabled/disabled: it just doesn't wait for the state change when not needed.
> 
>     - We added a patch that allows detecting if HW supports the dynamic TAR updates
> 
>     - In the last patch the bits were changed as suggested by Jarkko.
> 
>     - This is tested on BayTrail and CherryTrail, both of them returning true for
>       "dynamically update TAR"

Tested-by: Christian Ruppert <christian.ruppert@alitech.com>
on TB101 with Linux-4.7

Seems to work perfectly now, congratulations and thanks for your
patience with our platform... This was a hard one!

> José Roberto de Souza (1):
>   i2c: designware: wait for disable/enable only if necessary
> 
> Lucas De Marchi (2):
>   i2c: designware: detect when dynamic tar update is possible
>   i2c: designware: do not disable adapter after transfer
> 
>  drivers/i2c/busses/i2c-designware-core.c | 103 +++++++++++++++++++++----------
>  drivers/i2c/busses/i2c-designware-core.h |   1 +
>  2 files changed, 72 insertions(+), 32 deletions(-)
> 
