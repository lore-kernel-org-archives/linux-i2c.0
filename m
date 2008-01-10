From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c]  [PATCH 2/2] [resend] Add polling transfer for i2c-pxa
Date: Thu, 10 Jan 2008 11:24:13 +0100
Message-ID: <20080110112413.3b379781@hyperion.delvare>
References: <476A7761.3050103@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <476A7761.3050103@compulab.co.il>
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
Cc: eric miao <eric.miao@marvell.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, i2c@lm-sensors.org, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: linux-i2c@vger.kernel.org

Hi Mike,

On Thu, 20 Dec 2007 16:08:33 +0200, Mike Rapoport wrote:
> The below patch adds polling I2C transfer implementation for PXA I2C.

This patch doesn't apply on top of my current stack, most probably due
to a conflict with this patch by Eric Miao:

http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-pxa-use-cpu_is_pxa27x.patch

Can you please update your patch so that it applies cleanly on top of
2.6.24-rc7 + the patch above?

Thanks,
-- 
Jean Delvare

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
