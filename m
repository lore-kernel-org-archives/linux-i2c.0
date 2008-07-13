From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] gpio: max732x: add support for MAX7319, MAX7320-7327
	I2C Port Expanders
Date: Sun, 13 Jul 2008 08:55:54 +0200
Message-ID: <20080713085554.335a048b@hyperion.delvare>
References: <4875A893.3090402@gmail.com>
	<200807120046.29389.david-b@pacbell.net>
	<20080712095300.1ba4b3a7@hyperion.delvare>
	<200807121442.30693.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <200807121442.30693.david-b@pacbell.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: David Brownell <david-b@pacbell.net>
Cc: Jack Ren <jack.ren@marvell.com>, i2c@lm-sensors.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-i2c@vger.kernel.org

On Sat, 12 Jul 2008 14:42:30 -0700, David Brownell wrote:
> On Saturday 12 July 2008, Jean Delvare wrote:
> > On Sat, 12 Jul 2008 00:46:29 -0700, David Brownell wrote:
> > > On Saturday 12 July 2008, Jean Delvare wrote:
> > > > > Why not just insist the 0x5x address be registered/probed?  This
> > > > > extra stuff is needless and confusing.
> > > > 
> > > > Because some of the chips supported by this driver (max7319, max7321,
> > > > max7322 and max7323) only use address 0x6x.
> > > 
> > > That's not the behavior implemented here though ... it's always
> > > creating a dummy, even when it's not needed.
> > 
> > Did you miss this comment of mine maybe?
> > http://lists.lm-sensors.org/pipermail/i2c/2008-July/004267.html
> 
> Server not responding; can't tell.  Using the MARC.info archive [1]
> what message is that?  Are you disagreeing with what I said?
> 
> [1] http://marc.info/?t=121567059700001&r=1&w=2

http://marc.info/?l=i2c&m=121577504211597&w=2

No, I didn't disagree. In fact you were merely repeating what I had
already written ;) so I wanted you to read my comment so you knew you
didn't have to convince me.

-- 
Jean Delvare

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
