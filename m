From: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: Sensor with 7 bit address above 0x77
Date: Mon, 27 Jun 2016 15:38:02 +0200
Message-ID: <dafe2d59-1a23-67cc-6a2a-50a43d0325f1@sigma-star.at>
References: <17002e23-eaf4-125c-9402-4def2bf13e51@sigma-star.at>
 <20160627121319.GA1648@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:45996 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbcF0Ni0 (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 27 Jun 2016 09:38:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sigma-star.at (Postfix) with ESMTP id 7F17216B4335
	for <linux-i2c@vger.kernel.org>; Mon, 27 Jun 2016 15:38:23 +0200 (CEST)
In-Reply-To: <20160627121319.GA1648@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Richard Weinberger <richard@sigma-star.at>

On 06/27/2016 02:13 PM, Wolfram Sang wrote:
> Please read the above specification to understand how 10 bit addresses
> are transferred over the wire. I think reading it will answer most of
> your questions.

Wikipedia brought me to this PDF file here:
http://www.nxp.com/documents/user_manual/UM10204.pdf

Section 3.1.11 "10-bit addressing" along with section 3.1.12 "Reserved
addresses" indeed specify that the 7 bit addresses 0x78-0x7B are reserved
for 10 bit addressing.

The way it is written in the spec (1111 0XX) probably caused people to
confuse it for 0xF0-0xF3 which I found in some messages on the mailing
list.

But that still leaves the question of where the 0xA... in the kernel docs
came from.


>> Is there a specific reason I can override i2cdetect but not i2cdump?
> 
> Probably not. More likely, nobody needed it until now. Which is
> understandable since the device you have has to be considered broken
> regarding the I2C standard. But I think patches adding that could be
> acceptable. Jean has the last word on this.
> 

Section 3.1.12 ends with some musings about the assignment of addresses in
"local systems". More specifically, it ends with the sentence "If it is known
that the reserved address is never going to be used for its intended purpose,
a reserved address can be used for a slave address."

I _do_ know that there are no 10 bit addressed slaves in my application, so
the spec allows me to use at those 4 slave address. Apparently it is not my
device that is broken.
