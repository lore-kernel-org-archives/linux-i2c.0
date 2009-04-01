From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: [PATCH 1/5] I2C driver for MXC
Date: Wed, 1 Apr 2009 13:57:03 +0200
Message-ID: <200904011357.03226.hs4233@mail.mn-solutions.de>
References: <49C89E13.7040801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <49C89E13.7040801@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Darius <augulis.darius@gmail.com>, linux-i2c@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: linux-i2c@vger.kernel.org

Hi Darius !

I can confirm that your driver works on my i.MX21 device with two 
pca9535 chips. However, I had to add a patch to make it usable, 
which I'll send in a minute.

Greetings,
Holger




-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
