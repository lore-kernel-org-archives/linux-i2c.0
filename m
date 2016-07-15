From: Jan Kandziora <jjj@gmx.de>
Subject: Re: Introducing a kernel driver for the DS28E17 Onewire to I2C master
 bridge; Feature request: introduce I2C_FUNC_STOP
Date: Fri, 15 Jul 2016 20:52:36 +0200
Message-ID: <578930F4.4080707@gmx.de>
References: <578612EB.1060709@gmx.de> <20160714095812.GA1563@tetsubishi>
 <57878B55.1030200@gmx.de> <20160714131921.GE4149@tetsubishi>
 <5788C54C.20705@gmx.de> <20160715112559.GA1695@tetsubishi>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:54782 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbcGOSwk (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Fri, 15 Jul 2016 14:52:40 -0400
In-Reply-To: <20160715112559.GA1695@tetsubishi>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org

Am 15.07.2016 um 13:26 schrieb Wolfram Sang:
>
> I would say no, since it is not generic.
>
> You should also populate an i2c_adapter_quirks structure and limit
> reads to 256 (and maybe other stuff), if not done already.
>
I found that feature is new when trying to compile my driver on 3.16.7.

What's the correct way to test for struct i2c_adapter_quirks et al?

#ifdef I2C_AQ_COMB
...
#endif

Something else?


Kind regards

	Jan
