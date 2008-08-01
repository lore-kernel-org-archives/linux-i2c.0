From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] i2c-pxa: fastmode support
Date: Fri, 01 Aug 2008 11:12:19 +0100
Message-ID: <4892E183.7090601@cam.ac.uk>
References: <4891E0C5.7020009@cam.ac.uk>
	<20080801094257.GK26938@trinity.fluff.org>
	<4892E014.3040208@cam.ac.uk>
	<20080801100936.GB17442@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20080801100936.GB17442@flint.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Ben Dooks <ben-linux@fluff.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Russell King - ARM Linux wrote:
> On Fri, Aug 01, 2008 at 11:06:12AM +0100, Jonathan Cameron wrote:
>> Ben Dooks wrote:
>>> On Thu, Jul 31, 2008 at 04:56:53PM +0100, Jonathan Cameron wrote:
>>>> From: Jonathan Cameron <jic23@cam.ac.uk>
>>>>
>>>> Add fast_mode option to i2c_pxa_platform_data and use it to set the ICR_FM bit
>>>> appropriately when i2c_pxa_reset is called. Parameter called fast_mode rather
>>>> than frequency as this driver is also used for the i2c_pxa_pwr bus which has
>>>> different normal and fast frequencies.
>>>>
>>>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>>>> --
>>>> This is basically a repost of the original patch with use_pio and fast_mode converted
>>>> to bit fields as suggested / agreed by Eric Miao and Ben Dooks.
>>> please ensure your descriptions are wrapped to less than 77 characters
>>> per line.
>> Will do, sorry about that bit of carelessness.
> 
> Less than 72 is preferable - because tools (eg, git log) commonly prefix
> the comments with one tab.
Doh, emails crossed. I'll repost with 72 character limit in a sec!
> 
>> Not something I care about that much either way and I'm guessing by
>> the would be nice that you don't either. I'll repost the patch without.
> 
> Preferred without the space.
Thanks for clearing that up.
--
Jonathan


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
