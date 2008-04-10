From: Darius <augulis.darius@gmail.com>
Subject: Re: [PATCH V3] I2C driver for IMX
Date: Thu, 10 Apr 2008 13:33:35 +0300
Message-ID: <ftkqk1$hsa$1@ger.gmane.org>
References: <ftf8ud$pl6$1@ger.gmane.org>	<20080409232834.GG1197@trinity.fluff.org>	<Pine.LNX.4.64.0804092223540.10428@gate.crashing.org>
	<20080410120141.4d220d27@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20080410120141.4d220d27@hyperion.delvare>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> On Wed, 9 Apr 2008 22:25:39 -0500 (CDT), Kumar Gala wrote:
>> On Thu, 10 Apr 2008, Ben Dooks wrote:
>>
>>> On Tue, Apr 08, 2008 at 11:01:25AM +0300, Darius wrote:
>>>> changes:
>>>> 1. Removed hardcoded constants
>>>> 2. Fixed bug in chip hardware
>>>> 3. Added i2c device for mx1ads
>>>>
>>>> Tested with mx1ads v2.0 board and LCD on I2C interface driver
>>>>
>>>> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
>>>> ---
>>> Hmm, this hasn't appeared on the i2c list where it should be being
>>> reviewed before submission. Not bothered to look or snip the rest.
>> looking at this it seems the HW is identical to the driver handled by
>> i2c-mpc.c.  (which is used on Motorola and now Freescale PPC chips).
> 
> Then I guess that we want to add support to the i2c-mpc driver rather
> than adding another driver to the kernel tree?
> 

I prefer to use separate driver for imx i2c inteface.
if it's not needed for all, I'll leave it for my private needs.


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
