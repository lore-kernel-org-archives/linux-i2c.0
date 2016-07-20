From: Jan Kandziora <jjj@gmx.de>
Subject: Re: [PATCH 2/2] add w1_ds28e17 driver for the DS28E17 Onewire to I2C
 master bridge
Date: Wed, 20 Jul 2016 20:19:09 +0200
Message-ID: <578FC09D.8040706@gmx.de>
References: <578A95E4.1080903@gmx.de> <132011469036072@web17m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:63059 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbcGTSTO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Wed, 20 Jul 2016 14:19:14 -0400
In-Reply-To: <132011469036072@web17m.yandex.ru>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Am 20.07.2016 um 19:34 schrieb Evgeniy Polyakov:
> 
> Is that a hardware limitation that there is no interrupt or other
> completion mechanism which would handle this case?
> 
Ah, forgot to address that question.

The DS28E17 has a BUSY pin. We could add an interrupt-driven busy
mechanism but the mechanism without the interrupt line has to stay in
there because most people wouldn't add an interrupt line to their
Onewire installation just for having that.
