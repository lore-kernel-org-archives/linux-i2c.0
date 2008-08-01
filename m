From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] i2c-pxa: fastmode support
Date: Fri, 01 Aug 2008 10:49:24 +0100
Message-ID: <4892DC24.6040204@cam.ac.uk>
References: <4891E0C5.7020009@cam.ac.uk>
	<f17812d70807311829v241fce7fk23d7ff372022a342@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <f17812d70807311829v241fce7fk23d7ff372022a342@mail.gmail.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux@arm.linux.org.uk, linux-arm-kernel@lists.arm.linux.org.uk, Ben Dooks <ben-linux@fluff.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

Eric Miao wrote:
>> This is basically a repost of the original patch with use_pio and fast_mode converted
>> to bit fields as suggested / agreed by Eric Miao and Ben Dooks.
>>
> 
> It's generally better to use "unsigned int" for bit field please. Otherwise OK.
Good point! Concept of a 1 bit signed integer is a bit odd to say the least ;)

Patch repost with that (and Ben's point about description length) fixed shortly.

Cheers,
--
Jonathan Cameron


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
