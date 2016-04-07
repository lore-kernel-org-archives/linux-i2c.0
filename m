From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] i2c: designware-platdrv: get fast/std speed scl high/low
 count from DT
Date: Thu, 7 Apr 2016 12:57:59 -0500
Message-ID: <20160407175759.GO32257@rob-hp-laptop>
References: <1459927680-5480-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1459927680-5480-1-git-send-email-jszhang@marvell.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, wsa@the-dreams.de, linux-kernel@vger.kernel.org, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, galak@codeaurora.org, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 06, 2016 at 03:28:00PM +0800, Jisheng Zhang wrote:
> Sometimes, it's convenient to define the scl's high/low count directly,
> e.g HW people would do some measurement then directly give out the
> optimum counts. Previously, we solved the sda falling time and scl
> falling time by i2c_dw_scl_hcnt() and i2c_dw_scl_lcnt(), then put them
> into dt, but what we really care isn't the sda/scl falling time.

This is just so you can put specific clock count instead of converting 
from nanoseconds with standard properties or you gain some additional 
control of the timing. If only the former, then I prefer we stick with 
the common properties.

> From another side, the dw_i2c_acpi_configure() on ACPI platform also
> get hcnt/lcnt values rather than the sda/scl falling time from ACPI
> method, we want similar feature for DT platforms.

That's nice, but not really a reason IMO.

> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 16 ++++++++++++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c              |  8 ++++++++
>  2 files changed, 24 insertions(+)
