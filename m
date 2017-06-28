From: David Thomson <David.Thomson@alliedtelesis.co.nz>
Subject: Re: [PATCH] i2c: core: Prevent race condition when removing i2c
 devices
Date: Wed, 28 Jun 2017 22:20:52 +0000
Message-ID: <1498688452141.89697@alliedtelesis.co.nz>
References: <20170608024344.9311-1-david.thomson@alliedtelesis.co.nz>
 <20170619143656.zigxk77vegedscjx@ninjato>
 <24ee1e30-1737-e3ef-a23e-01d41a29d45f@axentia.se>,<2e4c5807-3d3c-1ce2-da35-3e37b2e3b08b@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42752 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbdF1WVE (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 28 Jun 2017 18:21:04 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A70E983646
        for <linux-i2c@vger.kernel.org>; Thu, 29 Jun 2017 10:20:55 +1200 (NZST)
In-Reply-To: <2e4c5807-3d3c-1ce2-da35-3e37b2e3b08b@axentia.se>
Content-Language: en-NZ
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi Peter=0A=
=0A=
Thanks for your reply. Unfortunately we cannot reproduce the issue on a new=
er kernel as it requires userspace applications (for processing the hotswap=
) that rely on our (many) changes to the kernel. I appreciate you taking th=
e time to consider the issue.=0A=
=0A=
Thanks=0A=
David=0A=
________________________________________=0A=
From: Peter Rosin <peda@axentia.se>=0A=
Sent: Tuesday, 20 June 2017 7:30 a.m.=0A=
To: Wolfram Sang; David Thomson=0A=
Cc: linux-i2c@vger.kernel.org=0A=
Subject: Re: [PATCH] i2c: core: Prevent race condition when removing i2c de=
vices=0A=
=0A=
On 2017-06-19 18:34, Peter Rosin wrote:=0A=
> It would certainly be nice to know why .owner is clobbered, because I=0A=
> don't see it. But then again, I don't know what sources I should be=0A=
> reading...=0A=
=0A=
BTW, one thing I noticed when reading the current code is that I see this=
=0A=
at the end of i2c_del_adapter:=0A=
=0A=
        /* Clear the device structure in case this adapter is ever going to=
 be=0A=
           added again */=0A=
        memset(&adap->dev, 0, sizeof(adap->dev));=0A=
}=0A=
EXPORT_SYMBOL(i2c_del_adapter);=0A=
=0A=
=0A=
which is not very compatible with this part of the device_add() docs:=0A=
=0A=
=0A=
 * Do not call this routine or device_register() more than once for=0A=
 * any device structure.  The driver model core is not designed to work=0A=
 * with devices that get unregistered and then spring back to life.=0A=
 * (Among other things, it's very hard to guarantee that all references=0A=
 * to the previous incarnation of @dev have been dropped.)  Allocate=0A=
 * and register a fresh new struct device instead.=0A=
=0A=
=0A=
That, of course, probably have no bearing on the problem/patch in this=0A=
thread...=0A=
=0A=
Or maybe struct device reuse is exactly what is going on???=0A=
=0A=
Cheers,=0A=
peda=0A=
