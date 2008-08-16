From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [i2c] [RFC] PXA3xx: Add support for power i2c bus
Date: Sat, 16 Aug 2008 09:41:27 +0100
Message-ID: <20080816084126.GB5946@flint.arm.linux.org.uk>
References: <48A3F2EB.8030809@compulab.co.il>
	<20080814103956.GB4610@flint.arm.linux.org.uk>
	<48A41921.7020306@compulab.co.il>
	<20080814130709.GH2716@fluff.org.uk>
	<48A43671.6000302@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <48A43671.6000302@compulab.co.il>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Mike Rapoport <mike@compulab.co.il>
Cc: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, Ben Dooks <ben-linux@fluff.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Aug 14, 2008 at 04:43:13PM +0300, Mike Rapoport wrote:
> This is really much nicer. The fixed patch follows:
> 
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> 
>  arch/arm/mach-pxa/devices.h          |    1 +
>  arch/arm/mach-pxa/include/mach/i2c.h |    6 ++++-
>  arch/arm/mach-pxa/pxa27x.c           |    2 +-
>  arch/arm/mach-pxa/pxa3xx.c           |   45 ++++++++++++++++++++++++++++++++++
>  drivers/i2c/busses/i2c-pxa.c         |   12 +++++----
>  5 files changed, 59 insertions(+), 7 deletions(-)

Ok.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
