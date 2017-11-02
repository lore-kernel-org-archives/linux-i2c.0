From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v5 7/7] i2c: remove legacy integer scl/sda gpio for
 recovery
Date: Thu, 2 Nov 2017 17:23:21 +0200
Message-ID: <64a65555-2eda-89d7-337b-ec1a8d66743f@linux.intel.com>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
 <1509590430-11968-8-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1509590430-11968-8-git-send-email-preid@electromag.com.au>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Phil Reid <preid@electromag.com.au>, nsekhar@ti.com, khilman@kernel.org, wsa@the-dreams.de, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 11/02/2017 04:40 AM, Phil Reid wrote:
> Remove all reference to code related to using integer based ids for
> scl/sda gpio for bus recovery. All in tree drivers are now using the
> gpio descriptors to specific the required gpios.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>   drivers/i2c/i2c-core-base.c | 78 ++-------------------------------------------
>   include/linux/i2c.h         |  7 +---
>   2 files changed, 3 insertions(+), 82 deletions(-)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
