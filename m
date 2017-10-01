From: Jan Kandziora <jjj@gmx.de>
Subject: Re: [PATCH v5 2/2] add w1_ds28e17 driver for the DS28E17 Onewire to
 I2C master bridge
Date: Sun, 1 Oct 2017 15:13:54 +0200
Message-ID: <10c2aacc-e226-b545-dcb1-ee5a56ff67a4@gmx.de>
References: <20170920215246.5821-1-jjj@gmx.de>
 <20170920215246.5821-2-jjj@gmx.de> <155871506837717@web6g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:54024 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbdJANN7 (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 1 Oct 2017 09:13:59 -0400
In-Reply-To: <155871506837717@web6g.yandex.ru>
Content-Language: de-DE
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>, GregKH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Linux-I2C <linux-i2c@vger.kernel.org>

Am 01.10.2017 um 08:01 schrieb Evgeniy Polyakov:
> Hi Jan, Greg
> 
> Have you resolved issues with the patch (touch bit export and driver itself)?
> This driver lives outside the kernel quite for a while, do you need any help to resolve this?
> 
I hope so. I've set up 4.14-rc1, changed my patches so it compiled, then
checked whether it still works. It does.

Kind regards

	Jan
