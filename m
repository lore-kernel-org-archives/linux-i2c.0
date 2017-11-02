From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v5 6/7] i2c: davinci: switch to using gpiod for bus
 recovery gpios
Date: Thu, 2 Nov 2017 20:45:21 +0530
Message-ID: <62ea3116-f909-2a80-dcd7-df03a82973bf@ti.com>
References: <1509590430-11968-1-git-send-email-preid@electromag.com.au>
 <1509590430-11968-7-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1509590430-11968-7-git-send-email-preid@electromag.com.au>
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
To: Phil Reid <preid@electromag.com.au>, khilman@kernel.org, wsa@the-dreams.de, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 02 November 2017 08:10 AM, Phil Reid wrote:
> Change the driver to use the gpio descriptors for the bus recovery
> information instead of the deprecated integer interface.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Phil Reid <preid@electromag.com.au>

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
